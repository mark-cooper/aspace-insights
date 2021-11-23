class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :checksum, null: false
      t.jsonb :data, null: false
      t.integer :month, null: false
      t.timestamps
    end
    add_reference :reports, :reportable, polymorphic: true, index: true
    add_index :reports, %i[month checksum reportable_id], unique: true
  end
end
