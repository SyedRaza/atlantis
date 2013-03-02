#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "emaildetails",
  :conditions => "email!=''"
},
{
  :order => [:id, :parent_id, :emailtype_id, :email, :created_at, :updated_at, :parent_type]
}

pre_process :truncate, :target => :development, :table => 'emails'
before_write :check_unique, :keys => [:id, :parent_id, :emailtype_id, :email, :created_at, :updated_at, :parent_type]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :parent_id, :dest => :emailable_id
after_read :copy_field, :source => :emailtype_id, :dest => :email_type_id
after_read :copy_field, :source => :email, :dest => :email
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :parent_type, :dest => :emailable_type

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "emails"
},
{
  :order => [:id, :email, :email_type_id, :emailable_id, :emailable_type, :created_at, :updated_at]
}