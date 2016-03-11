module TwimlGenerator
  def self.generate_connect_conference(call_sid, wait_url, start_on_enter, end_on_exit)
    Twilio::TwiML::Response.new do |r|
      r.Dial do |d|
        d.Conference call_sid, startConferenceOnEnter: start_on_enter,
                               endConferenceOnExit: end_on_exit,
                               waitUrl: wait_url
      end
    end.to_xml
  end

  def self.generate_wait
    Twilio::TwiML::Response.new do |r|
      r.Say 'Thank you for calling. Please wait in line for a few seconds. An agent will be with you shortly.'
      r.Play 'http://com.twilio.music.classical.s3.amazonaws.com/BusyStrings.mp3'
    end.to_xml
  end
end
