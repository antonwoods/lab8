class PagesController < ApplicationController
 

  def home
    @title = "Home"
    if signed_in?
      @idea = Idea.new
     # @feed_items = current_user.feed.paginate(:page => params[:page])
     #--@feed_items = User.find_by_id(1).feed.paginate(:page => params[:page])
 @adminuser = User.find(1)
  @feed_items = @adminuser.ideas.paginate(:page => params[:page])
  
    @response = Response.new
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
