require 'spec_helper'

describe User do
  
  before(:each) do
     @attrib = {:name => "Example User", 
       :email => "user@example.com",
       :password => "foobar",
       :password_confirmation => "foobar"}
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
      valid_email_user = User.new(@attrib.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attrib.merge(:email => address))
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
    User.create!(@attrib.merge(:email => upcase_email))
    user_with_duplicate_email = User.new(@attrib)
    user_with_duplicate_email.should_not be_valid
  end
 

  
  
  
  
  describe "admin attributes" do
  before(:each) do
  @user = User.create!(@attrib)
  end
  
  it "should respons to admin" do
    @user.should respond_to(:admin)
  end
  
  it "should not be an admin by default" do
    @user.should_not be_admin
  end
  
  it "should be convertable to an admin" do
    @user.toggle!(:admin)
    @user.should be_admin
  end
  end
  
  
  
  
  
  describe "password validation" do
      
   
     it "should require a password" do
       User.new(@attrib.merge(:password => "" , :password_confirmation => ""))
       should_not be_valid
     end
     
     
     it "should require a matching password confirmation" do
       User.new(@attrib.merge(:password_confirmation => "invalid"))
       should_not be_valid
     end
     
     
     it "should reject short passwords" do
       short = "a" * 5
       hash  = @attrib.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
      end
    
     it "should reject long passwords" do
       long = "a" * 41
       hash  = @attrib.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
      end
        
   describe "password encryption" do
        before (:each) do
          @user = User.create!(@attrib)
        end
        
        it "should have an encrypted password attribute" do
        @user.should respond_to(:encrypted_password)
        end
        
        it "should set the encrypted password " do
        @user.encrypted_password.should_not be_blank 
        end
        
        describe "has_password? method" do
        
            it "should be true if the passwords match" do
              @user.has_password?(@attrib[:password]).should be_true
            end
            
            it "should be false if the passwords don't match" do
              @user.has_password?("invalid").should be_false
            end 
      end
      
      describe "authentication method" do
      
      it "should return nil on email/password mismatch" do
       wrong_password_user = User.authenticate(@attrib[:email], "wrongpass")
       wrong_password_user.should be_nil
      end
      
      it "should return nil for an email address with no user" do
        nonexistant_user = User.authenticate("bar@foo.com", @attrib[:password])
        nonexistant_user.should be_nil
      end 
      
      it "should return the user on email/passowrd match" do
        matching_user = User.authenticate(@attrib[:email], @attrib[:password])
        matching_user.should == @user
      end
      
      end
  end
end
end