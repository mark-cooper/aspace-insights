class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :name
      t.references :instance, index: true, foreign_key: true
      t.timestamps
    end
  end
end
