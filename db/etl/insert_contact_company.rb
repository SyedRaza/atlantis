# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'mysql2'

dbi = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_development")
dbi.query_options.merge!(:as=>:hash, :symbolize_keys => false)

res = dbi.query("SELECT contact_id, company_id from leads")
res.each do |row|
  unless row[1].nil?
  find_match = "SELECT * from contact_company_profiles where contact_id = #{row[0]} AND company_id = #{row[1]}"
  fetch_match = dbi.query(find_match)
  match_row = fetch_match.first
  if match_row.nil?
    insert = "INSERT INTO contact_company_profiles (contact_id, company_id) VALUES (#{row[0]}, #{row[1]})"
    inserted = dbi.query(insert)
  end
  end
#puts row
end
#sql = "update leads set contact_id = #{row[0]} where leads.id = #{row[1]}"

#puts "Number of rows returned: #{res.num_rows}"