namespace :send_reports do
  desc "TODO"
  task daily_project_summary: :environment do
    ProjectSummaryJob.perform_now()
    print "I'm in the rake task"
  end
end
