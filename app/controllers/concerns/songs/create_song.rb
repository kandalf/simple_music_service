module Songs
  class CreateSong
    include Scoped::Concern

    def initialize(attrs = {})
      @name = attrs[:name]
      @duration = attrs[:duration]
      @genre = attrs[:genre]
      @album_ids = attrs[:albums]
      @artists = attrs[:artists]
    end

    def run
      begin
        ActiveRecord::Base.transaction do
          @song = Song.create(name: @name, duration: @duration, genre: @genre.to_sym)

          if @artists.any?
            @artists.each do |art|
              if art[:id]
                artist = Artist.find(art[:id])
              else
                artist = Artist.create(art)
              end

              artist.add_song(@song)

              # Needed to refresh association from the database
              @song.reload
            end
          end

          if @album_ids.any?
            albums = Album.where(id: @album_ids)

            albums.each do |album|
              album.add_song(@song)
            end
          end

        end

        success(song: @song)
      rescue => e
        error(create_song: e.message, backtrace: e.backtrace.join("\n"))
      end
    end
  end
end
