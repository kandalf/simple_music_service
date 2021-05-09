class Song < ApplicationRecord
  enum genre: { alternative_rock: "alternative_rock", blues: "blues", classical: "classical",
              country: "country", electronic: "electronic", funk: "funk", heavy_metal: "heavy_metal",
              hip_hop: "hip_hop", jazz: "jazz", pop: "pop",
              reggae: "reggae", soul: "soul", rock: "rock" }

  has_and_belongs_to_many :artists
end
