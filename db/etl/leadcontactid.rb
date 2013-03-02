# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT id, first_name, last_name from leads")
while row = res.fetch_row do
  find_match = "SELECT id from contacts where first_name = '#{Mysql.escape_string(row[1])}' AND last_name = '#{Mysql.escape_string(row[2])}'"
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  match = dbi.query(find_match)
  match_row = match.fetch_row
  unless row.nil?
  puts insert = "update leads set contact_id = #{match_row[0]} where id = #{row[0]}" unless match_row.nil?
  end
  inserted = dbi.query(insert)
  
end

puts "Number of rows returned: #{res.num_rows}"