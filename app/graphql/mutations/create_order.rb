# frozen_string_literal: true

module Mutations
  class CreateOrder < BaseMutation
    argument :customer_id, ID, required: true

    field :order, Types::OrderType, null: true
    field :errors, [ String ], null: false

    def resolve(customer_id:)
      customer = Customer.find(customer_id)
      cart = customer.cart

      return {
        order: nil,
        errors: [ "Cart is empty" ]
      } if cart.nil? || cart.cart_items.empty?

      ActiveRecord::Base.transaction do
        cart_items = cart.cart_items.includes(:product)

        order = Order.create!(
          customer: customer,
          total_price: cart_items.sum { |cart_item| cart_item.product.price * cart_item.quantity }
        )

        cart_items.each do |cart_item|
          product = cart_item.product.lock!
          if product.stock < cart_item.quantity
            raise ActiveRecord::Rollback, "Not enough stock for #{product.name}"
          end

          OrderItem.create!(
            order: order,
            product: product,
            quantity: cart_item.quantity,
            price: product.price
          )

          # Stok bilgisini güncelle.
          product.update!(stock: product.stock - cart_item.quantity)
        end

        # Sipariş başarılı ise sepet içeriğini sil
        cart_items.each(&:destroy!)

        # TODO: E-posta gönderme işlemi yapılacak
        OrderMailer.with(order: order).order_confirmation.deliver_later

        {
          order: order,
          errors: []
        }
      end
    rescue ActiveRecord::RecordInvalid => e
      {
        order: nil,
        errors: [ e.message ]
      }
    end
  end
end
