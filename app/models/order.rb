class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # Add validations if needed
  validates :total_price, presence: true
end