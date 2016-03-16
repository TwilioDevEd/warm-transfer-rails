class ConferenceController < ApplicationController
  skip_before_filter :verify_authenticity_token

  AGENT_WAIT_URL = 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical'

  def connect_client
    agent_id = 'agent1'
    conference_id = params[:CallSid]
    Caller.call_agent(
      agent_id,
      conference_connect_agent1_url(conference_id: conference_id)
    )

    twiml = TwimlGenerator.generate_connect_conference(
      conference_id,
      conference_wait_url,
      false,
      true
    )

    call = ActiveCall.with_agent_id(agent_id).first_or_create(
      conference_id: conference_id
    )
    call.conference_id = conference_id
    call.save!

    render xml: twiml
  end

  def connect_agent1
    twiml = TwimlGenerator.generate_connect_conference(
      params[:conference_id],
      AGENT_WAIT_URL,
      true,
      false
    )

    render xml: twiml
  end

  def connect_agent2
    twiml = TwimlGenerator.generate_connect_conference(
      params[:conference_id],
      AGENT_WAIT_URL,
      true,
      true
    )

    render xml: twiml
  end

  def call_agent2
    agent_id = params[:agent_id]
    conference_id = ActiveCall.where(agent_id: agent_id).first.conference_id

    Caller.call_agent(
      'agent2',
      conference_connect_agent2_url(conference_id: conference_id)
    )

    render nothing: true
  end

  def wait
    twiml = TwimlGenerator.generate_wait
    render xml: twiml
  end
end
