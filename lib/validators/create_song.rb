require "scrivener"

module Validators
  class CreateSong < Scrivener
    attr_accessor :name, :duration, :genre, :albums, :artists

    def validate
      assert_present :name

      if assert_present :duration
        assert_numeric :duration
      end

      if assert_present :genre
        assert_member :genre, Song.genres
      end

      if albums
        assert albums.is_a?(Array), [:albums, :not_valid]

        album_records = Album.where(id: albums)

        assert album_records.size == albums.size, [:album_id, :not_valid]
      end

      if artists
        if assert(artists.is_a?(Array), [:artists, :not_valid])
          artists.each do |artist|
            if artist[:id]
              assert Artist.where(id: artist[:id]).any?, [:artist_id, :not_valid]
            end
          end
        end
      end
    end
  end
end
