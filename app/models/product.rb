class Product < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  has_many_attached :images

  def self.search(query)
    if query.present?
      where("name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end