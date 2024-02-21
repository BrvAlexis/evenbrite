# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.all.order(start_date: :asc)
  end

  def show
   # Ajoutez le lien vers "Mon espace événement" si l'utilisateur est le créateur de l'événement
   @manage_event_link = event_path(@event) if current_user == @event.user
   @guests_link = attendances_path(event_id: @event.id) if current_user == @event.user
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to event_path(@event), notice: "L'événement a été créé avec succès."
    else
      render :new
    end
  end

  def edit
      # Ajoutez la vérification si l'utilisateur est le créateur de l'événement
      authorize_creator
  end

  def update
        authorize_creator
    if @event.update(event_params)
      redirect_to @event, notice: 'L\'événement a été mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    authorize_creator
    @event.destroy
    redirect_to events_url, notice: 'L\'événement a été supprimé avec succès.'
  end

  def manage
    authorize_creator
    @guests_link = event_guests_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end

  def authorize_creator
    unless current_user && current_user == @event.user
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
    end
  end

end
