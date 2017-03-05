require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Create" do 
    it "is invalid without email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")    
    end
    it "is invalid with taken email" do 
      User.create(email:"test@gmail.com", password:"1234")
      user = User.new(email:"test@gmail.com", password:"1234")
      user.valid?
      expect(user.errors.full_messages.to_sentence).to include("has already been taken")
    end
  end  
end
