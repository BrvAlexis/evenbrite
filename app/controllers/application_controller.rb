class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    private
  
    def authenticate_admin!
      authenticate_user!
  
      unless current_user.admin?
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page."
      end
    end


end
