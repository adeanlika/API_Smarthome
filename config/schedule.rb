# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :PATH, ENV['PATH']
# Example:
#
set :output, "log/cron_log.log"
#
# every 1.minute do
# #   command "/usr/bin/some_great_command"
# #   runner "MyModel.some_method"
# #   rake "some:great:rake:task"
#   runner "Cron.testing"
# end
# end
#
every 1.day, at: '10:30 am' do
  runner "Cron.saving_daily"
end

# Learn more: http://github.com/javan/whenever
