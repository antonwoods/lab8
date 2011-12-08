require 'spec_helper'

describe SessionsController do
render_views

describe "DELETE 'destroy'" do
  it "should sign a user out" do
    test_sign_in(Factory(:user))
    delete :destroy
    controller.should_not be_signed_in
    response.should redirect_to(root_path)
  end
end


  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
      it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
    
  end
  
  
  describe "POST 'create'"do
    before(:each) do
      @attrib = {:email => "email@example.com", :password => "invalid"}
    end
    
    it "should re-render the new page" do
      post :create, :session => @attrib
      response.should render_template('new')
    end
    
     it "should have the right title" do
      post :create, :session => @attrib
      response.should have_selector("title", :content => "Sign in")
    end
    
    
      it "should have a flash.now message" do
      post :create, :session => @attrib
      flash.now[:error].should =~ /invalid/i
    end
    
    
    
    describe "with valid email and password" do
        
        before(:each) do
          @user = Factory(:user)
          @attrib = {:email => @user.email, :password => @user.password}
        end
        
        it "should sign the user in" do
          post :create, :session => @attrib
          controller.current_user.should == @user
          controller.should be_signed_in
        end
        
        it "should redirect to the user show page" do
          post :create, :session => @attrib
          response.should redirect_to(user_path(@user))
       end
       
    end
  end
end