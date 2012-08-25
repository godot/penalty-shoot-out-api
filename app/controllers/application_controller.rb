class ApplicationController < ActionController::API
  private
  def current_user
    params[:user] ||= "user-#{user_uuid}"
    User.new(params[:user])
  end

  def user_uuid
    Rails.logger.info "generating user uuid"
    request.env['HTTP_USER_AGENT'].hash.abs
  end
end
