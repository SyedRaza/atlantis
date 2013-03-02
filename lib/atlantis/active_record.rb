module ActiveRecordExtention
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:before_create, :before_create)
    base.send(:before_update, :before_update)
  end

  def age
    if self.respond_to? :created_at
      d = (Date.today - self.created_at.time.to_date).to_i
      if d == 0
        'today'
      elsif d < 7
        "#{d}d"
      else
        "#{(d/7).round}w"
      end
    end
  end

  private
  def before_create
    if self.respond_to? :user_id
      if self.respond_to? :auto_assign_user
        if  self.auto_assign_user == true
          self.user = current_user
        end
      else
        self.user = current_user
      end
    end
  end

  def before_update
    if self.respond_to? :updated_by
      self.updated_by = current_user
    end
  end

  module ClassMethods
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtention)