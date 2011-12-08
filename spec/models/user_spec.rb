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
  
  
  
    describe "admin should be able to create topics" do
  before(:each) do
  @user = User.create!(@attrib)
  @user.toggle!(:admin)
  @user.should be_admin
  end
  
  it " and should have a topics attribute" do
    @user.should respond_to(:topics)
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

 describe "idea associations" do

   before(:each) do
      @user = User.create(@attrib)
      @mp1 = Factory(:idea, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:idea, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:ideas)
    end

    it "should have the right microposts in the right order" do
      @user.ideas.should == [@mp2, @mp1]
    end
    
    
  it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |idea|
        Idea.find_by_id(idea.id).should be_nil
      end
    end
    
    
    
    describe "status feed" do

      it "should have a feed" do
        @user.should respond_to(:feed)
      end

      it "should include the user's microposts" do
        @user.feed.include?(@mp1).should be_true
        @user.feed.include?(@mp2).should be_true
      end

      it "should not include a different user's microposts" do
        mp3 = Factory(:micropost,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(mp3).should be_false
      end
    end
    
  end
  
  
  
  
end