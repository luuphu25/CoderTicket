require 'rails_helper'
require 'simplecov'
RSpec.describe "events/new.html.erb", type: :view do
  describe 'events/new.html.erb' do
      before do
        @event = mock_model(Event, name:"test")
      end
      it "should show a form" do
        render
        controller.response.should be_success
      end
  end
end
