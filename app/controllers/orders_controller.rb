class OrdersController < ApplicationController

  def new
    order = Order.new
  end

  def create    
    @orders = params[:orders]   
    @orders.each do |ticket, q|   
      @order = Order.new(ticket_type_id: ticket, quantity: q)
      @order.user_id = current_user.id
      if @order.quantity !=0
         if not @order.save
          flash[:error] = "Error #{@order.error.full_messages.to_sentence}"
          redirect_to root_path
         end
      end    
    end
    flash[:success] = "Order success!"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit(:quantity, :user_id, :ticket_type_id)
  end
end
