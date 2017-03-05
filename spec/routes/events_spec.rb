require 'rails_helper'
require 'simplecov'

RSpec.describe "events", type: :routing do
  it "routes /upcoming to events#index" do
    expect(get: "/upcoming").to route_to(controller: "events", action: "index")
  end
  it "route /logout to sessions#destroy" do
    expect(delete: "/log_out").to route_to(controller: "sessions", action: "destroy")
  end
  it "/sign_in to sessions#new" do
    expect(get: "/sign_in").to route_to(controller:"sessions", action: "new")
  end
end


