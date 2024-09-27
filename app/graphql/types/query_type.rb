# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :products, [ Types::ProductType ], null: false

    def products
      Product.all
    end

    field :customer, Types::CustomerType, null: true do
      argument :id, ID, required: true
    end

    def customer(id:)
      Customer.find(id)
    end

    field :customer_orders, [ Types::OrderType ], null: true do
      argument :customer_id, ID, required: true
    end

    def customer_orders(customer_id:)
      Customer.find_by(id: customer_id)&.orders || []
    end
  end
end
