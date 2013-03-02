# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT created_at, detail from xdocdetails")

while row = res.fetch_row do
  escaped = Mysql.escape_string(row[1])
  detail_id = dbi.query("select id from note_generals where description = '#{escaped}'")
  id = detail_id.fetch_row
  update_id = dbi.query("update notes set detail_id = #{id[0]} where created_at = '#{row[0]}'")
end


puts "Number of rows returned: #{res.num_rows}"


