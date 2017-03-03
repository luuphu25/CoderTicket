class EventsController < ApplicationController
  def index
    @events = Event.all
     if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
      if @events.empty?
        @events = Event.all
      end
     else
      @events = Event.order("created_at DESC") 
     end
  end

  def show
    @event = Event.find(params[:id])
  end
end
