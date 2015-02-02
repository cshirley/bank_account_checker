
class ApiException < StandardError;end
class AuthenticationError < StandardError;end
class InvalidBankAccount < StandardError;end
module Faraday
  class Response::BankAccountChecker< Response::Middleware

    def call(env)
      @app.call(env).on_complete do
        response = JSON.parse(env[:body])
        check_status response
      end
    end

    def check_status(body)
      result_code = body["resultCode"].to_i
      raise AuthenticationError.new(body["resultDescription"]) if result_code == 5
      raise ApiException.new(body["resultDescription"]) if result_code > 5
      raise InvalidBankAccount.new(body["resultDescription"]) if result_code != 1
    end
  end
end
