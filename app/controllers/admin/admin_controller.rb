class Admin::AdminController < ApplicationController
    before_action :authenticate_admin!

    def index
      @event_submissions = Event.where(validated: false, reviewed: true)
      puts "Number of event submissions: #{@event_submissions.count}"
    end
  

end
