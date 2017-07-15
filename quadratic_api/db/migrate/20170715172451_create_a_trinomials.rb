class CreateATrinomials < ActiveRecord::Migration[5.0]
  def change
    create_table :a_trinomials do |t|
      # t.integer :a_coeff, default: 1
      t.float :root1
      t.float :root2
      t.string :pattern
      t.boolean :solution_submitted, default: false
      t.belongs_to :user, default: 1
      t.timestamps
    end
  end
end
