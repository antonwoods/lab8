class PagesController < ApplicationController
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
