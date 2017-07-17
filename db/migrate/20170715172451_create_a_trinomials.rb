class CreateATrinomials < ActiveRecord::Migration[5.0]
  def change
    create_table :a_trinomials do |t|
      t.integer :root1
      t.integer :root2
      t.string :pattern, default: "a_greater_one"
      t.timestamps
    end
  end
end
