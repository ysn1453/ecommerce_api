# frozen_string_literal: true

module Types
  class OrderItemType < Types::BaseObject
    field :id, ID, null: false
    field :order, Types::OrderType, null: false
    field :product, Types::ProductType, null: false
    field :quantity, Integer, null: false
    field :price, Float, null: false
  end
end
