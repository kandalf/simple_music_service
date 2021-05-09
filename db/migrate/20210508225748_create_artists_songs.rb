class CreateArtistsSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :artists_songs, id: false do |t|
      t.belongs_to :artist
      t.belongs_to :song
    end
  end
end
