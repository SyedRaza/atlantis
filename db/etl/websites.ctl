#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "websitedetails",
  :conditions => "website !=''"
},
{
  :order => [:id, :parent_id, :websitetype_id, :website, :created_at, :updated_at, :parent_type]
}

pre_process :truncate, :target => :development, :table => 'websites'
before_write :check_unique, :keys => [:id, :parent_id, :websitetype_id, :website, :created_at, :updated_at, :parent_type]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :parent_id, :dest => :websiteable_id
after_read :copy_field, :source => :websitetype_id, :dest => :website_type_id
after_read :copy_field, :source => :website, :dest => :url
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :parent_type, :dest => :websiteable_type

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "websites"
},
{
  :order => [:id, :url, :website_type_id, :websiteable_id, :websiteable_type, :created_at, :updated_at]
}