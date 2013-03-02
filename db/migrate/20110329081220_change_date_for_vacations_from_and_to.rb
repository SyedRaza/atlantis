class ChangeDateForVacationsFromAndTo < ActiveRecord::Migration
  def self.up
    change_table :vacations do |t|
      t.change :from, :date
      t.change :to, :date
    end
  end

  def self.down
    change_table :vacations do |t|
      t.change :from, :datetime
      t.change :to, :datetime
    end
  end
end
