module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  end

  private

  def invalid_response(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def not_found_response(e)
    json_response({ message: e.message }, :not_found)
  end
end
