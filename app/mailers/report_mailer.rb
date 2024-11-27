class ReportMailer < ActionMailer::Base
  default from: 'no-reply@example.com'

  def monthly_sales_report(bookstore, report_data)
    @bookstore = bookstore
    @report_data = report_data

    mail(
      to: bookstore.manager.email,
      subject: "Monthly Sales Report for #{@bookstore.name}"
    )
  end
end
