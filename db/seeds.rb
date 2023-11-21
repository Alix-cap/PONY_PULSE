# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'open-uri'

User.destroy_all
Pony.destroy_all
Booking.destroy_all

# 1/ SEEDS USERS
# Création de 10 users avec la gem faker
puts "Creating users..."
10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end

puts "User seed completed successfully!"

# 2/ SEEDS PONIES
# Définition des catégories de ponies
races = ["Shetland", "Welsh", "Connemara", "Chincoteague", "Dartmoor", "Exmoor", "New Forest", "Pony of the Americas (POA)", "Icelandic Horse", "Fell"]
coats = ["Bay", "Chestnut/Sorrel", "Black", "Palomino", "Gray", "Buckskin", "Roan", "Appaloosa", "Pinto", "Dun"]
purposes = ["Companionship", "Recreational Riding", "Educational Tool", "Farm work", "Therapeutic Riding", "Competitive Sports", "Conservation Grazing"]
locations = ["Paris", "Versailles", "Boulogne-Billancourt", "Saint-Denis", "Argenteuil", "Montreuil", "Nanterre", "Créteil", "Aulnay-sous-Bois", "Courbevoie", "Vitry-sur-Seine", "Colombes", "Asnières-sur-Seine", "Rueil-Malmaison", "Champigny-sur-Marne"]

# Liste de noms pour les ponies
pony_names = [
  "Buddy",
  "Charlie",
  "Daisy",
  "Finn",
  "Ginger",
  "Max",
  "Misty",
  "Oscar",
  "Penny",
  "Rocky",
  "Rosie",
  "Sam",
  "Sasha",
  "Teddy",
  "Zoe"
]

images = [
  "https://www.classequine.com/wp-content/uploads/2021/04/race-poney-Shetland.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/Pottok.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/Haflinger.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/cheval-Fjord.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/Poney-Welsh.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/Connemara.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/05/Poney-New-Forest.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/05/poney-fell.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/08/cheval-Asturcon.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/07/poney-des-ameriques.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/03/poney-landais.jpg",
  "https://www.classequine.com/wp-content/uploads/2021/10/gipsy-cob-cheval.jpeg",
  "https://www.classequine.com/wp-content/uploads/2021/03/Dartmoor.jpg",
  "https://i-mom.unimedias.fr/2023/04/06/licorne.jpg?auto=format%2Ccompress&crop=faces&cs=tinysrgb&fit=crop&h=236&w=420",
  "https://stock.wikimini.org/w/images/b/b5/Poney_shetland-9380.jpg"
]
image_index = 0

# Création des ponies
puts "Creating ponies..."
pony_names.each do |name|
  pony = Pony.new(
    name:,
    race: Pony::RACES.sample,
    location: locations.sample,
    birth_date: rand(5..15).years.ago.to_date,
    sex: ["Male", "Female"].sample,
    purpose: Pony::PURPOSES.sample,
    coat: Pony::COAT.sample,
    price_per_day: rand(20..100),
    user: User.all.sample
  )

  image = URI.open(images[image_index])
  pony.photos.attach(io: image, filename: "#{pony.name}.jpg", content_type: "image/jpg")
  pony.save!
  image_index += 1
  puts "#{pony.name} is created successfully!"
end

puts "Pony seed completed successfully!"

# SEEDS BOOKINGS
# Création des bookings
puts "Creating bookings..."

10.times do
  start_date = Date.today + rand(1..14)
  end_date = start_date + rand(1..14)
  user = User.all.sample
  pony = Pony.where.not(user:).sample
  total_price = pony.price_per_day * (end_date - start_date)

  booking = Booking.create!(
    start_date:,
    end_date:,
    total_price:, # Calculer total_price
    user:,
    pony:
  )

  puts "Bookings n°#{booking.id + 1} created!"
end

puts "All done!"
