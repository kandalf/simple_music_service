require "scrivener"

module Validators
  class CreateAlbum < Scrivener
    attr_accessor :name, :year, :album_art, :total_duration, :cached_songs

    def validate
      self.total_duration ||= 0
      self.cached_songs ||= {}

      assert_present :name
      assert_numeric :total_duration
      assert cached_songs.is_a?(Hash), [:cached_songs, :not_valid]

      if assert_present :year
        assert_numeric :year
      end
    end
  end
end
