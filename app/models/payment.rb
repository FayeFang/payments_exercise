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

class Payment < ActiveRecord::Base
  belongs_to :loan

  validates_presence_of :loan_id
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_cannot_exceed_outstanding_balance, :post_at_cannot_be_in_the_past

  private

  def amount_cannot_exceed_outstanding_balance
    errors.add(:amount, "can't exceed outstanding balance") if amount > loan.outstanding_balance
  end

  def post_at_cannot_be_in_the_past
    errors.add(:post_at, "can't be in the past") if !post_at.present? || post_at < Date.today
  end
end
