class AttendancesController < ApplicationController
  before_action :authorize_creator, only: [:index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def show
  end

  def destroy
    # Logique pour supprimer une participation
    # Rediriger vers la page appropriée, par exemple : redirect_to event_attendances_path(@event)
  end

  def index
    @event = Event.find(params[:event_id])
    @guests = @event.attendances
  end

  def new
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.build
  end

  def create
    # Logique pour créer une nouvelle participation
    # Rediriger vers la page appropriée, par exemple : redirect_to event_attendances_path(@event)
  end

  def edit
    # Logique pour afficher le formulaire de modification de la participation
  end

  def update
    # Logique pour mettre à jour une participation existante
    # Rediriger vers la page appropriée, par exemple : redirect_to event_attendances_path(@event)
  end

  private

  def authorize_creator
    @event = Event.find(params[:event_id])
    unless current_user && current_user == @event.user
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end