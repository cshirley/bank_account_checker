class InvalidParameterError < StandardError; end
module BankAccountChecker
  class Client
    attr_accessor :api_user, :api_password, :format, :query_type

    def base_url
      "https://www.bankaccountchecker.com/listener.php"
    end

    def initialize(api_user, api_password, format=:json, query_type=:uk)
      @api_user = api_user
      @api_password = api_password
      @format = format.to_s
      @query_type = query_type.to_s
    end

    def get_bank_account(sort_code, account_number)
      raise ArgumentError.new('Valid Sort code is required') unless sort_code && (sort_code.to_s.size == 6)
      raise ArgumentError.new('Valid Account number is required') unless account_number && (account_number.to_s.size == 8)
      query_get_api("", { sortcode:sort_code, bankaccount:account_number})
    end

    def make_request_url(url, options)
      "#{url}?#{build_params(options)}"
    end

    def query_get_api(url, options)
      JSON.parse(session.get(make_request_url(url, options)).body)
    end

    private
    def build_params(options)
      options.merge!(key: @api_user,
                      password: @api_password,
                      format: @format,
                      type: @query_type)
      to_query(options)
    end

    def to_query(options)
      Faraday::Utils.build_nested_query(options)
    end

    def session
      @connection ||= ::Faraday.new base_url do |conn|
        conn.adapter Faraday.default_adapter
        conn.use Faraday::Response::BankAccountChecker
      end
    end

  end
end
