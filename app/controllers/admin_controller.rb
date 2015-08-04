class AdminController < ApplicationController
  before_action :signed_in_user,            only: [:index]
  before_action :admin_user,      only: [:index]

  def index
    @events = Event.all.sort {|a, b| b.show_date <=> a.show_date }
  end

end
