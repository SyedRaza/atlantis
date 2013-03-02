#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "xdocs"
},
{
  :order => [:id, :title, :created_at, :updated_at]
}

before_write :check_unique, :keys => [:title]

destination :out, {
  :file => "source_data/xdocs.txt"
},
{
  :order => [:id, :title, :created_at, :updated_at]
}