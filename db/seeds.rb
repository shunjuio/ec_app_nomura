# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  #Fakerの名前が、"firstname lastname"の形式で返ってくるので、splitで分割して配列にする.
  name = Faker::Name.name.split(" ")

  Member.create!(
    last_name: name[1],
    first_name: name[0],
    email: "email#{n + 1}@example.com",
    password: "password"
  )
end