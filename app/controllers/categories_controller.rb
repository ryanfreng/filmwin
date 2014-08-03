class CategoriesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Successfully updated category"
      redirect_to @category.event
    else
      render 'edit'
    end
  end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def correct_user
      redirect_to root_url if Category.find(params[:id]).event.user != current_user
    end
end
