# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_customer, mutation: Mutations::CreateCustomer
    field :add_to_cart, mutation: Mutations::AddToCart
    field :create_order, mutation: Mutations::CreateOrder
  end
end
