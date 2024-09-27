# frozen_string_literal: true

module Mutations
  class CreateCustomer < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :phone, String, required: true

    field :customer, Types::CustomerType, null: true
    field :errors, [ String ], null: false

    def resolve(name:, email:, phone:)
      customer = Customer.new(name: name, email: email, phone: phone)

      if customer.save
        {
          customer: customer,
          errors: []
        }
      else
        {
          customer: nil,
          errors: customer.errors.full_messages
        }
      end
    end
  end
end
