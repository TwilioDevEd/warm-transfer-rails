module CallCreator
  def self.call_agent(agent_id, callback_url)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_number = ENV['TWILIO_NUMBER']

    client = Twilio::REST::Client.new account_sid, auth_token

    call = client.account.calls.create(
      from: '+14159341234',
      to: "client:#{agent_id}",
      url: callback_url
    )
  end
end
