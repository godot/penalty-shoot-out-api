class WelcomeController < ApplicationController
  def index
    render json: Index.new(format:'json')
  end
end
