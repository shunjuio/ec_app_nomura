# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  split_name = Faker::Name.name.split

  Member.create!(
    last_name: split_name[1],
    first_name: split_name[0],
    email: "email#{n + 1}@example.com",
    password: 'password'
  )
end

products = [{ name: 'アルバータプレミアム', price: 1720, alcohol: '40%', image_path: '/product_images/albertapremium.png',
              material: 'シングルモルト', product_area: 'カナダ' },
            { name: 'ブッシュミルズ', price: 2355, alcohol: '40%', image_path: '/product_images/bushmills.png',
              material: 'シングルモルト', product_area: 'イギリス' },
            { name: 'カナディアンクラブ', price: 1649, alcohol: '40%', image_path: '/product_images/canadianclub.png',
              material: 'シングルモルト', product_area: 'カナダ' },
            { name: '知多', price: 5380, alcohol: '43%', image_path: '/product_images/chita.png', material: 'シングルモルト',
              product_area: '日本' },
            { name: 'アーリータイムズ', price: 6780, alcohol: '40%', image_path: '/product_images/earlytimes.png',
              material: 'シングルモルト', product_area: 'アメリカ' },
            { name: 'フェイマスグラウス', price: 2800, alcohol: '40%', image_path: '/product_images/famousgrouse.png',
              material: 'シングルモルト', product_area: 'イギリス' },
            { name: 'フォアローゼズ', price: 2003, alcohol: '40%', image_path: '/product_images/fourroses.png',
              material: 'シングルモルト', product_area: 'アメリカ' },
            { name: 'グレンフィディック', price: 4382, alcohol: '40%', image_path: '/product_images/glenfiddich.png',
              material: 'シングルモルト', product_area: 'イギリス' },
            { name: '白州', price: 12100, alcohol: '43%', image_path: '/product_images/hakushu.png', material: 'シングルモルト',
              product_area: '日本' },
            { name: '響', price: 15987, alcohol: '43%', image_path: '/product_images/hibiki.png', material: 'シングルモルト',
              product_area: '日本' },
            { name: 'I.W.ハーパー', price: 2179, alcohol: '40%', image_path: '/product_images/i.w.harper.png',
              material: 'シングルモルト', product_area: 'アメリカ' },
            { name: 'ジャックダニエル', price: 3170, alcohol: '40%', image_path: "/product_images/jackdaniel's.png",
              material: 'シングルモルト', product_area: 'アメリカ' }]

products.each do |product|
  Product.create!(
    name: product[:name],
    price: product[:price],
    alcohol: product[:alcohol],
    image_path: product[:image_path],
    material: product[:material],
    product_area: product[:product_area]
  )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
