class CreateSpecialTrinomials < ActiveRecord::Migration[5.0]
  def change
    create_table :special_trinomials do |t|
      t.integer :root1
      t.integer :root2
      t.string :pattern
      t.timestamps
    end
  end
end
