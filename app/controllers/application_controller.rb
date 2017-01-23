class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_bee_game
    @bee_game = session[:bee_game].deep_symbolize_keys
  end

  def initialize_bees
    session[:bee_game] ||= BuildSessionHashService.new.call
    session[:hits] ||= 0
    session[:min_hits] ||= 0
    set_bee_game
  end

  def reset_bees
    session[:bee_game] = BuildSessionHashService.new.call
    session[:hits] = 0
    set_bee_game
  end
end
