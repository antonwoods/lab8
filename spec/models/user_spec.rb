require 'spec_helper'

describe User do
  
  before(:each) do
     @attrib = {:name => "Example User", :email => "user@example.com"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attrib)
  end
  
  it "should requite a name" do
    no_name_user = User.new(@attrib.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
 it "should requite an email" do
    no_name_user = User.new(@attrib.merge(:email => ""))
    no_name_user.should_not be_valid
  end

 it "should reject names that are too long" do
   long_name = "a" * 51
   long_name_user = User.new(@attrib.merge(:name => long_name))
   long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@arrtib.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo.com user_at_foo.org example.user@foo.]
    addresses.each do |addresses|
      invalid_email_user = User.new(@arrtib.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    #put a user with a given email address into the database
    User.create!(@attrib)
    user_with_duplicate_email = User.new(@attrib)
    user_with_duplicate_email.should_not be_valid
  end
 
 it "should reject email addresses identical up to case" do
    upcase_email = @attrib[:email].upcase
    User.create!(@attrib.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attrib)
    user_with_duplicate_email.should_not be_valid
  end
  
  
end
