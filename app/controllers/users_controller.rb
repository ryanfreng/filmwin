class UsersController < ApplicationController
  before_action :signed_in_user,            only: [:index, :edit, :update, :destroy, :show, :submissions]
  before_action :correct_user_or_admin,     only: [:edit, :update, :destroy, :show, :submissions]
  before_action :admin_user,      only: [:index, :destroy]
  before_action :redirect_root_if_signed_in, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page] )
  end

  def show
    @user = User.find(params[:id])
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    if params.has_key?(:st)
      status = params[:st]
      if status == "Completed"
        flash[:success] = "Payment successful"
      else
        flash[:error] = "Payment issue: #{status}"
      end
    end
  end

  def submissions
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Filmwin!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit( :name, 
                                    :email, 
                                    :title,
                                    :company,
                                    :password, 
                                    :password_confirmation,
                                    :user_type_id)
    end

    
end
