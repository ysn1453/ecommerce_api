class OrderMailer < ApplicationMailer
  default from: "orders@ecommerce.com"

  def order_confirmation
    @order = params[:order]
    @customer = @order.customer
    mail(to: @customer.email, subject: "Order Confirmation")
  end

  def order_shipped
    @order = params[:order]
    @customer = @order.customer
    mail(to: @customer.email, subject: "Your Order Has Been Shipped")
  end
end
