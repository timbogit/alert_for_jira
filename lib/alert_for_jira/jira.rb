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

    def self.user(key:)
      client.User.find(key)
    end

    def self.user_by_email(email)
      rest_user = request_for(path: "user/search", params: {username: email})[0]
      user(key: rest_user["key"])
    end

    def self.on_call_issues(project_name:, on_call_label: "On-Call", all: false)
      query = "project=#{project_name} AND labels=#{on_call_label}"
      query += " AND status!=Done" unless all
      client.Issue.jql(query)
    end

    def self.create_issue_for_user(user_email:, project_name:, issue:)
      #TODO
    end

    private

    def self.request_for(method: :get, path:, params: nil)
      response = RestClient::Request.execute(method: :get,
                  url: "#{AlertForJira.jira_site}rest/api/2/#{path}",
                  headers: { :"Content-Type" =>  "application/json",
                             :"Authorization" => "Basic #{Base64.encode64("admin:" + AlertForJira.jira_password)}",
                             params: params })
      if response.code > 199 && response.code < 300
        return Array(JSON.parse(response.body)).map{|elem| Hashie::Mash.new(elem)}
      else
        return nil
      end
    end

  end
end
