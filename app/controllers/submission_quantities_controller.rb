class SubmissionQuantitiesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new    
    @event = Event.find(params[:event_id])
    correct_user(@event)
    @submission_quantity = SubmissionQuantity.new(event_id: params[:event_id])
  end

  def create
    @submission_quantity = SubmissionQuantity.new(sq_params)
    if @submission_quantity.save
      flash[:success] = "Submission Quantity created!"
      redirect_to admin_events_path(@submission_quantity.event)
    else
      @event = Event.find(@submission_quantity.event.id)
      render 'new' #new_submission_quantity_event_path(@submission_quantity.event)
    end
  end

  def edit
    @submission_quantity = SubmissionQuantity.find(params[:id])
  end

  def update
    @submission_quantity = SubmissionQuantity.find(params[:id])
    if @submission_quantity.update_attributes(sq_params)
      flash[:success] = "Successfully updated submission quantity"
      redirect_to admin_events_path(@submission_quantity.event)
    else
      render 'edit'
    end
  end

  def destroy
    @submission_quantity = SubmissionQuantity.find(params[:id])
    @event = @submission_quantity.event
    if @submission_quantity.destroy
      flash[:success] = "Submission quantity deleted!"
      redirect_to admin_events_path(@event)
    else
      render edit_submission_quantity_path(@submission_quantity)
    end
  end

  private
    def sq_params
      params.require(:submission_quantity).permit(:beginning_value, :end_value, :event_id)
    end

    def correct_user(event = nil)
      signed_in_user
      e = event ? event : SubmissionQuantity.find(params[:id]).event
      redirect_to root_url if e.user != current_user
    rescue
      redirect_to root_url
    end
end
