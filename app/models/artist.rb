class Artist < ApplicationRecord
  has_one :artist_balance
  has_and_belongs_to_many :songs

  def add_song(song)
    self.songs << song
  end
end
