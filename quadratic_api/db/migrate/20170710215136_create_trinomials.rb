class CreateTrinomials < ActiveRecord::Migration[5.0]
  def change
    create_table :trinomials do |t|
      t.integer :root1, default: rand(1..13)
      t.integer :root2, default: rand(1..13)
      t.belongs_to :user, default: 1
      t.timestamps
    end
  end
end
