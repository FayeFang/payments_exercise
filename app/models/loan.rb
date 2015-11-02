# == Schema Information
#
# Table name: loans
#
#  id            :integer          not null, primary key
#  funded_amount :decimal(8, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Loan < ActiveRecord::Base
  has_many :payments

  validates :funded_amount, presence: true, numericality: { greater_than: 0 }

  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end
end
