# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create] # Assure l'authentification pour new et create

  def index
    @events = Event.all.order(start_date: :asc)
  end

  def show
    # Vous pouvez ajouter du code spécifique pour l'action show si nécessaire
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
    # Vous pouvez ajouter du code spécifique pour l'action edit si nécessaire
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'L\'événement a été mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'L\'événement a été supprimé avec succès.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
