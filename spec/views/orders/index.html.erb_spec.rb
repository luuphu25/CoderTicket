require 'rails_helper'
require 'simplecov'
RSpec.describe "orders/new.html.erb", type: :view do
  describe "index" do
    it "displays success" do
    assign(:orders, [
      Order.create(:quantity => 12),
      Order.create( :quantity => 13)
    ])
    render
    controller.response.should be_success
    
  end
  it "should show the body's name" do
        render
        response.should eql("<h1>Orders#new</h1>\n<p>Find me in app/views/orders/new.html.erb</p>\n")
  end

  end
end
