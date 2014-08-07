require 'spec_helper'

describe EbtBalanceSmsApp do
  context 'an initial text in' do
    it 'initiates a Twilio call' do
      @fake_twilio = double("FakeTwilioService", :make_call => 'yay!')
      allow(TwilioService).to receive(:new).and_return(@fake_twilio)
      @ebt_number = "1111222233334444"
      @texter_number = "+12223334444"
      post '/', { "Body" => @ebt_number, "From" => @texter_number }
      expect(@fake_twilio).to have_received(:make_call).with(
        url: "http://example.org/get_balance?phone_number=#{@texter_number}",
        to: '+18773289677',
        send_digits: "ww1ww#{@ebt_number}",
        from: '14157982736',
        record: 'true',
        method: 'GET'
      )
      expect(last_response.status).to eq(200)
    end
  end
end
