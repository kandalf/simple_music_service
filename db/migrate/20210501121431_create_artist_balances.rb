class CreateArtistBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :artist_balances do |t|
      t.integer :artist_id
      t.float :balance

      t.timestamps
    end

    add_foreign_key :artist_balances, :artists
  end
end
