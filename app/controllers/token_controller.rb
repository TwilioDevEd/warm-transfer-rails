class TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def generate
    agent_id = params[:agent_id]
    render json: { token: TwilioCapability.generate(agent_id), agentId: agent_id }
  end
end
