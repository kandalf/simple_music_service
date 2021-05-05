require_relative "../../lib/validators/create_album"

class AlbumsController < ApplicationController
  include Response

  def create
    validator = Validators::CreateAlbum.new(album_params)

    return json_bad_request(validator.errors) unless validator.valid?

    begin
      album = Album.create(validator.attributes)

      json_created(album)
    rescue => e
      logger.error(e)
      json_error
    end
  end

  private
  def album_params
    {
      name: params[:name],
      year: params[:year],
      album_art: params[:album_art],
      total_duration: params[:total_duration],
      cached_songs: params[:cached_songs]
    }
  end
end
