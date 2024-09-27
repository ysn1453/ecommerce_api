# frozen_string_literal: true

module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :customer, Types::CustomerType, null: false
    field :total_price, Float, null: false
    field :order_items, [ Types::OrderItemType ], null: true
  end
end
