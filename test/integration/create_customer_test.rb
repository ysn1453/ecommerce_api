require "test_helper"

class CreateCustomerTest < ActionDispatch::IntegrationTest
  test "create a new customer" do
    mutation = <<~GQL
      mutation {
        createCustomer(input: {
          name: "Yasin Test41"
          email: "ysn41@localhost.com"
          phone: "1234561453"
        }) {
          customer {
            id
            name
            email
            phone
          }
          errors
        }
      }
    GQL

    post "/graphql", params: { query: mutation }

    json_response = JSON.parse(@response.body)
    data = json_response["data"]["createCustomer"]

    assert_empty data["errors"]
    assert_equal "Yasin Test41", data["customer"]["name"]
    assert_equal "ysn41@localhost.com", data["customer"]["email"]
    assert_equal "1234561453", data["customer"]["phone"]
    assert_equal 1, Customer.where(email: "ysn41@localhost.com").count
  end

  test "fail to create a customer with uniq and blank data" do
    mutation = <<~GQL
      mutation {
        createCustomer(input: {
          name: ""
          email: "ysn2test@localhost.com"
          phone: ""
        }) {
          customer {
            id
            name
            email
            phone
          }
          errors
        }
      }
    GQL

    post "/graphql", params: { query: mutation }

    json_response = JSON.parse(@response.body)
    data = json_response["data"]["createCustomer"]

    assert_nil data["customer"]
    assert_includes data["errors"], "Name doldurulmalı"
    assert_includes data["errors"], "Email hali hazırda kullanılmakta"
    assert_includes data["errors"], "Phone doldurulmalı"
    assert_equal 2, Customer.count
  end
end
