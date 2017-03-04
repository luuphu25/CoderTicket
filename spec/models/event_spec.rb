require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
    it "return [] when there are no events" do
      expect(Event.upcoming).to eq []
    end
    it "return [] when there are only past events" do
     Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago,published_at: Time.now, extended_html_description: " a past event",
      venue: Venue.new, category: Category.new)
     expect(Event.upcoming).to eq []
   end
   it "return [b] when there are a past event 'a' and a future event 'b'" do
     a = Event.create!(name: "a", starts_at: 2.days.ago, ends_at: 1.day.ago,published_at: Time.now, extended_html_description: "a past event",
      venue: Venue.new, category: Category.new)
     b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, published_at: Time.now, extended_html_description: " a future event",
      venue: Venue.new, category: Category.new)
     expect(Event.upcoming).to eq [b]
   end
 end

  describe "have_enough_ticket_types?" do 
    it "return true when events has ticket_types" do
        a = Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago,published_at: Time.now, extended_html_description: " a past event",
      venue: Venue.new, category: Category.new)
        TicketType.create!(event_id: a.id, price: 100, name:"ve loai A", max_quantity: "200")
       expect(a.have_enough_ticket_type?).to eq true
    end

    it "return false when events no ticket_type" do 
       b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, published_at: Time.now, extended_html_description: " a future event",
      venue: Venue.new, category: Category.new)
       expect(b.have_enough_ticket_type?).to eq false
    end
  end

  describe "published" do 
    it "return not nil when event have ticket publish " do 
       a = Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
      venue: Venue.new, category: Category.new)
       TicketType.create!(event_id: a.id, price: 100, name:"ve loai A", max_quantity: "200")
       a.publish
       expect(a.published_at).not_to eq nil
    end

    it "return nill when publish event no ticket" do
       b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a future event",
      venue: Venue.new, category: Category.new)
       b.publish
       expect(b.published_at).to eq nil
    end
  end


 
end