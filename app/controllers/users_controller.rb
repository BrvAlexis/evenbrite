class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def correct_user
    redirect_to root_path unless current_user == User.find(params[:id])
  end
end
