# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql'

dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT contacts.id as contact, leads.id as lead from contacts, leads where contacts.firstname = leads.first_name AND contacts.lastname = leads.last_name group by contacts.id")
puts
while row = res.fetch_row do
  sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  dbi.query(sql)
end


puts "Number of rows returned: #{res.num_rows}"
