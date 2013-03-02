module Admin
  class NoteTypesController < Admin::AdminController
    active_scaffold :note_type do |config|
      #conf.nested.add_scoped_link(:children) #nested link to children
      config.columns = [:title]
    end
  end

  protected

  # If nested let active_scaffold manage everything
  # if not just show all root nodes
  def beginning_of_chain
    nested? ? super : active_scaffold_config.model.roots
  end

  # Assign parent node to just created node
  def after_create_save(record)
    if (nested? && nested.scope)
      parent = nested_parent_record(:read)
      record.send("#{nested.scope}").send(:<<, parent) unless parent.nil?
    end
  end
  
end