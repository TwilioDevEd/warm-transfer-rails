describe CallCreator do
  let(:agent_id)     { 'jhondoe' }
  let(:callback_url) { 'http://www.example.com' }
  let(:client_double) { double(:client) }

  describe '.call_agent' do
    it 'creates a call to a twilio web client' do
      allow(Twilio::REST::Client).to receive(:new).and_return(client_double)
      expect(client_double).to receive_message_chain(:account, :calls, :create)

      described_class.call_agent(agent_id, callback_url)
    end
  end
end
