require 'twilio-ruby'

describe Caller do
  describe '.call_agent' do
    it 'creates a call to a Twilio web client' do
      agent_id = 'jhondoe'
      callback_url = 'http://www.example.com'
      calls_double = double(:calls)

      allow_any_instance_of(Twilio::REST::Client).to receive(:calls)
        .and_return(calls_double)

      expect(calls_double).to receive(:create)
        .with(from: ENV['TWILIO_NUMBER'],
              to: "client:#{agent_id}",
              url: callback_url)
        .once

      described_class.call_agent(agent_id, callback_url)
    end
  end
end
