#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "xdocdetails"
},
{
  :order => [:detail]
}

pre_process :truncate, :target => :development, :table => 'note_generals'
before_write :check_unique, :keys => [:detail]

after_read :copy_field, :source => :detail, :dest => :description


destination :out, {
  :type => :database,
  :target => :development,
  :database => "atlantis_development",
  :table => "note_generals"
},
{
  :order => [:description]
}