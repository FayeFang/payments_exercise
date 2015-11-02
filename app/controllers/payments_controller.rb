class PaymentsController < ApplicationController
  before_filter :set_loan

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: @loan.payments
  end

  def create
    payment_params = params.require(:payment).permit(:amount, :post_at)
    @payment = @loan.payments.new(payment_params)

    if @payment.save
      render json: @payment, status: :created
    else
      render json: "#{@payment.errors.full_messages.join('. ')}.", status: :bad_request
    end
  end

  def show
    render json: @loan.payments.find(params[:id])
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end
