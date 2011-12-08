require 'spec_helper'

describe Topic do

before(:each) do
  @attrib = {:title => "test title for admin topic", :isactive => 1, :cbuser => 1}
end
it "should create a new instance given the valid attributes" do
  Topic.create!(@attrib)
end

 describe "user associations" do

    before(:each) do
      @topic = @user.topics.create(@attr)
    end

    it "should have a user attribute" do
      @topic.should respond_to(:user)
    end

    it "should have the right associated user" do
      @topic.cbuser.should == @user.id
      @topic.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Topic.new(@attr).should_not be_valid
    end

    it "should require nonblank title" do
      @user.topics.build(:title => "  ").should_not be_valid
    end

    it "should reject long title" do
      @user.topics.build(:title => "a" * 100).should_not be_valid
    end
    it "should require an isactive parameter" do
      @user.topics.build(:isactive => "  ").should_not be_valid
    end
  end
  
  
end
