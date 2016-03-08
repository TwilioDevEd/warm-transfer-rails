class ConferenceController < ApplicationController
  def connect_client
    twiml = TwimlGenerator.generate_connect_conference(params[:CallSid], conference_wait_url, false, true)

    render xml: twiml
  end
end
