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
locations = ["Rue Raynaldo Hahn, 14800 Deauville FRANCE",
             "42 Av. le Kain, 78600 Maisons-Laffitte FRANCE",
             "8 Rue de Fontenay, 94130 Nogent-sur-Marne FRANCE",
             "Rue de Saint-Mathurin, 17220 La Jarne FRANCE",
             "155 Av. du Port du Roy, 33290 Blanquefort FRANCE",
             "2 Chem. de Blasignon, 33190 La Réole FRANCE",
             "2733, avenue Albert Einstein, 34000 Montpellier FRANCE",
             "370 Rue des Pointards, 45200 Amilly FRANCE",
             "Chemin Lucien Olive, 13190 Allauch FRANCE",
             "2 Rue des Sports, 69200 Vénissieux FRANCE",
             "513 che Rouliers Complexe Sportif Du, 51100 Reims FRANCE",
             "56 Rue du Haut de Chèvre, 54000 Nancy FRANCE",
             "Rue du Grand Sainghin, 59262 Sainghin-en-Mélantois FRANCE",
             "Chemin des Communaux, 76130 Mont-Saint-Aignan FRANCE",
             "Sentier du Val aux Vaches, 76400 Fécamp FRANCE"]

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
