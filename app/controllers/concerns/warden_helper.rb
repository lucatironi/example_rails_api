module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :current_user

    prepend_before_action :authenticate!
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end
