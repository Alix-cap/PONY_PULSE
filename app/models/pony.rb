class Pony < ApplicationRecord
  RACES = ["Shetland", "Welsh", "Connemara", "Chincoteague", "Dartmoor", "Exmoor", "New Forest", "Pony of the Americas", "Icelandic Horse", "Fell"]
  PURPOSES = ["Companionship", "Recreational Riding", "Educational Tool", "Farm work", "Therapeutic Riding", "Competitive Sports", "Conservation Grazing"]
  COAT = %w(
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
  )
  SEX = %w(
    Male
    Female
  )

  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 3 }
  validates :location, :birth_date, :photos, presence: true
  validates :race, presence: true, inclusion: { in: RACES }

  validates :coat, presence: true, inclusion: { in: COAT }

  validates :sex, presence: true, inclusion: { in: SEX}

  validates :purpose, presence: true, inclusion: { in: PURPOSES }

  validates :price_per_day, presence: true, numericality: true
end
