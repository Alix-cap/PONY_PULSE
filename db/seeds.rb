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

Booking.destroy_all
Pony.destroy_all
User.destroy_all

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
locations = ["14800 Deauville, FRANCE",
             "78600 Maisons-Laffitte, FRANCE",
             "94130 Nogent-sur-Marne, FRANCE",
             "17220 La Jarne, FRANCE",
             "33290 Blanquefort, FRANCE",
             "33190 La Réole, FRANCE",
             "34000 Montpellier, FRANCE",
             "45200 Amilly, FRANCE",
             "13190 Allauch, FRANCE",
             "69200 Vénissieux, FRANCE",
             "51100 Reims, FRANCE",
             "54000 Nancy, FRANCE",
             "59262 Sainghin-en-Mélantois, FRANCE",
             "76130 Mont-Saint-Aignan, FRANCE",
             "76400 Fécamp, FRANCE"]

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
  "data:image/jpeg;base64,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",
  "https://stock.wikimini.org/w/images/b/b5/Poney_shetland-9380.jpg"
]
image_index = 0

# Création des ponies
puts "Creating ponies..."
pony_names.each_with_index do |name, index|
  pony = Pony.new(
    name:,
    description: Faker::Lorem.paragraph(sentence_count: 10),
    race: Pony::RACES.sample,
    location: locations[index],
    birth_date: "#{rand(1990..2020)}-#{rand(1..12)}-#{rand(1..28)}",
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
  start_date = (Date.today + rand(1..14)).to_s
  end_date = (start_date.to_date + rand(1..14)).to_s
  user = User.all.sample
  pony = Pony.where.not(user:).sample
  total_price = pony.price_per_day * (end_date.to_date - start_date.to_date)

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
