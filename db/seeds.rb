# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
    user = User.new({
        name: Faker::FunnyName.name,
        phone_number: Faker::PhoneNumber.phone_number,
        is_walker: true,
        walker_age: rand(19..35),
        walker_description: Faker::Movie.quote,
        zip_code: [610000, 610012, 610013, 610043, 610036].sample,
        walker_img: Faker::Internet.url
    })
    user.save
end

10.times do
    user = User.create({
        name: Faker::FunnyName.name,
        phone_number: Faker::PhoneNumber.phone_number,
        is_walker: false,
        zip_code: [610000, 610012, 610013, 610043, 610036].sample
    })
    user.save
end
