class Event < ApplicationRecord
  
  belongs_to :admin, class_name: 'User' # Un événement appartient à un administrateur (utilisateur)
  has_many :attendances
  has_many :participants, through: :attendances, source: :user # Plusieurs participants au travers des participations
end
