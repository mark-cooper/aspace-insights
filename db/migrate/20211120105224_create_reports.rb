class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :month, null: false
      t.integer :total, default: 0
      t.timestamps
    end
    add_reference :reports, :reportable, polymorphic: true, index: true
  end
end
