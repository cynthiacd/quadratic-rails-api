class AddColsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :plus_plus_count, :integer, default: 0
    add_column :users, :minus_plus_count, :integer, default: 0
    add_column :users, :minus_minus_count, :integer, default: 0
    add_column :users, :plus_minus_count, :integer, default: 0
    add_column :users, :plus_dbl_sq_count, :integer, default: 0
    add_column :users, :minus_dbl_sq_count, :integer, default: 0
    add_column :users, :diff_sq_count, :integer, default: 0
    add_column :users, :prime_count, :integer, default: 0
    add_column :users, :gcf_count, :integer, default: 0
  end
end
