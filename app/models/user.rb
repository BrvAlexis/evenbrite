class User < ApplicationRecord
    after_create :welcome_send
    
    def welcome_send
        UserMailer.welcome_email(self).deliver_now
    end
    
    has_many :admin_events, foreign_key: 'admin_id', class_name: 'Event'
    has_many :participations
    has_many :attended_events, through: :participations, source: :event

    
end
