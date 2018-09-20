
require 'win32ole'
xl = WIN32OLE.connect('Excel.Application')
path = "#{Dir.pwd}/generated_excel/report.xlsx"
wb = xl.Workbooks.Open(path)

xlColumns = 2
xlColumnClustered = 51
xlWhite = 2
xlRed = 3
xlBlue = 5
xlGray = 15

mychart = wb.Charts.Add
mychart.Name = "Order Count Summary Chart"

mychart.SetSourceData wb.Worksheets("Order Count DateWise").Range("A1:B3"), xlColumns

mychart.ChartType = xlColumnClustered

mychart.HasTitle = true
mychart.ChartTitle.Characters.Text = "Date Range Order Count "
mychart.ChartTitle.Font.Name = 'Verdana'
mychart.ChartTitle.Font.Size = 16
mychart.ChartTitle.Font.Bold = true
mychart.ChartTitle.Font.Color = '#7299d8' 
