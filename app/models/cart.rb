class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :delete_all
end
