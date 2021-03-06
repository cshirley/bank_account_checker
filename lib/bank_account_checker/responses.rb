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
      raise ::BankAccountChecker::AuthenticationError.new(result_code, body["resultDescription"]) if result_code == 5
      raise ::BankAccountChecker::ApiException.new(result_code, body["resultDescription"]) if result_code > 5
      raise ::BankAccountChecker::InvalidBankAccountError.new(result_code, body["resultDescription"]) if result_code != 1
    end
  end
end
