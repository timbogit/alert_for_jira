require "alert_for_jira/version"
require "alert_for_jira/pager_duty"
require "alert_for_jira/jira"

module AlertForJira
  class << self
    # Public: set the API token string for the challenge service
    attr_writer :pd_api_token, :jira_password

    # Private: obtain the currently configured API token string for PagerDuty
    def pd_api_token
      pd_api_token = @pd_api_token || ENV['PD_API_TOKEN']
      raise 'AlertForJira.pd_api_token has not been configured' unless pd_api_token
      pd_api_token
    end

    # Private: obtain the currently configured API token string for JIRA
    def jira_password
      jira_password = @pd_api_token || ENV['JIRA_PASSWORD']
      raise 'AlertForJira.jira_password has not been configured' unless jira_password
      jira_password
    end
  end
end
