require 'axlsx'
require 'pg'
require 'date'
require 'rest-client'
require 'json'
require_relative 'get_wsr_data.rb'


class GenerateExcel
  def initialize excel_write_obj
    @wb = excel_write_obj
  end

  def get_date_range
    puts "enter from date, format should be dd/mm/yyyy"
    from_date = Date.parse(gets.chomp)

    puts "enter to date , format should be dd/mm/yyyy"
    to_date = Date.parse(gets.chomp)

    puts "Date  range for wsr entered  #{from_date} to #{to_date}"
    
    return from_date,to_date
  end

  def insert_statuswise_data db_data
    @wb.add_worksheet(:name => "Warehouse wise orders status ") do |sheet|
      sheet.add_row ["","header names of the sheet",""]
      db_data.each do |row|
        sheet.add_row [row["header name to be filled"], ] 
      end
    end
    puts "Statuswise Orders Summary Excel Export Completed"
  end
    
  def order_count_date db_data
    @wb.add_worksheet(:name => "Order Count DateWise") do |sheet|
      sheet.add_row ["date", "order_count"]
      db_data.each do |k,v|
        sheet.add_row [k,v] 
      end
    end
    puts "Order Count Summary Excel Export Completed"
  end  

  def insert_top30_data db_data
    @wb.add_worksheet(:name => "Top 30 Items") do |sheet|
      sheet.add_row ["headers for the excel "]
      db_data.each do |row|
        row["header value reassigning"] = translate_text(row["header name need to be converted"]) 
        sheet.add_row [row["header name to be filled"], row[""]] 
      end
    end
    puts "Top 30 Items Summary Excel Export Completed"
  end

  def translate_text jp_text
    request_data  = { "text" => "#{jp_text}", "to"=>"en", "from"=>"ja"}
    url = 'http://www.transltr.org/api/translate'
    response =  RestClient::Request.execute(:method => :get,
                                            :url => url,
                                            :verify_ssl => false,
                                            :headers => {
                                                          :params =>request_data,
                                                          :accept => :json,
                                                          :content_type => :json,
                                                          }
                                             )

    eng_text = JSON.parse(response)["translationText"]
    return eng_text
  end
end