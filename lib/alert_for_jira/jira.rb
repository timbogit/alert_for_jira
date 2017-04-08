require "jira-ruby"

module AlertForJira
  class Jira
    def self.client
      @client ||= JIRA::Client.new({
        :username     => 'admin',
        :password     => AlertForJira.jira_password,
        :site         => AlertForJira.jira_site,
        :context_path => '',
        :auth_type    => :basic
      })
    end
  end
end
