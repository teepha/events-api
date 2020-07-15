class SetDefaultForUserRole < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :is_admin, :boolean, default: false
  end
end
