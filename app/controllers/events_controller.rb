class EventsController < ApplicationController
  before_action :signed_in_user,  only: [:new, :edit, :update, :submissions]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :submissions]

  def new
    redirect_to root_url
    # @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Event successfully created"
      redirect_to @event
    else
      render 'new'
    end
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
    if params.has_key?(:id) && !params[:id].empty?
      @event = Event.find(params[:id])
      @new_category = Category.new if can_edit_event?
    else
      @event = Event.first
      @new_category = Category.new if can_edit_event?
    end
  end

  def submissions
    @event = Event.find(params[:id])
    @submissions = @event.submissions
    @submissions = @submissions.sort_by { | sub | sub.category.name }
  end

  private

    def event_params
      params.require(:event).permit(:name, :sub_heading, :description,
                                    :entry_start_date, :entry_end_date,
                                    :judging_date, :show_date, :paypal_email_address)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end

    def admin_user
      current_user.admin or redirect_to root_url
    end
end
