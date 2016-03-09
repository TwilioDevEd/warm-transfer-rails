require 'rails_helper'

RSpec.describe ConferenceController, type: :controller do
  let(:callback_url) { 'http://www.example.com' }
  let(:agent_wait_url) { 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical' }

  describe '#connect_client' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with("1234", conference_wait_url, false, true)
        .once
        .and_return('<Response></Response>')

      expect(CallCreator).to receive(:call_agent)
        .with("agent_1", conference_connect_agent1_url)
        .once

      get :connect_client, CallSid: "1234"

      expect(response).to be_ok
    end
  end

  describe '#connect_agent1' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with("1234", agent_wait_url, false, true)
        .once
        .and_return('<Response></Response>')

      get :connect_agent1, CallSid: "1234"

      expect(response).to be_ok
    end
  end

  describe '#connect_agent2' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with("1234", agent_wait_url, false, true)
        .once
        .and_return('<Response></Response>')

      get :connect_agent2, CallSid: "1234"

      expect(response).to be_ok
    end
  end

  describe '#wait' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_wait)
        .once
        .and_return('<Response></Response>')

      get :wait

      expect(response).to be_ok
    end
  end
end
