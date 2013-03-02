# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT id, xdoctype_id from xdocdetails")

while row = res.fetch_row do
  type = dbh.query("SELECT title from xdoctypes where id = #{row[1]}")
  #puts type
  get_type = type.fetch_row
  unless get_type.nil?
    escaped = Mysql.escape_string(get_type[0])
    type_id = dbi.query("select id from note_types where title = '#{escaped}'")
    id = type_id.fetch_row
    update_id = dbi.query("update notes set note_type_id = #{id[0]} where id = '#{row[0]}'")
  end
end


puts "Number of rows returned: #{res.num_rows}"
