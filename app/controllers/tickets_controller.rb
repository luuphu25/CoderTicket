class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @ticket = TicketType.new
    @ticket.event_id = @event.id
  end

  def index
    @event = Event.find(params[:event_id])
    @tickets = TicketType.where(event_id: params[:event_id])
    @orders = []        
  end

  def create
    @ticket = TicketType.new ticket_params
    @ticket.event_id = params[:event_id]
    if @ticket.save
      flash[:success] = "Create ticket success!"
      redirect_to :action => 'new'
    else
      flash[:error] = "Error, #{@tick.error.full_messages.to_sentence}"
      render :action => 'new'
    end
  end
  private
    def ticket_params
      params.require(:ticket_type).permit(:name, :price, :max_quantity)
    end

end
