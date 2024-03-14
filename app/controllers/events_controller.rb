# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.order(start_date: :asc)
    @pending_events = Event.where(validated: false, reviewed: true).order(created_at: :desc)
  end

  
  def show

    @event = Event.find(params[:id])
    if @event.validated? || (@event.reviewed? && current_user == @event.user)
      # Ajoutez le lien vers "Mon espace événement" si l'utilisateur est le créateur de l'événement
      @manage_event_link = event_path(@event) if current_user == @event.user
    
      # Ajoutez le lien vers la liste des invités uniquement si l'événement est validé
      @guests_link = event_attendances_path(event_id: @event.id) if current_user == @event.user
    else
      flash[:alert] = "Cet événement est en attente de validation et ne peut pas être consulté pour le moment."
      redirect_to events_path
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params.merge(validated: false, reviewed: true))
  
    if @event.save
      flash[:notice] = "L'événement a été créé avec succès. Il est en attente de validation."
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
      # Ajoutez la vérification si l'utilisateur est le créateur de l'événement
      authorize_creator
  end

  def update
    # Autoriser la mise à jour par le créateur de l'événement ou par un administrateur
    if current_user == @event.user || current_user.admin?
      if @event.reviewed?
        @event.update(event_params.merge(validated: true, reviewed: true))
      else
        @event.update(event_params.merge(reviewed: true))
      end
  
      redirect_to @event, notice: 'L\'événement a été mis à jour avec succès.'
    else
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
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
    authorize @event
    unless current_user && current_user == @event.user
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
    end
  end

end
