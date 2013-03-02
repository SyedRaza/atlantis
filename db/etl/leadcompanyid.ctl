#puts "executing load_customers.ctl"

ETL::Engine.logger = Logger.new(STDOUT)
#ETL::Engine.logger.level = Logger::DEBUG

source :in,{
  :type => :database,
  :target => :old,
  :database => "db_dump",
  :table => "companies, leads",
  :conditions => "companies.name = leads.company",
  :select => "companies.id, companies.firstname, companies.lastname, leads.id as leadid"
},
{
  :order => [:id]
}


before_write :check_unique, :keys => [:leadid]

transform :company_id, :foreign_key_lookup,
  {
    :resolver => ActiveRecordResolver.new(
      Company, :find_by_display_name
    ),
    :default => nil
  }


after_read :copy_field, :source => :id, :dest => :company_id

destination :out, {
  :type => :database,
  :target => :development,
  :database => "atlantis_development",
  :table => "leads",
  :conditions => "leads.id = "
},
{
  :order => [:id, :]
}