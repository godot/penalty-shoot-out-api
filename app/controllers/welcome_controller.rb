class WelcomeController < ApplicationController
  def index
    render json: Presenters::Index.new(format:'json')
  end
end
