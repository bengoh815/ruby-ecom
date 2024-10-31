class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Run set_default_role before saving a user
  before_save :set_default_role

  # Role-based access methods
  def admin?
    role == 'admin'
  end

  def regular?
    role == 'regular'
  end

  private

  def set_default_role
    self.role ||= 'regular'  # Sets role to 'regular' if it's not already set
  end
end
