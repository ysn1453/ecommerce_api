require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @valid_product = Product.new(name: "Test Product", price: 10.00, stock: 100)
  end

  test "valid product" do
    assert @valid_product.valid?
  end

  test "invalid without name" do
    @valid_product.name = nil
    assert_not @valid_product.valid?
    assert_not_nil @valid_product.errors[:name]
  end

  test "invalid without price" do
    @valid_product.price = nil
    assert_not @valid_product.valid?
    assert_not_nil @valid_product.errors[:price]
  end

  test "invalid without stock" do
    @valid_product.stock = nil
    assert_not @valid_product.valid?
    assert_not_nil @valid_product.errors[:stock]
  end

  test "invalid with negative price" do
    @valid_product.price = -10.00
    assert_not @valid_product.valid?
    assert_not_nil @valid_product.errors[:price]
  end

  test "invalid with negative stock" do
    @valid_product.stock = -100
    assert_not @valid_product.valid?
    assert_not_nil @valid_product.errors[:stock]
  end
end
