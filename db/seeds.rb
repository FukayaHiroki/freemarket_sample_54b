# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  User.create!(
    id: "#{n+1}",
    nickname: "test",
    email: "test#{n}@gmail.com",
    password: "passwoed#{n+1}",
    family_name: "実験",
    first_name: "実験",
    family_name_kana: "test", 
    first_name_kana: "test",
    birthday: "1990-11-11",
    created_at: 2020-2-2,
    updated_at: 2020-2-2
  )
end

10.times do |n|
  Product.create!(
    name: "item#{n}",
    detail: "itemdetail#{n}",
    user_id: 1,
  )
  1.upto(5) do |m|
    Image.create!(
      url: open('app/assets/images/item_detail.jpg'),
    )
  end
end


