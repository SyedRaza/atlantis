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
  :order => [:xdoctype_id]
}



after_read :copy_field, :source => :xdoctype_id, :dest => :x_doc_type_id

destination :out, {
  :type => :database,
  :target => :development,
  :database => "atlantis_development",
  :table => "x_docs"
},
{
  :order => [:x_doc_type_id]
}