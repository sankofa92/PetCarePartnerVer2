# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times { 
    #sitter
    email = Faker::Internet.email
    name = Faker::Name.unique.name
    slogan = Faker::Lorem.paragraph(2, true)
    price = Faker::Number.number(3)
    pet = Faker::Number.number(1)
    Sitter.create(name: name ,email: email, password: '123456', slogan:slogan, address:'臺北市中正區', price:price, pet_limit: pet)
    
    #Booking_date
    sitterid = Faker::Number.number(1)
    # BookingDate.create(sitter_id:sitterid, date: '24/11/2018', available: false)
}
