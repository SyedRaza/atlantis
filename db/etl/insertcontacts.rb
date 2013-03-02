# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT first_name, last_name from leads")
while row = res.fetch_row do
  find_match = "SELECT id from contacts where first_name = '#{Mysql.escape_string(row[0])}' AND last_name = '#{Mysql.escape_string(row[1])}'"
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  match = dbi.query(find_match)
  match_row = match.fetch_row
  #puts match[0]
  if match_row.nil?
    #puts row[0]
    #puts row[1]
    insert = "INSERT INTO contacts (contact_status_id, contact_directory_id, contact_type_id, first_name, last_name) VALUES (7, 5, 3, '#{Mysql.escape_string(row[0])}', '#{Mysql.escape_string(row[1])}')"
    inserted = dbi.query(insert)
  end
end


puts "Number of rows returned: #{res.num_rows}"
