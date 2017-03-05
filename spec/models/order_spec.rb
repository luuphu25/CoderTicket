require 'rails_helper'

RSpec.describe Order, type: :model do  
  describe "create" do
    it "return b, c  when creat b, c" do     
      a = TicketType.create!( price: 100, name:"ve loai A", max_quantity: 1000)
      b = Order.create!(ticket_type_id:a.id, quantity: 100)      
      c = Order.create!(ticket_type_id:a.id, quantity: 50)
      expect(Order.all).to eq [b, c]
    end
  end

end
