class EventsController < ApplicationController
  before_action :signed_in_user,  only: [:new, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Successfully updated event"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
    @new_category = Category.new if can_edit_event?
  end

  private

    def event_params
      params.require(:event).permit(:name, :sub_heading, :description,
                                    :entry_start_date, :entry_end_date,
                                    :judging_date, :show_date)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end
