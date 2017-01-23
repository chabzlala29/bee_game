class HitBeeController < ApplicationController
  before_action :set_bee_game

  def create
    sample_bee_key = get_sample_bee_key
    bee = Bee.new(key: get_sample_bee_key, current_bee: @bee_game[sample_bee_key])

    service = HitBeeService.new(bee: bee, bee_game: @bee_game, hits: session[:hits], min_hits: session[:min_hits])
    session[:bee_game] = service.call

    if alive_bees.size > 0
      initialize_bees
      session[:hits] = service.hits
      session[:min_hits] = service.min_hits
    else
      set_min_hits
      reset_bees
    end

    redirect_to root_path
  end

  private

  def set_min_hits
    session[:min_hits] = if session[:hits] > 0
                           if session[:min_hits] == 0
                             session[:hits]
                           elsif session[:hits] < session[:min_hits]
                             session[:hits]
                           else
                             0
                           end
                         end
  end

  def get_sample_bee_key
    alive_bees.sample
  end

  def alive_bees
    @bee_game.select { |key, value|
      value[:current_hp] != 0 && value[:current_quantity] != 0
    }.keys || []
  end
end
