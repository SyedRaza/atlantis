# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbi.query("SELECT id from users")
puts
while row = res.fetch_row do
  sql = "INSERT INTO user_roles (user_id, role_id) VALUES (#{row[0]}, 2)"
  dbi.query(sql)
end

puts "Number of rows returned: #{res.num_rows}"