class SetDefaultForEventActive < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :is_active, :boolean, default: true
  end
end
