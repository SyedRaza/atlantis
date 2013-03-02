#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "addressdetails",
  :conditions => "street !='' or ( state!='' or ( city!='' or zip!='' or country_id!=''))"
},
{
  :order => [:id, :parent_id, :addersstype_id, :street, :city, :state, :zip, :country_id, :created_at, :updated_at, :parent_type]
}

pre_process :truncate, :target => :development, :table => 'addresses'
before_write :check_unique, :keys => [:id, :parent_id, :addersstype_id, :street, :city, :state, :zip, :country_id, :created_at, :updated_at, :parent_type]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :parent_id, :dest => :addressable_id
after_read :copy_field, :source => :addresstype_id, :dest => :address_type_id
after_read :copy_field, :source => :street, :dest => :street
after_read :copy_field, :source => :city, :dest => :city
after_read :copy_field, :source => :state, :dest => :state
after_read :copy_field, :source => :zip, :dest => :zip
after_read :copy_field, :source => :country_id, :dest => :country_id
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at
after_read :copy_field, :source => :parent_type, :dest => :addressable_type

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "addresses"
},
{
  :order => [:id, :street, :city, :state, :zip, :country_id, :address_type_id, :addressable_id, :addressable_type, :created_at, :updated_at]
}