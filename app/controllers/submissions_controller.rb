class SubmissionsController < ApplicationController
  before_action :signed_in_user
  before_action :can_edit_submission,     only: [:edit, :update, :destroy]
  before_action :store_location,          only: [:new]

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
      flash[:success] = "Submission successful! Make sure to pay when you're done!"
      redirect_to user_path(current_user) #event_path(@submission.event)
      #redirect_back_or
    else
      @event = Event.find(submission_params[:event_id])
      render "new"
    end
  end

  def edit
    @submission = Submission.find(params[:id])
    @event = @submission.event
  end

  def upload
    #@submission = Submission.find(params[:id])
    #if @submission.update_attributes(submission_params)
    #@submission = Submission.find(params[:id])
    #@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    #redirect_to user_path(@user) if @submission.video_url.empty?
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update_attributes(submission_params)
      flash[:success] = "Submission updated"
      redirect_to current_user
    else
      @event = @submission.event
      render 'edit'
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    @event = Event.find(@submission.event.id)
    @submission.destroy
    flash[:success] = "Submission deleted."
    redirect_to current_user
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
                                    :production_company,
                                    :upload_url,
                                    :comments_other,
                                    :director,
                                    :producer,
                                    :editor,
                                    :cinematographer)
    end
end
