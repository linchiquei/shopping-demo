# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  total            :integer          default(0)
#  user_id          :integer
#  billing_name     :string
#  billing_address  :string
#  shipping_name    :string
#  shipping_address :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  token            :string
#  is_paid          :boolean          default(FALSE)
#  payment_method   :string
#  aasm_state       :string           default("order_placed")
#
class Order < ApplicationRecord

  before_create :generate_token
  #scope :find_token, -> (token) { find_by('token = ?', token) }

  belongs_to :user
  has_many :product_lists

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  include AASM
  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :order_apply_cancel
    state :good_returned

    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid, to: :shipping
    end

    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    #商家可以直接申請退訂單
    event :cancel_order do
      transitions from: [:order_placed, :paid, :order_apply_cancel], to: :order_cancelled
    end

    #使用者提出申請
    event :order_apply_cancel do
      transitions from: :order_placed, to: :order_apply_cancel
    end
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def pay!
    self.update_columns(is_paid: true)
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end
end
