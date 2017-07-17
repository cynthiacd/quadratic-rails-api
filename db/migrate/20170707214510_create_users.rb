class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :plus_plus_mastery, default: 0
      t.integer :minus_plus_mastery, default: 0
      t.integer :minus_minus_mastery, default: 0
      t.integer :plus_minus_mastery, default: 0
      t.integer :plus_dbl_sq_mastery, default: 0
      t.integer :minus_dbl_sq_mastery, default: 0
      t.integer :diff_sq_mastery, default: 0
      t.integer :prime_mastery, default: 0
      t.integer :a_greater_one_mastery, default: 0
      t.integer :gcf_mastery, default: 0
      t.timestamps
    end
  end
end
