#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "companies"
},
{
  :order => [:id, :name, :info, :user_id, :created_at, :updated_at]
}

pre_process :truncate, :target => :development, :table => 'companies'
before_write :check_unique, :keys => [:id, :name, :info, :user_id, :created_at, :updated_at]

after_read :copy_field, :source => :id, :dest => :id
after_read :copy_field, :source => :name, :dest => :title
after_read :copy_field, :source => :info, :dest => :note
after_read :copy_field, :source => :user_id, :dest => :user_id
after_read :copy_field, :source => :created_at, :dest => :created_at
after_read :copy_field, :source => :updated_at, :dest => :updated_at

destination :out,{
  :type => :database,
  :target => :development,
  :database => 'atlantis_development',
  :table => "companies"
},
{
  :order => [:id, :title, :note, :user_id, :created_at, :updated_at]
}