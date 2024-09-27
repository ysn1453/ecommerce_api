# frozen_string_literal: true

module Mutations
  class AddToCart < BaseMutation
    argument :customer_id, ID, required: true
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true

    field :cart_item, Types::CartItemType, null: true
    field :errors, [ String ], null: false

    def resolve(customer_id:, product_id:, quantity:)
      customer = Customer.find(customer_id)
      product = Product.find(product_id)

      # Stok kontrolü
      return {
        cart_item: nil,
        errors: [ "Not enough stock!" ]
      } if product.stock < quantity

      cart = customer.cart || customer.create_cart
      cart_item = cart.cart_items.find_or_initialize_by(product: product)
      cart_item.quantity = quantity

      if cart_item.save
        {
          cart_item: cart_item,
          errors: []
        }
      else
        {
          cart_item: nil,
          errors: cart_item.errors.full_messages
        }
      end
    end
  end
end
