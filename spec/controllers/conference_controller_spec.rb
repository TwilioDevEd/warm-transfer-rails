require 'spec_helper'

RSpec.describe ConferenceController, type: :controller do
  let(:callback_url) { 'http://www.example.com' }

  describe '#connect_client' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with("1234", conference_wait_url, false, true)
        .once
        .and_return('<Response></Response>')

      expect(CallCreator).to receive(:call_agent)
        .with("agent_1", conference_connect_agent1_url)
        .once
        .and_return(0)

      get :connect_client, CallSid: "1234"

      expect(response).to be_ok
    end
  end
end
