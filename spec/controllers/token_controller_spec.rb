require 'rails_helper'

RSpec.describe TokenController, type: :controller do
  describe '#generate' do
    agent_id = 'agent'
    it "generates a capability token" do
      expect(TwilioCapability).to receive(:generate)
        .with(agent_id)
        .once
        .and_return('token')

      post :generate, agent_id: agent_id

      expect(response).to be_ok
    end
  end
end
