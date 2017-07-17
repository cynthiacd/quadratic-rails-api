class CreateTrinomials < ActiveRecord::Migration[5.0]
  def change
    create_table :trinomials do |t|
      t.integer :root1
      t.integer :root2
      t.timestamps
    end
  end
end
