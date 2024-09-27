require "test_helper"

class OrderCreationTest < ActionDispatch::IntegrationTest
  def setup
    @customer = Customer.create(name: "Yasin Test", email: "ysn22@localhost.com", phone: "5251234567")
    @product1 = Product.create(name: "Product1", price: 10.00, stock: 5)
    @product2 = Product.create(name: "Product2", price: 15.00, stock: 3)
  end

  test "create an order from cart items" do
    # Add items to cart
    add_to_cart_mutation = <<~GQL
      mutation {
        addToCart(input: {
          customerId: "#{@customer.id}"
          productId: "#{@product1.id}"
          quantity: 2
        }) {
          errors
        }
      }
    GQL

    post "/graphql", params: { query: add_to_cart_mutation }

    add_to_cart_mutation = <<~GQL
      mutation {
        addToCart(input: {
          customerId: "#{@customer.id}"
          productId: "#{@product2.id}"
          quantity: 1
        }) {
          errors
        }
      }
    GQL

    post "/graphql", params: { query: add_to_cart_mutation }

    # Create order
    create_order_mutation = <<~GQL
      mutation {
        createOrder(input: {
          customerId: "#{@customer.id}"
        }) {
          order {
            id
            totalPrice
            orderItems {
              product {
                id
                name
              }
              quantity
              price
            }
          }
          errors
        }
      }
    GQL

    post "/graphql", params: { query: create_order_mutation }

    #p @response.body
    json_response = JSON.parse(@response.body)
    data = json_response["data"]["createOrder"]

    assert_empty data["errors"]
    assert_equal 35.00, data["order"]["totalPrice"]
    assert_equal 2, data["order"]["orderItems"].length
    assert_equal 3, Product.find(@product1.id).stock
    assert_equal 2, Product.find(@product2.id).stock
  end
end
