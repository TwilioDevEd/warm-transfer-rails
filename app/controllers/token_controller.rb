class TokenController < ApplicationController
  def generate
    result = { token: TwilioCapability.generate(params[:role]) }
    render json: result
  end
end
