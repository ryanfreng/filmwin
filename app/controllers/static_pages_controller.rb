class StaticPagesController < ApplicationController
  def home
    @event = Event.first
    if @event
      redirect_to @event
    end
  end

  def help
  end

  def about
  end
end
