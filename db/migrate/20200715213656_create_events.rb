class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :venue
      t.timestamp :start_time
      t.timestamp :end_time
      t.boolean :is_free
      t.integer :gate_fee
      t.boolean :is_active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
