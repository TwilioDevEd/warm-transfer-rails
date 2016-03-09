class ConferenceController < ApplicationController
  def connect_client
    CallCreator.call_agent('agent_1', conference_connect_agent1_url)

    twiml = TwimlGenerator.generate_connect_conference(params[:CallSid], conference_wait_url, false, true)
    render xml: twiml
  end
end
