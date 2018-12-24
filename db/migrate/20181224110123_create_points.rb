class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pg_trgm"
    create_table :points do |t|
      t.string :name
      t.integer :parent_id
      t.string :stib_id
    end
  end
end
