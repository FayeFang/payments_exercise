# == Schema Information
#
# Table name: loans
#
#  id            :integer          not null, primary key
#  funded_amount :decimal(8, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Loan, type: :model do
  subject { FactoryGirl.create(:loan) }

  it { should have_many(:payments) }

  describe '.funded_amount' do
    it 'should be larger than 0' do
      expect(subject.funded_amount).to be > 0
    end
  end

  describe '.outstanding_balance' do
    it 'should be no smaller than 0' do
      expect(subject.outstanding_balance).to be >= 0
    end

    it 'should be the difference between funded amount and total payments' do
      5.times { FactoryGirl.create(:payment, loan: subject, amount: 100.0)}

      expect(subject.outstanding_balance).to eq(subject.funded_amount - 500.0)
    end
  end
end