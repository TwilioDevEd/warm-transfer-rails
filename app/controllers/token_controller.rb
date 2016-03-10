class TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def generate
    role = params[:role]
    result = { token: TwilioCapability.generate(role), role: role }
    render json: result
  end
end
