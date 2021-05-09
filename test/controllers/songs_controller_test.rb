require_relative "../test_helper"

describe SongsController do
  before do
    @album = Album.spawn
  end

  it "should validate required attributes" do
    params = {}

    res = post("/songs", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_present"], body["errors"]["name"]
    assert_equal ["not_present"], body["errors"]["duration"]
    assert_equal ["not_present"], body["errors"]["genre"]
  end

  it "should validate album exists" do
    artist = Artist.spawn

    params = {
      name: "Creep",
      duration: 333,
      genre: :alternative_rock,
      albums: [@album.id, @album.id + 10],
      artists: [{ id: artist.id }]
    }

    res = post("/songs", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_valid"], body["errors"]["album_id"]
  end

  it "should validate artist exists" do
    params = {
      name: "Wicked Garden",
      duration: 245,
      genre: :alternative_rock,
      albums: [@album.id],
      artists: [
        { id: 0 }
      ]
    }

    res = post("/songs", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_valid"], body["errors"]["artist_id"]
  end

  it "should create with artist" do
    params = {
      name: "Wicked Garden",
      duration: 245,
      genre: :alternative_rock,
      albums: [@album.id],
      artists: [
        { name: "Stone Temple Pilots", biography: "Awesome American Rock Band" }
      ]
    }

    artist_count = Artist.count
    album_songs = @album.cached_songs || {}

    res = post("/songs", params)

    assert_equal 201, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]


    artist = Artist.find_by_name(params[:artists][0][:name])
    @album.reload

    body   = JSON.parse(res.body)

    assert artist
    assert_equal(artist_count + 1, Artist.count)
    assert_equal(album_songs.size + 1, @album.cached_songs.size)

    assert_equal params[:name], body["name"]
    assert_equal params[:duration], body["duration"]
    assert_equal params[:genre].to_s, body["genre"]

    assert_equal [artist.name], body["artists"]
  end

  it "should associate with artist and album" do
    album = Album.spawn(name: "Facelift", year: 1990, total_duration: 0)
    artist = Artist.spawn(name: "Alice in Chains")

    artist_count = Artist.count
    album_songs = album.cached_songs || {}

    params = {
      name: "Man in the Box",
      duration: 285,
      genre: :alternative_rock,
      albums: [album.id],
      artists: [
        { id: artist.id }
      ]
    }

    res = post("/songs", params)

    album.reload
    artist.reload

    assert_equal 201, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal 1, album.cached_songs.size

    assert_equal artist_count, Artist.count
    assert_equal album_songs.size + 1, album.cached_songs.size

    assert_equal params[:name], body["name"]
    assert_equal params[:duration], body["duration"]
    assert_equal params[:genre].to_s, body["genre"]
    assert_equal params[:duration], album.total_duration
    assert(artist.songs.map(&:id).include?(body["id"]))
  end

  it "should validate album exists" do
    params = {
      name: "Wicked Garden",
      duration: 245,
      genre: :alternative_rock,
      albums: [-1],
      artists: [
        { id: 1 }
      ]
    }

    refute Album.where(id: params[:albums][0]).any?

    res = post("/songs", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_valid"], body["errors"]["album_id"]
  end

end
