namespace :reports do
  desc "Generate monthly sales reports"
  task generate_monthly_sales: :environment do
    GenerateMonthlySalesReportJob.perform_later
  end
end
