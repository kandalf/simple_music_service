Album.extend(Spawn).spawner do |album|
  album.name = "Core"
  album.year = 1992
  album.album_art = "https://en.wikipedia.org/wiki/Core_(Stone_Temple_Pilots_album)#/media/File:Stonetemplepilotscore.jpeg"
  album.total_duration = 0
end

Artist.extend(Spawn).spawner do |artist|
  artist.name = "Alice In Chains"
  artist.biography = "Alice the greatest"
end

Song.extend(Spawn).spawner do |song|
  song.name = "Plush"
  song.duration = 314
  song.genre = :alternative_rock
end
