class Note < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30

  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  belongs_to :type, :class_name => 'NoteType', :foreign_key=>'note_type_id'

  belongs_to :detail, :polymorphic=>true
  accepts_nested_attributes_for :detail

  belongs_to :parent, :polymorphic=>true

  scope :with_today, lambda { |today| find(:all, :conditions=>{:created_at=>Date.today..Date.tomorrow}) }
  search_methods :with_today

  default_scope :order=>'created_at DESC'
end
