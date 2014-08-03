class EventsController < ApplicationController
  before_action :signed_in_user,  only: [:new, :edit]

  def new
  end

  def edit
  end

  def show
    @event = Event.find(params[:id])
  end
end
