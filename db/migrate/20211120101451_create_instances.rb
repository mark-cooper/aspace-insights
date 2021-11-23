class CreateInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :instances do |t|
      t.string :code, null: false
      t.string :frontend_url
      t.string :name
      t.string :public_url
      t.string :tier
      t.timestamps
    end
  end
end
