# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :decimal(8, 2)
#  post_at    :date
#  loan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Payment, type: :model do

  let!(:loan) { FactoryGirl.create(:loan) }
  subject(:payment) { FactoryGirl.create(:payment, loan: loan) }

  describe 'ActiveRecord assoications' do
    it { should belong_to(:loan) }
  end

  describe 'ActiveModel validations' do

    #basic validations on attributes
    it { should validate_presence_of(:loan_id) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    # describe '.amount' do

    #   it 'should not exceed outstanding balance' do
    #     expect(payment.amount).to be <= loan.outstanding_balance
    #   end
    # end

    # describe '.post_at' do

    #   it 'should not be in the past' do
    #     expect(payment.post_at).to be >= Date.today
    #   end
    # end
  end
end