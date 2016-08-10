class SubmissionCostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new    
    @event = Event.find(params[:event_id])
    correct_user(@event)
    @submission_cost = SubmissionCost.new
  end

  def create
    @submission_cost = SubmissionCost.new(sc_params)
    if @submission_cost.save
      flash[:success] = "Submission Cost created!"
      redirect_to admin_events_path(@submission_cost.event)
    else
      @event = Event.find(@submission_cost.event.id)
      render 'new' #new_submission_quantity_event_path(@submission_quantity.event)
    end
  end

  def edit
    @submission_cost = SubmissionCost.find(params[:id])
  end

  def update
    @submission_cost = SubmissionCost.find(params[:id])
    if @submission_cost.update_attributes(sc_params)
      flash[:success] = "Successfully updated submission cost"
      redirect_to admin_events_path(@submission_cost.event)
    else
      render 'edit'
    end
  end

  def destroy
    @submission_cost = SubmissionCost.find(params[:id])
    @event = @submission_cost.event
    if @submission_cost.destroy
      flash[:success] = "Submission cost deleted!"
      redirect_to admin_events_path(@event)
    else
      render edit_submission_cost_path(@submission_cost)
    end
  end

  private
    def sc_params
      params.require(:submission_cost).permit(:standard, :earlybird, :submission_quantity_id, :user_type_id)
    end

    def correct_user(event = nil)
      signed_in_user
      e = event ? event : SubmissionCost.find(params[:id]).event
      redirect_to root_url if e.user != current_user
    rescue
      redirect_to root_url
    end
end
