require 'spec_helper'

describe "client" do
  let(:api_user) { "dummy_user" }
  let(:api_password) { "dummy_password" }
  let(:client) { BankAccountChecker::Client.new(api_user, api_password) }
  let(:client_invalid) { BankAccountChecker::Client.new("foo", "bar") }

    describe "intialise" do
      it "should return the correct base URL" do
        expect(client.base_url).to eql "https://www.bankaccountchecker.com/listener.php"
      end

      it "should format the api request" do
        url = client.make_request_url("", {zzzz: "foobar"})
        expect(url).to eql "?format=#{client.format}&key=#{api_user}&password=#{api_password}&type=#{client.query_type}&zzzz=foobar"
      end

      it "should fail with invalid credentials" do
        VCR.use_cassette("bac_invalid_credential") do
          expect { client_invalid.get_bank_account("211111", "11111111")}.to raise_error(AuthenticationError)
        end
      end
    end
    describe "Bank Accounts" do
      it "should fail with invalid format" do
        VCR.use_cassette("bac_invalid_account") do
          expect{client.get_bank_account("111111", "1111111")}.to raise_error(InvalidBankAccountError)
        end
      end
      it "should work wih valid account details" do
        VCR.use_cassette("bac_valid_account") do
          expect( client.get_bank_account("557030", "12345678")['resultCode'].to_i).to eql(1)
        end

      end
    end
end

