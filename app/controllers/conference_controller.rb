class ConferenceController < ApplicationController
  skip_before_filter :verify_authenticity_token

  AGENT_WAIT_URL = 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical'

  def connect_client
    CallCreator.call_agent('agent_1', conference_connect_agent1_url)

    twiml = TwimlGenerator
      .generate_connect_conference(params[:CallSid], conference_wait_url, false, true)
    render xml: twiml
  end

  def connect_agent1
    twiml = TwimlGenerator
      .generate_connect_conference(params[:CallSid], AGENT_WAIT_URL, false, true)
    render xml: twiml
  end

  def connect_agent2
    twiml = TwimlGenerator
      .generate_connect_conference(params[:CallSid], AGENT_WAIT_URL, false, true)
    render xml: twiml
  end

  def call_agent2
    CallCreator.call_agent('agent_2', conference_connect_agent2_url)
    render nothing: true
  end

  def wait
    twiml = TwimlGenerator.generate_wait()
    render xml: twiml
  end
end
