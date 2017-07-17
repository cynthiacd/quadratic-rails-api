class AddColPatternsToTrinomials < ActiveRecord::Migration[5.0]
  def change
    add_column :trinomials, :pattern, :string
  end
end
