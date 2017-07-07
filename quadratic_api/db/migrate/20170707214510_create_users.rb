class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :pattern_plus_plus
      t.integer :pattern_minus_plus
      t.integer :pattern_minus_minus
      t.integer :pattern_plus_minus
      t.integer :pattern_plus_dbl_sq
      t.integer :pattern_minus_dbl_sq
      t.integer :pattern_diff_sq
      t.integer :pattern_primes
      t.integer :pattern_ones_and_zeros
      t.integer :pattern_gcf

      t.timestamps
    end
  end
end
