class OrdersController < ApplicationController  
  before_action :authorize, only: [:create]
  attr_accessor :sum
  def index
    @ticket_types = TicketType.all
    @orders = Order.where(user_id: current_user.id)
    @event = Event.all
    @orders.each do |order|
      @x = @x.to_i + (order.ticket_type.price * order.quantity).to_i
    end  
   
  end
  def new
    order = Order.new
  end

  def create    
    @orders = params[:orders]   
    @orders.each do |ticket, q|
     if Order.where(ticket_type_id: ticket).sum(:quantity) + q.to_i <= TicketType.find_by_id(ticket).max_quantity.to_i    
        @order = Order.new(ticket_type_id: ticket, quantity: q)
        @order.user_id = current_user.id
        if @order.quantity !=0
           if @order.save
            flash[:success] = "Order success!"
            redirect_to orders_path
            else    
            flash[:error] = "Error #{@order.error.full_messages.to_sentence}"
            redirect_to orders_path
           end
        end
      else
        flash[:error] = "Not enough ticket" 
        redirect_to root_path       
      end      
    end        
  end

  def order_params
    params.require(:order).permit(:quantity, :user_id, :ticket_type_id)
  end
end
