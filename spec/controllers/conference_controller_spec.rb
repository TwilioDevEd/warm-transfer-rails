require 'rails_helper'

RSpec.describe ConferenceController, type: :controller do
  let(:callback_url)   { 'http://www.example.com' }
  let(:agent_wait_url) { 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical' }
  let(:call_sid)       { "1234" }

  describe '#connect_client' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(call_sid, conference_wait_url, false, true)
        .once
        .and_return('<Response></Response>')

      expect(CallCreator).to receive(:call_agent)
        .with("agent1", conference_connect_agent1_url(conference_id: call_sid))
        .once

      post :connect_client, CallSid: call_sid

      expect(response).to be_ok
    end
  end

  describe '#connect_agent1' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(call_sid, agent_wait_url, true, false)
        .once
        .and_return('<Response></Response>')

      post :connect_agent1, conference_id: call_sid

      expect(response).to be_ok
    end
  end

  describe '#connect_agent2' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(call_sid, agent_wait_url, true, true)
        .once
        .and_return('<Response></Response>')

      post :connect_agent2, conference_id: call_sid

      expect(response).to be_ok
    end
  end

  describe '#call_agent2' do
    it "creates a call to agent 2" do
      expect(CallCreator).to receive(:call_agent)
        .with("agent2", conference_connect_agent2_url(conference_id: call_sid))
        .once

      post :call_agent2, conference_id: call_sid

      expect(response).to be_ok
    end
  end

  describe '#wait' do
    it "returns Dial Conference TwiML" do

      expect(TwimlGenerator).to receive(:generate_wait)
        .once
        .and_return('<Response></Response>')

      post :wait

      expect(response).to be_ok
    end
  end
end
