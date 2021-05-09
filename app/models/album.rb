class Album < ApplicationRecord
  validates :name, presence: true
  validates :total_duration, numericality: true
  validates :year, presence: true, numericality: true

  def add_song(song)
    self.cached_songs ||= {}

    songs = self.cached_songs.tap do |cached|
      cached[song.id] = {
        name: song.name,
        duration: song.duration,
        genre: song.genre,
        artists: song.artists.map(&:name)
      }
    end

    self.update(
      total_duration: self.total_duration + song.duration,
      cached_songs: songs
    )
  end
end
