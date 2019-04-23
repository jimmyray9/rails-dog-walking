# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do {
	user = User.new({
		name: Faker::FunnyName.name,
		is_walker: true,
		walker_img: Faker::LoremFlickr.image,
		walker_age: rand(18..35),
		phone_number: Faker::PhoneNumber.phone_number,
		zip_code: [610000, 610012, 610013, 610014, 610030, 610031].sample,
		walker_description: Faker::Movie.quote
	})
	user.save
}

10.times do {
	user = User.new({
		name: Faker::FunnyName.name,
		is_walker: false,
		walker_img: null,
		walker_age: null,
		phone_number: Faker::PhoneNumber.phone_number,
		zip_code: [610000, 610012, 610013, 610014, 610030, 610031].sample,
		walker_description: null
	})
	user.save
}