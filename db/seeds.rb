# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless Customer.where(email: "yasin@localhost.com").exists?
  begin
    Customer.transaction do
      5.times do |i|
        Product.create(
          name: "Product - #{i+1}",
          price: rand(10..100),
          stock: 20
          )
      end

      Customer.create(
        name: "Yasin Pehlivanlı",
        email: "yasin@localhost.com",
        phone: "5123456789"
      )

      p "Customer and Products create OK"
    end
  rescue Exception => e
    p "Hata: #{e.message}"
    return
  end
end
