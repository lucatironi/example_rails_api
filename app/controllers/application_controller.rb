class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound,       with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  def not_found
    render status: :not_found, json: ""
  end

  def missing_param_error(exception)
    render status: :unprocessable_entity, json: { error: exception.message }
  end

end
