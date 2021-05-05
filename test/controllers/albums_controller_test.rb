require_relative "../test_helper"

describe AlbumsController do
  before do
    @album_count = Album.count
  end

  it "should create album with defaults" do
    params = {
      name: "Ten",
      year: 1990,
      album_art: "https://en.wikipedia.org/wiki/Ten_(Pearl_Jam_album)#/media/File:PearlJam-Ten2.jpg" ,
    }

    res = post("/albums", params)

    assert_equal 201, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal params[:name], body["name"]
    assert_equal params[:year], body["year"]
    assert_equal params[:album_art], body["album_art"]
    assert_equal 0, body["total_duration"]

    assert_empty body["cached_songs"]

    assert_equal (@album_count + 1), Album.count
  end

  it "should require mandatory fields" do
    params = {}

    res = post("/albums", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_present"], body["errors"]["name"]
    assert_equal ["not_present"], body["errors"]["year"]

    assert_equal @album_count, Album.count
  end

  it "should validate format" do
    params = {
      name: "Ten",
      year: "ABCD",
      album_art: "https://en.wikipedia.org/wiki/Ten_(Pearl_Jam_album)#/media/File:PearlJam-Ten2.jpg" ,
    }

    res = post("/albums", params)

    assert_equal 400, res.status
    assert_equal "application/json; charset=utf-8", res.headers["Content-type"]

    body = JSON.parse(res.body)

    assert_equal ["not_numeric"], body["errors"]["year"]

    assert_equal @album_count, Album.count
  end
end
