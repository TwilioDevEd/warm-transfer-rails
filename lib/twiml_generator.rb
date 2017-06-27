module TwimlGenerator
  def self.generate_connect_conference(conference_id, wait_url,
                                       start_on_enter, end_on_exit)
    r = Twilio::TwiML::VoiceResponse.new
    d = Twilio::TwiML::Dial.new
    d.conference(conference_id, start_conference_on_enter: start_on_enter,
                                end_conference_on_exit: end_on_exit,
                                wait_url: wait_url)
    r.append(d)
    r.to_xml_str
  end

  def self.generate_wait
    r = Twilio::TwiML::VoiceResponse.new
    r.say('Thank you for calling. Please wait in line for a few seconds. ' \
          'An agent will be with you shortly.')
    r.play(url: 'http://com.twilio.music.classical.s3.amazonaws.com/BusyStrings.mp3',
           loop: 0)
    r.to_xml_str
  end
end
