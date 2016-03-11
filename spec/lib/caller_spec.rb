require 'twilio-ruby'
require_relative '../../lib/caller'

describe Caller do
  describe '.call_agent' do
    it 'creates a call to a Twilio web client' do
      agent_id = 'jhondoe'
      callback_url = 'http://www.example.com'
      client_double = double(:client)
      calls_double =  double(:calls)

      allow(Twilio::REST::Client).to receive(:new).and_return(client_double)
      allow(client_double).to receive_message_chain(:account, :calls).and_return(calls_double)
      expect(calls_double).to receive(:create)
        .with(from: ENV['TWILIO_NUMBER'], to: "client:#{agent_id}", url: callback_url)
        .once

      described_class.call_agent(agent_id, callback_url)
    end
  end
end
