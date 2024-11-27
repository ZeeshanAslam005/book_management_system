class GenerateMonthlySalesReportJob < ActiveJob::Base
  queue_as :default

  def perform
    Bookstore.find_each do |bookstore|
      report_data = generate_report_for(bookstore)
      send_report_email(bookstore, report_data)
    end
  end

  private

  def generate_report_for(bookstore)
    start_date = Time.now.beginning_of_month - 1.month
    end_date = Time.now.beginning_of_month
    orders = bookstore.books.joins(:orders).where(orders: { created_at: start_date..end_date })

    total_sales = orders.sum('orders.total_price')
    total_orders = orders.count

    {
      total_sales: total_sales,
      total_orders: total_orders,
      start_date: start_date,
      end_date: end_date
    }
  end

  def send_report_email(bookstore, report_data)
    ReportMailer.monthly_sales_report(bookstore, report_data).deliver_now
  end
end
