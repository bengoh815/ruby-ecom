class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum status: { pending: 0, processing: 1, completed: 2, cancelled: 3 }

  # Add validations if needed
  validates :total_price, presence: true
end