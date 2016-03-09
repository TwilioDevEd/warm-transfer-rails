require 'rails_helper'

RSpec.describe TokenController, type: :controller do
  describe '#generate' do
    role = 'agent'
    it "generates a capibility token" do
      expect(TwilioCapability).to receive(:generate)
        .with(role)
        .once
        .and_return('token')

      post :generate, role: role

      expect(response).to be_ok
    end
  end
end
