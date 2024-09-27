class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :delete_all

  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order(created_at: :desc) }
end
