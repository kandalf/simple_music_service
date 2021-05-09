require_relative "../test_helper"

describe Album do
  it "should validate required" do
    album = Album.create()

    refute album.persisted?

    assert_equal ["can't be blank"], album.errors[:name]
    assert_equal ["can't be blank", "is not a number"], album.errors[:year]
  end

  it "should validate format" do
    album = Album.create(name: "Ten", year: "ABC", total_duration: "ABC")

    refute album.persisted?

    assert_equal ["is not a number"], album.errors[:total_duration]
    assert_equal ["is not a number"], album.errors[:year]
  end

  it "should update total duration" do
    album = Album.spawn(name: "Core", cached_songs: {}, total_duration: 100)
    artist = Artist.spawn(name: "Stone Temple Pilots", biography: "Fantastic rock band")
    song = Song.spawn(name: "Plush", duration: 314, genre: :alternative_rock)

    artist.songs << song

    album.add_song(song)

    assert_equal 414, album.total_duration
  end

  it "should cache song" do
    album = Album.spawn(name: "Core", cached_songs: {}, total_duration: 100)
    artist = Artist.spawn(name: "Stone Temple Pilots", biography: "Fantastic rock band")
    song = Song.spawn(name: "Creep", duration: 333, genre: :alternative_rock)

    artist.songs << song

    album.add_song(song)

    cached_song = { "name" => song.name, "duration" => song.duration, "genre" => song.genre, "artists" => song.artists.map(&:name) }

    assert_equal cached_song, album.cached_songs[song.id.to_s]
  end
end
