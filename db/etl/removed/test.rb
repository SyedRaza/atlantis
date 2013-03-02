# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT companies.id as company, leads.id as lead from companies, leads where companies.name = leads.company group by companies.id")
puts
while row = res.fetch_row do
  sql = "update leads set company_id = #{row[0]} where leads.id = #{row[1]}"
  dbi.query(sql)
end


puts "Number of rows returned: #{res.num_rows}"




