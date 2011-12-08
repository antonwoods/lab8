class IdeasController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

   def create
    @idea  = current_user.ideas.build(params[:idea])
    if @idea.save
      flash[:success] = "idea created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @idea.destroy
    redirect_back_or root_path
  end

  private
  
    def authorized_user
      @idea = current_user.ideas.find_by_id(params[:id])
      redirect_to root_path if @idea.nil?
    end
end