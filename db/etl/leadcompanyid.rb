# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT id, company from leads")
while row = res.fetch_row do
  find_match = "SELECT id from companies where title = '#{row[1]}'"
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  match = dbi.query(find_match)
  match_row = match.fetch_row
  unless match_row.nil?
  insert = "update leads set company_id = #{match_row[0]} where id = #{row[0]}"
  inserted = dbi.query(insert)
  end
end

puts "Number of rows returned: #{res.num_rows}"