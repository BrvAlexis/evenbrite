class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  
  has_many :participants, through: :attendances, source: :user # Plusieurs participants au travers des participations

  def end_date
    start_date + duration.minutes
  end


end
