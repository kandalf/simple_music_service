require_relative "./base"

module Presenters
  class Song < Base
    def render(object)
      {
        id: object.id,
        name: object.name,
        duration: object.duration,
        genre: object.genre,
        artists: object.artists&.map(&:name),
        created_at: object.created_at.iso8601,
        updated_at: object.updated_at.iso8601
      }
    end
  end
end

