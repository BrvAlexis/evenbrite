class Event < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id', optional: true
  belongs_to :user
  has_many :attendances, dependent: :destroy
  
  has_many :participants, through: :attendances, source: :user # Plusieurs participants au travers des participations

  def end_date
    start_date + duration.minutes
  end
  validates :validated, inclusion: { in: [true, false] }
  validates :reviewed, inclusion: { in: [true, false] }

end
