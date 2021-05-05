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
end
