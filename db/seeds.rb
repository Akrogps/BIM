# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

# Restaurant.reindex
Restaurant.destroy_all
User.destroy_all

host1 = User.create!(first_name: "Francois", last_name: "Damiens", username: "Embrouille", host: true, email: "baudouin@renie.org", password: "123456")
host2 = User.create!(first_name: "Jack", last_name: "Daniels", username: "Jackkk", host: true, email: "ponzga@gmail.com", password: "123456")
visitor1 = User.create!(first_name: "Noel", last_name: "Flantier", username: "OSS", host: false, email: "adrien15b@gmail.com", password: "123456")

12.times do
  attributes = {
    name: Faker::Restaurant.unique.name,
    address: Faker::Address.unique.full_address,
    description: Faker::Book.unique.title,
    content: Faker::Restaurant.unique.description,
    website: Faker::Internet.unique.url,
    opening_hours: "From Monday To Tuesday, from 9am to 9pm" ,
    phone_number: Faker::PhoneNumber.phone_number ,
    price_indication: ["€", "€€", "€€€", "€€€€"].sample
  }

  restaurant = Restaurant.new(attributes)
  restaurant.user = [host1, host2].sample
  restaurant.save!

  url = "https://source.unsplash.com/random/1600x900/?restaurant"

  image = restaurant.images.new
  image.remote_cloudinary_url_url = url
  image.save
end
