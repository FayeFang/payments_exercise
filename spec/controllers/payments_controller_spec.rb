require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  let!(:loan) { FactoryGirl.create(:loan) }
  let!(:payment) { FactoryGirl.create(:payment, loan: loan) }

  describe '#index' do
    it 'responds with a 200' do
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end

    it 'should show all payments for the loan' do
      get :index, loan_id: loan.id
      payments = JSON.parse(response.body)
      expect(payments.count).to eq(1)
    end
  end

  describe '#create' do
    context 'if all input is valid and proper' do
      it 'responds with a 201' do
        payment_params = {amount: payment.amount,
                          post_at: payment.post_at}

        post :create, loan_id: loan.id, payment: payment_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'if payment amount exceeds outstanding balance' do
      it 'responds with a 400' do
        payment_params = {amount: loan.funded_amount + 10_000.0,
                          post_at: payment.post_at}

        post :create, loan_id: loan.id, payment: payment_params
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns validation errors' do
        payment_params = {amount: loan.funded_amount + 10_000.0,
                          post_at: payment.post_at}

        post :create, loan_id: loan.id, payment: payment_params
        expect(response.body).to eq("Amount can't exceed outstanding balance.")
      end
    end

    context 'if post date is in the past' do
      it 'responds with a 400' do
        payment_params = {amount: payment.amount,
                          post_at: payment.post_at - 1.year}

        post :create, loan_id: loan.id, payment: payment_params
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns validation errors' do
        payment_params = {amount: payment.amount,
                          post_at: payment.post_at - 1.year}

        post :create, loan_id: loan.id, payment: payment_params
        expect(response.body).to eq("Post at can't be in the past.")
      end
    end

    context 'if loan is not found' do
      it 'responds with a 404' do
        payment_params = {amount: payment.amount,
                          post_at: payment.post_at}

        post :create, loan_id: 10_000, payment: payment_params
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#show' do
    it 'responds with a 200' do
      get :show, loan_id: loan.id, id: payment.id
      expect(response).to have_http_status(:ok)
    end

    context 'if payment is not found' do
      it 'responds with a 404' do
        get :show, loan_id: loan.id, id: 100_000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
