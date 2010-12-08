class HomeController < ApplicationController
  def index
    @users = User.find(:all, :include => :women).sort_by { |u| u.women.size }
  end
end