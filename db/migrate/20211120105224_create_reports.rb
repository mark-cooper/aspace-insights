class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :checksum, null: false
      t.jsonb :data, null: false
      t.integer :day, null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.timestamps
    end
    add_reference :reports, :reportable, polymorphic: true, index: true
    add_index :reports, :day
    add_index :reports, :month
    add_index :reports, :year
    add_index :reports, %i[checksum day month year reportable_id reportable_type],
              unique: true,
              name: 'index_reports_on_checksum_and_date_and_reportable'
  end
end
