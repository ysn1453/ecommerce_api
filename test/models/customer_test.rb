require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  def setup
    @valid_customer = Customer.new(name: "Yasin Test", email: "ysn1@localhost.com", phone: "5522345678")
  end

  test "valid customer" do
    assert @valid_customer.valid?
  end

  test "invalid without name" do
    @valid_customer.name = nil
    assert_not @valid_customer.valid?
    assert_not_nil @valid_customer.errors[:name]
  end

  test "invalid without email" do
    @valid_customer.email = nil
    assert_not @valid_customer.valid?
    assert_not_nil @valid_customer.errors[:email]
  end

  test "invalid without phone" do
    @valid_customer.phone = nil
    assert_not @valid_customer.valid?
    assert_not_nil @valid_customer.errors[:phone]
  end

  test "invalid with duplicate email" do
    duplicate_customer = @valid_customer.dup
    @valid_customer.save
    assert_not duplicate_customer.valid?
    assert_not_nil duplicate_customer.errors[:email]
  end
end
