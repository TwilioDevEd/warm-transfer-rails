class TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def generate
    result = { token: TwilioCapability.generate(params[:role]) }
    render json: result
  end
end
