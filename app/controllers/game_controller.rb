class GameController < ApplicationController
  def index
    @root_bee_hash = Bee.bee_hash
    reset_bees if params[:reset]
    reset_score if params[:reset_score]
    initialize_bees
  end

  private

  def reset_score
    session[:min_hits] = 0
  end
end
