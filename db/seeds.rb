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

# Création des ponies
puts "Creating ponies..."
pony_names.each do |name|
  Pony.create(
    name:,
    race: races.sample,
    location: locations.sample,
    birth_date: rand(5..15).years.ago.to_date,
    sex: ["Male", "Female"].sample,
    purpose: purposes.sample,
    coat: coats.sample,
    price_per_day: rand(20..100),
    user: User.all.sample
  )
end

puts "Pony seed completed successfully!"

# SEEDS BOOKINGS
# Création des bookings
puts "Creating bookings..."

10.times do
  start_date = Faker::Date.between(from: 1.month.from_now, to: 3.months.from_now)
  end_date = start_date + rand(1..14).days

  Booking.create!(
    start_date: Faker::Name.first_name,
    end_date: Faker::Name.last_name,
    total_price: rand(100..1000), # Calculer total_price
    user: User.all.sample,
    pony: Pony.all.sample
  )
end
