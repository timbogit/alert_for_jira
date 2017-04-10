require "dotenv"
Dotenv.load ".env"

### Getting all JIRA users to whom JIRA issues are assigned in a given project
issues = AlertForJira::Jira.issues_in_project(name: "ACME")
assignees = issues.map(&:assignee)
jira_issues_emails = assignees.map(&:emailAddress)

### Getting all JIRA users whom are part of a given project
project = AlertForJira::Jira.project(name: "ACME")
jira_project_users = project.users
jira_user_emails = project.users.map(&:emailAddress)

# Getting a user by key -- easy with `jira-ruby`
jira_timbo = AlertForJira::Jira.user(key: "tim_schmelmer")
# Getting a user by email address -- not part of `jira-ruby`, needs using RestClient
jira_timbo_rest = AlertForJira::Jira.user_by_email("tim_schmelmer@hotmail.com")

### Getting on-call schedule for a team and the user information in VictorOps
vo_schedule = AlertForJira::VictorOps.get_team_schedule(team: 'example')
vo_user_handle = vo_schedule.schedule[0].onCall
vo_user = AlertForJira::VictorOps.get_user(handle: vo_user_handle)

### Switching all open "On-Call" issues to be assigned to the oncall
schedules = AlertForJira::PagerDuty.get_schedules()
user_ids = schedules[0].users.map(&:id)

users = user_ids.map { |id| AlertForJira::PagerDuty.get_user(id) }
on_call_emails = users.map(&:email)
primary_email = on_call_emails[0]


open_on_call_issues = AlertForJira::Jira.on_call_issues(project_name: "ACME")
#all_on_call_issues = AlertForJira::Jira.on_call_issues(project_name: "ACME", all: true)

open_on_call_issues.map do |issue|
  AlertForJira::Jira.assign_issue_to_user(user_email: primary_email,
        issue: issue)
end
