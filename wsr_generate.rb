require 'date'
require_relative 'get_wsr_data.rb'
require_relative 'generate_excel.rb'
require 'pg'
require 'axlsx'
require 'language_converter'


begin
  @start_time = Time.now
  @p = Axlsx::Package.new
  @wb = @p.workbook
  @con = PGconn.connect(  
                         :host=>"server name",
                         :port=>5432,
                         :dbname=>"db name ",
                         :user=>"access_user",
                         :password=>'access_pass'
                        )
  @con.inspect
  @gen_excel = GenerateExcel.new(@wb)
  @from_date,@to_date = @gen_excel.get_date_range
  @date_range = @from_date..@to_date

  get_wsr_data = GetWSRData.new @from_date, @to_date, @con

  ord_count_db_data = get_wsr_data.ord_count_summary 
  status_wise_db_data = get_wsr_data.status_wise_summary
  top_30_db_data = get_wsr_data.top_30_summary

  puts "Data extraction successfully"

  @gen_excel.order_count_date(ord_count_db_data)
  @gen_excel.insert_statuswise_data(status_wise_db_data)
  @gen_excel.insert_top30_data(top_30_db_data)

  @p.serialize("generated_excel/wsr_#{@date_range}.xlsx")
  puts "excel generated wsr_#{@date_range}.xlsx please check"
  @execution_time = Time.now - @start_time
  puts "Execution Duration = #{@execution_time}"
  @con.close
rescue Exception => e
  puts e.backtrace
  @con.close
  @execution_time = Time.now - @start_time
  puts "Execution Duration = #{@execution_time}"
end