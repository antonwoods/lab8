require 'spec_helper'

describe Idea do
  
   before(:each) do
    @attr = {
      :title => "value for title",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Idea.create!(@attr)
  end
  
   describe "user associations" do

    before(:each) do
      @idea = @user.ideas.create(@attr)
    end

    it "should have a user attribute" do
      @idea.should respond_to(:user)
    end

    it "should have the right associated user" do
      @idea.user_id.should == @user.id
      @idea.user.should == @user
    end
  end
  
  
  
   describe "validations" do

    it "should require a user id" do
      Idea.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.ideas.build(:title => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.ideas.build(:title => "a" * 141).should_not be_valid
    end
  end
 
end
