require 'pg'

class GetWSRData
   def initialize from_date,to_date, connection_object
      @from_date = from_date
      @to_date = to_date
      @connection_object = connection_object
   end

   def status_wise_summary
      statuswise_summary_sql = "status wise summary extraction"
     
      statuswise_summary_data = execute_sql @connection_object, statuswise_summary_sql
      puts "status_wise_summary completed"
      return statuswise_summary_data
   end

   def ord_count_summary 
      @order_count_summary = {}

      (@from_date..@to_date).each do |date|
        order_count_sql = "order count based on date range provided"
        @order_count_summary["#{date}"] = execute_sql(@connection_object, order_count_sql)[0]["count"]
      end
      puts "order_count_summary completed"

      return @order_count_summary
   end

    def top_30_summary
      top_30_summary_sql = "top 30 items extraction based ordered quantity"
     
      top_30_summary_data = execute_sql @connection_object, top_30_summary_sql
      puts "top_30_summary completed"
      return top_30_summary_data
   end

   def execute_sql connection_object, query
      begin
        result_set = connection_object.exec query
      rescue Exception => e
        puts e.backtrace
      end
   end
end