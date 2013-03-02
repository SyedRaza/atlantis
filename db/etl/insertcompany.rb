# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql2'

dbh = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_old")
dbh.query_options.merge!(:as=>:hash, :symbolize_keys => false)

dbi = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_development")
dbi.query_options.merge!(:as=>:hash, :symbolize_keys => false)

#dbh = Mysql.real_connect("localhost", "root", "password", "atlantis_old")
#dbi = Mysql.real_connect("localhost", "root", "password", "atlantis_development")

res = dbh.query("SELECT company from leads")
res.each do |row|
  unless row[0] == "" or row[0] =="XXXX" or /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/.match(row[0]) or /(^$)|(^(www|WWW)+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix.match(row[0])
    find_match = "SELECT id from companies where title = '#{row[0]}'"
    match      = dbi.query(find_match)
    match_row  = match.first
    #puts match[0]
    if match_row.nil?
      #puts row[0]
      insert   = "INSERT INTO companies (title) VALUES ('#{row[0]}')"
      inserted = dbi.query(insert)
    end
  end
  #sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"
end

puts "Number of rows returned: #{res.count}"