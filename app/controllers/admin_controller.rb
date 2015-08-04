class AdminController < ApplicationController
  before_action :signed_in_user,            only: [:index]
  before_action :admin_user,      only: [:index]

  def index
    @events = Event.all
  end

end
