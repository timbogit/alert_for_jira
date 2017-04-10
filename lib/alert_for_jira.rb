require "alert_for_jira/version"
require "alert_for_jira/pager_duty"
require "alert_for_jira/victor_ops"
require "alert_for_jira/jira"

module AlertForJira
  class << self
    # Public: set the API token string for the challenge service
    attr_writer :pd_api_token, :jira_password, :jira_site, :vo_api_id, :vo_api_key

    # Private: obtain the currently configured API token string for PagerDuty
    def pd_api_token
      pd_api_token = @pd_api_token || ENV['PD_API_TOKEN']
      raise 'AlertForJira.pd_api_token has not been configured' unless pd_api_token
      pd_api_token
    end

    # Private: obtain the currently configured API ID string for VictorOps
    def vo_api_id
      vo_api_id = @vo_api_id || ENV['VICTOR_OPS_API_ID']
      raise 'AlertForJira.vo_api_id has not been configured' unless vo_api_id
      vo_api_id
    end

    # Private: obtain the currently configured API Key string for VictorOps
    def vo_api_key
      vo_api_key = @vo_api_key || ENV['VICTOR_OPS_API_KEY']
      raise 'AlertForJira.vo_api_key has not been configured' unless vo_api_key
      vo_api_key
    end

    # Private: obtain the currently configured API token string for JIRA
    def jira_password
      jira_password = @pd_api_token || ENV['JIRA_PASSWORD']
      raise 'AlertForJira.jira_password has not been configured' unless jira_password
      jira_password
    end

    # Private: obtain the currently configured API token string for JIRA
    def jira_site
      jira_site = @pd_api_token || ENV['JIRA_SITE']
      raise 'AlertForJira.jira_site has not been configured' unless jira_site
      jira_site
    end
  end
end
