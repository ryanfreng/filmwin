class CategoriesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @category = Category.new(category_params, event_id: params[:evend_id])
    if @category.save
      flash[:success] = "Category created!"
      redirect_to @category.event
    else
      render 'static_pages/home'
    end
  end

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

  def destroy
    @category = Category.find(params[:id])
    @event = @category.event
    if @category.destroy
      flash[:success] = "Category deleted!"
      redirect_to @category.event
    else
      render edit_category_path(@category)
    end
  end

  private
    def category_params
      params.require(:category).permit(:name, :description, :event_id, :parent_id)
    end

    def correct_user
      redirect_to root_url if Category.find(params[:id]).event.user != current_user
    rescue
      redirect_to root_url
    end
end
