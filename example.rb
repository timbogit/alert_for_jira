require "dotenv"
Dotenv.load ".env"

schedules = AlertForJira::PagerDuty.get_schedules()
user_ids = schedules[0].users.map(&:id)

users = user_ids.map { |id| AlertForJira::PagerDuty.get_user(id) }
pd_emails = users.map(&:email)

issues = AlertForJira::Jira.issues_in_project(name: "ACME")
assignees = issues.map(&:assignee)
jira_issues_emails = assignees.map(&:emailAddress)

project = AlertForJira::Jira.project(name: "ACME")
jira_project_users = project.users
jira_user_emails = project.users.map(&:emailAddress)

all_on_call_issues = AlertForJira::Jira.on_call_issues(project_name: "ACME", all: true)
open_on_call_issues = AlertForJira::Jira.on_call_issues(project_name: "ACME")
