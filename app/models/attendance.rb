class Attendance < ApplicationRecord
  after_create :welcome_send
    
    def welcome_send
        AttendanceMailer.welcome_email(self).deliver_now
    end
    
 
 
 
  belongs_to :user
  belongs_to :event
end
