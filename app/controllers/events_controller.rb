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

  def publish
    if have_enough_ticket_types?
      self.update(published_at:datetime)
    else
      flash[:error] = "Must have at least 1 type ticket"
      redirect_to root_path
    end
  end

  def have_enough_ticket_type?
    return not(TicketType.where(event_id: self.id).empty)
  end

  private
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :starts_at, :ends_at, :venue_id,:category_id, :user_id)
  end
end
