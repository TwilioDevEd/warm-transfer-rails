require 'twilio-ruby'
require 'nokogiri'

describe TwimlGenerator do
  describe '.generate_connect_conference' do
    it 'generates twiml with dial and conference nodes' do
      call_sid = 'CallSID'
      url = 'http://www.example.com'

      xml_string = described_class.generate_connect_conference(call_sid, url, true, false)
      document = Nokogiri::XML(xml_string)

      dial_node = document.xpath("//Dial").first
      conference_node = dial_node.xpath("//Conference").first
      expect(dial_node.name).to eq('Dial')
      expect(conference_node.name).to eq('Conference')
      expect(conference_node.attribute('startConferenceOnEnter').content)
        .to eq('true')
      expect(conference_node.attribute('endConferenceOnExit').content)
        .to eq('false')
      expect(conference_node.attribute('waitUrl').content).to eq(url)
    end
  end

  describe '.generate_wait' do
    it 'generates twiml with say and play nodes' do
      xml_string = described_class.generate_wait
      document = Nokogiri::XML(xml_string)
      say = document.xpath('//Say').first
      expect(say.name).to eq('Say')
      expect(say.content)
        .to eq('Thank you for calling. Please wait in line for a few seconds. An agent will be with you shortly.')
      play = document.xpath('//Play').first
      expect(play.name).to eq('Play')
      expect(play.content)
        .to eq('http://com.twilio.music.classical.s3.amazonaws.com/BusyStrings.mp3')
    end
  end
end
