# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbi.query("SELECT id from users")
puts
while row = res.fetch_row do
  unless row[0] == 50
    sql = "UPDATE users set time_zone = 'Eastern Time (US & Canada)' where id = #{row[0]}"
    dbi.query(sql)
  end
end
puts "Number of rows returned: #{res.num_rows}"
