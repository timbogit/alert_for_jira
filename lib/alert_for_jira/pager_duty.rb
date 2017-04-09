require "rest-client"
require "hashie"

module AlertForJira
  class PagerDuty

    def self.get_user(id)
      if response = request_for(path: "users/#{id}")
        response.user
      end
    end

    def self.get_schedules()
      if response = request_for(path: "schedules")
        response.schedules
      end
    end

    private

    def self.request_for(method: :get, path:, params: nil)
      response = RestClient::Request.execute(method: :get,
                  url: "https://api.pagerduty.com/#{path}",
                  headers: { :"Accept" => "application/vnd.pagerduty+json;version=2",
                             :"Authorization" => "Token token=#{AlertForJira.pd_api_token}",
                             params: params })
      if response.code > 199 && response.code < 300
        return Hashie::Mash.new(JSON.parse(response.body))
      else
        return nil
      end
    end

  end
end
