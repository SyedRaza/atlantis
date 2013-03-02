# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

#dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbi.query("SELECT id from contacts where created_at IS NULL")
while row = res.fetch_row do
  #puts row[1]
  puts find_match = "SELECT created_at, updated_at from leads where contact_id = #{row[0]}"
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  match = dbi.query(find_match)
  match_row = match.fetch_row
  puts insert = "update contacts set created_at = '#{match_row[0]}', updated_at = '#{match_row[1]}' where id = #{row[0]}"
  inserted = dbi.query(insert)
end

puts "Number of rows returned: #{res.num_rows}"