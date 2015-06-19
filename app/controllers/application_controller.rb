class ApplicationController < ActionController::Base
  include ApplicationConfiguration
  include ConfigurableMessages
  include DateAndTimeMethods

  attr_accessor :current_user
  protect_from_forgery with: :exception
  before_action :require_current_user
  # access control must occur after finding current user
  before_action :access_control
  layout 'application'

  private

  # Appended as a before_action in controllers by default
  def access_control
    deny_access if @current_user.student?
  end

  # '... and return' is the correct behavior here, disable rubocop warning
  # rubocop:disable Style/AndOr
  def deny_access
    if request.xhr?
      render nothing: true, status: :unauthorized and return
    else
      render file: 'public/401.html',
             status: :unauthorized,
             layout: false and return
    end
  end
  # rubocop:enable Style/AndOr

  def require_current_user
    if session.key?(:user_id) && User.find_by(id: session[:user_id]).present?
      @current_user = User.find session[:user_id]
    else
      redirect_to new_session_path
    end
  end

  # '... and return' is the correct behavior here, disable rubocop warning
  # rubocop:disable Style/AndOr
  def show_errors(object)
    flash[:errors] = object.errors.full_messages
    redirect_to :back and return
  end
  # rubocop:enable Style/AndOr
end
