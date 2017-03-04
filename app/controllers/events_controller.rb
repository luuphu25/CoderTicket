class EventsController < ApplicationController

  def index
    if current_user
      @events = Event.where.not(published_at: nil).or(Event.where(user_id: current_user.id))
    else 
       @events = Event.where.not(published_at: nil)
    end 
     if params[:search]
       @events = @events.search(params[:search]).order("created_at DESC")      
     else
        @events = @events.order("created_at DESC") 
     end
  end

  def show
    @event = Event.find(params[:id])
  end

  def publish
    @event = Event.find(params[:id])
    if @event.publish
      redirect_to mine_event_path(id: current_user.id)
    else
      flash[:error] = "Error #{@event.error.full_messages.to_sentence}"
      redirect_to mine_event_path(id: current_user.id)
    end    
  end

  
  def mine
    @events = Event.where(user_id: current_user.id)
    if params[:search]
      @events = @events.search(params[:search]).order("created_at DESC")
      if @events.empty?
        @events = events.all
      end
    end    
  end

  def new
    @event = Event.new
  end

  def create    
    @event = Event.new event_params
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "Events createted"      
      redirect_to new_event_ticket_path(event_id: @event.id)
    else
      flash[:error] = "Error #{@event.errors.full_messages.to_sentence}"
      render 'new'
    end
  end
  


  private
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :starts_at, :ends_at, :venue_id,:category_id, :user_id)
  end
end
