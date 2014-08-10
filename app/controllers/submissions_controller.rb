class SubmissionsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,    only: [:edit, :update, :destroy]
  before_action :store_location, only: [:new]

  def new
    @event = Event.find(params[:id])
    @submission = Submission.new
    # redirect to last place if no ID
    redirect_back_or if @event.nil?
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.user = current_user
    if @submission.save
      flash[:success] = "Submission successful! Make sure to <a href='/pay'>pay</a> when you're done!"
      redirect_to event_path(@submission.event)
      #redirect_back_or
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

    def submission_params
      params.require(:submission).permit( :title, 
                                    :user_id, 
                                    :event_id,
                                    :category_id,
                                    :video_url,
                                    :user_role,
                                    :client, 
                                    :title,
                                    :budget,
                                    :production_company)
    end
end
