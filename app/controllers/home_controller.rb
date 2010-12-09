class HomeController < ApplicationController
  def index
    @players = Player.find(:all, :include => :women).sort { |x, y| y.women.size <=> x.women.size }
  end
end