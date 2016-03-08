require 'spec_helper'

RSpec.describe ConferenceController, type: :controller do
  describe '#connect_client' do
    it "returns Dial Conference TwiML" do
      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with("1234", conference_wait_url, false, true)
        .and_return('<Response></Response>')

      get :connect_client, CallSid: "1234"

      expect(response).to be_ok
    end
  end
end
