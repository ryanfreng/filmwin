class StaticPagesController < ApplicationController
  def home
    @event = Event.find(2)
    if @event
      redirect_to @event
    end
  end

  def help
  end

  def about
  end
end
