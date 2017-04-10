require "rest-client"
require "hashie"

module AlertForJira
  class VictorOps

    def self.get_team_schedule(team:)
      request_for(path: "team/#{team}/oncall/schedule", params: { daysForward: 14 })
    end

    def self.get_user(handle:)
      request_for(path: "user/#{handle}")
    end

    private

    def self.request_for(method: :get, path:, params: nil)
      response = RestClient::Request.execute(method: :get,
                  url: "https://api.victorops.com/api-public/v1/#{path}",
                  headers: { :"Accept" => "application/json",
                             :"X-VO-Api-Id" => AlertForJira.vo_api_id,
                             :"X-VO-Api-Key" => AlertForJira.vo_api_key,
                             params: params })
      if response.code > 199 && response.code < 300
        return Hashie::Mash.new(JSON.parse(response.body))
      else
        return nil
      end
    end
  end
end
