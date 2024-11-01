class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :set_default_role
  after_create :initialize_cart 

  # Role-based access methods
  def admin?
    role == 'admin'
  end

  def regular?
    role == 'regular'
  end

  has_one :cart, dependent: :destroy

  private

  def set_default_role
    self.role ||= 'regular'  # Sets role to 'regular' if it's not already set
  end

  def initialize_cart
    create_cart unless cart.present?
  end
end
