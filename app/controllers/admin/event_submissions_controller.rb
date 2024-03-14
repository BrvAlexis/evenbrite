class Admin::EventSubmissionsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @event_submissions = Event.where(validated: false, reviewed: true)
    end
  
    def show
      @event_submission = Event.find(params[:id])
    end
  
    def edit
      @event_submission = Event.find(params[:id])
    end
  
    def update
      @event_submission = Event.find(params[:id])
      if @event_submission.update(event_params)
        redirect_to admin_event_submissions_path, notice: 'L\'événement a été validé avec succès.'
      else
        render :edit
      end
    end
  
    private
  
    def event_params
      params.require(:event).permit(:validated, :reviewed, :title)
    end
 



end
