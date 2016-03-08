describe TwimlGenerator do
  let(:call_sid) { 'CallSID' }
  let(:url)      { 'http://www.example.com' }

  describe '.generate_connect_conference' do
    it 'generates twiml with correct parameters' do
      xml_string = described_class.generate_connect_conference(call_sid, url, true, false)
      document = Nokogiri::XML(xml_string)

      dial_node = document.root.child
      conference_node = dial_node.child
      expect(dial_node.name).to eq('Dial')
      expect(conference_node.name).to eq('Conference')
      expect(conference_node.attribute('startConferenceOnEnter').content).to eq('true')
      expect(conference_node.attribute('endConferenceOnExit').content).to eq('false')
      expect(conference_node.attribute('waitUrl').content).to eq(url)
    end
  end
end
