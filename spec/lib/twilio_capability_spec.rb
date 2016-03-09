require 'twilio-ruby'
require_relative '../../lib/twilio_capability'

describe TwilioCapability do
  describe '.generate' do
    it 'generates a capability token' do
      capability_double = double(:capability)
      role = 'agent'

      allow(Twilio::Util::Capability).to receive(:new)
        .with(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
        .and_return(capability_double)

      expect(capability_double).to receive(:allow_client_incoming)
        .with(role)
        .once

      expect(capability_double).to receive(:generate)
        .once

      described_class.generate(role)
    end
  end
end
