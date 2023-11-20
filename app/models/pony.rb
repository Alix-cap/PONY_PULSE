class Pony < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 3 }
  validates :location, :birth_date, :picture, presence: true
  validates :race, presence: true, inclusion: { in: %w(
    Shetland
    Welsh
    Connemara
    Chincoteague
    Dartmoor
    Exmoor
    New Forest
    Pony of the Americas (POA)
    Icelandic Horse
    Fell
  ), message: "%{value} is not a valid race" }

  validates :coat, presence: true, inclusion: { in: %w(
    Bay
    Chestnut/Sorrel
    Black
    Palomino
    Gray
    Buckskin
    Roan
    Appaloosa
    Pinto
    Dun
  ), message: "%{value} is not a valid coat" }

  validates :sex, presence: true, inclusion: { in: %w(
    Male
    Female
  )}

  validates :purpose, presence: true, inclusion: { in: %w(
    Companionship
    Recreational Riding
    Educational Tool
    Farm work
    Therapeutic Riding
    Competitive Sports
    Conservation Grazing
  )}

  validates :price_per_day, presence: true, numericality: true
end
