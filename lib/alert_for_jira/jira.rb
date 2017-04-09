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

    def self.project(name:)
      client.Project.find(name)
    end

    def self.issues_in_project(name:)
      p = project(name: name)
      if p
        p.issues
      else
        nil
      end
    end

    def self.on_call_issues(project_name:, on_call_label: "On-Call", all: false)
      query = "project=#{project_name} AND labels=#{on_call_label}"
      query += " AND status!=Done" unless all
      client.Issue.jql(query)
    end

    def self.create_issue_for_user(user_email:, project_name:, issue:)
      #TODO
    end
  end
end
