require 'rubygems'
require 'mysql2'

@old_db = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_old")
@old_db.query_options.merge!(:as=>:hash, :symbolize_keys => false)

@new_db = Mysql2::Client.new(
    :host     => "localhost",
    :username => "root",
    :password =>"password",
    :database =>"atlantis_development")
@new_db.query_options.merge!(:as=>:hash, :symbolize_keys => false)

@new_db.query("DELETE FROM phones where phones.phoneable_type = 'Contact' AND phones.phoneable_id NOT IN(SELECT id from contacts)")
@new_db.query("DELETE FROM emails where emails.emailable_type = 'Contact' AND emails.emailable_id NOT IN(SELECT id from contacts)")

def lead_with_name(lead)
  res = @new_db.query(" SELECT * FROM contacts where first_name= \"#{lead["first_name"]}\" AND  last_name= \"#{lead["last_name"]}\" ")
  if res.count > 0
    insert_contact_details(lead, res.first)
  else
    insert_contact(lead)
  end
end

def lead_with_email(lead)
  res = @new_db.query(" SELECT * FROM emails where email = \"#{lead["email"]}\" AND emailable_type='Contact' ")
  unless res.count > 0
    insert_contact(lead)
  end
end

def insert_contact(lead)
  insert = "INSERT INTO contacts (contact_status_id, contact_directory_id, contact_type_id, first_name, last_name, user_id, created_at ,  updated_at) VALUES (7, 5, 3, \"#{lead["first_name"].strip}\", \"#{lead["last_name"].strip}\",#{lead["user_id"]},'#{lead["created_at"]}','#{lead["updated_at"]}')"
  @new_db.query(insert)
  inserted = @new_db.query("SELECT * from contacts where id = #{@new_db.last_id}")
  inserted = inserted.first
  unless lead["email"].nil?
    insert = "INSERT INTO emails (email,	email_type_id,	emailable_id,	emailable_type,created_at,updated_at) VALUES (\"#{lead["email"].strip}\",1,#{inserted["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end
  unless lead["telephone"].nil?
    insert = "INSERT INTO phones (phone_number, phone_type_id, phoneable_id,phoneable_type,created_at,updated_at) VALUES (\"#{lead["telephone"].strip}\",4,#{inserted["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end
  unless lead["mobile"].nil?
    insert = "INSERT INTO phones (phone_number, phone_type_id, phoneable_id,phoneable_type,created_at,updated_at) VALUES (\"#{lead["mobile"].strip}\",6,#{inserted["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end

  puts "#{lead["first_name"]} #{lead["last_name"]} generated "
end

def insert_contact_details(lead, contact)
  res = @new_db.query(" SELECT * FROM emails where email = \"#{lead["email"]}\" AND emailable_type='Contact' AND emailable_id=#{contact["id"]} ")
  unless res.count > 0
    insert = "INSERT INTO emails (email,	email_type_id,	emailable_id,	emailable_type,created_at,updated_at) VALUES (\"#{lead["email"].strip}\",1,#{contact["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end

  res = @new_db.query(" SELECT * FROM phones where phone_number = \"#{lead["telephone"]}\" AND phoneable_type='Contact' AND phoneable_id=#{contact["id"]} ")
  unless res.count > 0
    insert = "INSERT INTO phones (phone_number, phone_type_id, phoneable_id,phoneable_type,created_at,updated_at) VALUES (\"#{lead["telephone"].strip}\",4,#{contact["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end

  res = @new_db.query(" SELECT * FROM phones where phone_number = \"#{lead["mobile"]}\" AND phoneable_type='Contact' AND phoneable_id=#{contact["id"]} ")
  unless res.count > 0
    insert = "INSERT INTO phones (phone_number, phone_type_id, phoneable_id,phoneable_type,created_at,updated_at) VALUES (\"#{lead["mobile"].strip}\",6,#{contact["id"]},'Contact','#{lead["created_at"]}','#{lead["updated_at"]}')"
    @new_db.query(insert)
  end

  unless lead["company"] == "" or lead["company"] =="XXXX" or /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/.match(lead["company"]) or /(^$)|(^(www|WWW)+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix.match(lead["company"])
    res = @new_db.query(" SELECT * FROM companies where title = \"#{lead["company"]}\" ")
    if res.count > 0
      company = res.first
    else
      insert = "INSERT INTO companies (title,	created_at	,updated_at, user_id	) VALUES (\"#{lead["company"].strip}\",'#{lead["created_at"]}','#{lead["updated_at"]}',#{lead["user_id"]})"
      @new_db.query(insert)
      company = @new_db.query("SELECT * from companies where id = #{@new_db.last_id}").first
    end
    res = @new_db.query(" SELECT * FROM contact_company_profiles where contact_id = #{contact["id"]} AND company_id = #{company["id"]}")
    unless res.count > 0
      insert = "INSERT INTO contact_company_profiles (contact_id,company_id,active_date,active,created_at,updated_at) VALUES ( "
      insert += "#{contact["id"]},#{company["id"]},\"#{lead["created_at"]}\",1,\"#{lead["created_at"]}\",\"#{lead["updated_at"]}\" "
      insert += ")"
      @new_db.query(insert)
    end
  end
  puts "Details for #{lead["first_name"]} #{lead["last_name"]} generated "
end

res = @old_db.query(" SELECT * FROM leads")


res.each do |old_lead|
  lead_with_name(old_lead)

#  if not old_lead["email"].nil?
#    lead_with_email(old_lead)
#  else
#    lead_with_name(old_lead)
#  end

end