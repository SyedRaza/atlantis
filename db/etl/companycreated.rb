# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql2'

#dbh = Mysql.real_connect("localhost", "root", "password", "db_dump")
dbi = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_development")
dbi.query_options.merge!(:as=>:hash, :symbolize_keys => false)

res = dbi.query("SELECT id, title from companies where created_at IS NULL")
res.each do |row|
  #puts row[1]
  puts find_match = "SELECT created_at, updated_at from leads where company_id = #{row[0]}"
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
  match     = dbi.query(find_match)
  match_row = match.first
  puts insert = "update companies set created_at = '#{match_row[0]}', updated_at = '#{match_row[1]}' where id = #{row[0]}"
  inserted = dbi.query(insert)
end

puts "Number of rows returned: #{res.count}"
