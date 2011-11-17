require 'spec_helper'

describe PagesController do
  
    render_views


  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
 
     it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "about")
    end
 
      it "should have the right header" do
      get 'about'
      response.should have_selector("CurrentVotingTitle", :content => "Pages#about")
    end

  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
     it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content => "help")
    end
     it "should have the right header" do
      get 'help'
      responseshould have_selector("CurrentVotingTitle", :content => "Pages#help")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
     it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => "contact")
    end
     it "should have the right header" do
      get 'contact'
      response.should have_selector("CurrentVotingTitle", :content => "Pages#contact")
    end
  end

end
