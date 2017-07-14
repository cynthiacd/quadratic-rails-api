class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :mastery_plus_plus, default: 0
      t.integer :mastery_minus_plus, default: 0
      t.integer :mastery_minus_minus, default: 0
      t.integer :mastery_plus_minus, default: 0
      t.integer :mastery_plus_dbl_sq, default: 0
      t.integer :mastery_minus_dbl_sq, default: 0
      t.integer :mastery_diff_sq, default: 0
      t.integer :mastery_prime, default: 0
      t.integer :mastery_ones_and_zeros, default: 0
      t.integer :mastery_gcf, default: 0
      t.timestamps
    end
  end
end
