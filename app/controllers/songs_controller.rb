require_relative "../../lib/validators/create_song"
require_relative "../../lib/presenters/song"

class SongsController < ApplicationController
  include Songs

  def create
    validator = Validators::CreateSong.new(song_params)

    return json_bad_request(validator.errors) unless validator.valid?

    create_song = Songs::CreateSong.run(validator.attributes)

    if create_song.success?
      presenter = Presenters::Song.new(create_song.result[:song])
      json_created(presenter.show)
    else
      logger.error(create_song.errors)
      json_error
    end
  end

  private
  def song_params
    allowed = params.permit(:name, :duration, :genre,
                            albums: [], artists: [:id, :name, :biography])

    {
      name: allowed[:name],
      duration: allowed[:duration],
      genre: allowed[:genre],
      albums: allowed[:albums],
      artists:  allowed[:artists]&.map(&:to_h)
    }
  end
end
