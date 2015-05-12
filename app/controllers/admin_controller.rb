class AdminController < ApplicationController
  before_action :signed_in_user,            only: [:index]
  before_action :admin_user,      only: [:index]

  def index
    @categories = Category.all.sort_by { |category| category.submissions.count }.reverse
  end

end
