class Customer < ApplicationRecord
  has_many :orders
  has_one :cart

  validates :name, :email, :phone, presence: true
  validates :email, :phone, uniqueness: true

  default_scope { order(:name) }
end
