class CreateSongs < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE genre AS ENUM ('alternative_rock', 'blues', 'classical', 'country', 'electronic', 'funk', 'heavy_metal', 'hip_hop', 'jazz', 'pop', 'reggae', 'soul', 'rock');
    SQL

    create_table :songs do |t|
      t.string :name
      t.integer :duration
      t.integer :streams

      t.timestamps
    end

    add_column :songs, :genre, :genre, index: true
  end

  def down
    drop_table :songs

    execute <<-SQL
      DROP TYPE genre;
    SQL
  end
end

