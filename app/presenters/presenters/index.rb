class Index
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  attr_accessor :params
  def initialize(params)
    @params = params
  end

  property :user
  def user
    params[:user]
  end

  link :self do
    root_url(url_params)
  end

  link :games do
    games_index_url(url_params)
  end

  link :new_game do
    games_create_url(url_params)
  end

  def url_params
    {
      format:params[:format],
      user:params[:user].to_param
    }
  end
end
