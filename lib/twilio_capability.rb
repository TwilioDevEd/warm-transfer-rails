module TwilioCapability
  def self.generate(agent_id)
    # To find TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN visit
    # https://www.twilio.com/user/account
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    capability = Twilio::JWT::Capability.new(account_sid, auth_token)

    capability.allow_client_incoming(agent_id)
    capability.generate
  end
end
