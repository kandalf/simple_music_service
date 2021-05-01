class Song < ApplicationRecord
  enum genre: [:alternative_rock, :blues, :classical,
              :country, :electronic, :funk, :heavy_metal,
              :hip_hop, :jazz, :pop, :reggae, :soul, :rock]
end
