require 'twilio-ruby'

describe TwilioCapability do
  describe '.generate' do
    it 'generates a capability token' do
      capability_double = double(:capability)
      agent_id = 'agent'

      allow(Twilio::JWT::ClientCapability).to receive(:new)
        .with(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
        .and_return(capability_double)

      expect(capability_double).to receive(:add_scope)
        .once

      described_class.generate(agent_id)
    end
  end
end
