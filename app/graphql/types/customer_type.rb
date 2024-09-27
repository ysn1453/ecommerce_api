# frozen_string_literal: true

module Types
  class CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :phone, String, null: false
    field :orders, [ Types::OrderType ], null: true
    field :cart, Types::CartType, null: true
  end
end
