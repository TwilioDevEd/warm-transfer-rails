module TwilioCapability
  def self.generate(agent_id)
    # To find TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN visit
    # https://www.twilio.com/user/account
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    capability = Twilio::JWT::ClientCapability.new(account_sid, auth_token)
    incomingScope = Twilio::JWT::ClientCapability::IncomingClientScope.new agent_id
    capability.add_scope incomingScope

    capability.to_s
  end
end
