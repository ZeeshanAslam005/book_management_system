set :output, "log/cron.log"

every :month, at: 'start of the month at 12am' do
  rake "reports:generate_monthly_sales"
end
