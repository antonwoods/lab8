class PagesController < ApplicationController
 

  def home
    @title = "Home"
    if signed_in?
      @idea = Idea.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end
  
   def about
    @title = "about"
  end

  def help
    @title = "help"
  end

  def contact
    @title = "contact"
  end

end
