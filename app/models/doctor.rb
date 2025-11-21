class Doctor < ApplicationRecord
  has_many :appointments
  validates :name, presence: true
end
