# Songs API

This document describes the `/songs` API.

## Create Song

`POST /songs`

Creates a song record. Besides the song attributes, this endpoint also accepts an array of album IDs to associate with the song and a collection of artists information.
If an entry in the artist information contains the `:id` key, the rest of the attributes of that entry will be ignored an the song will be associated with an artist identified with that ID if exists. Otherwise a `400 Bad Request` response will be retruned. If there's no `:id` key, a new artist will be created with the `:name` and `:biography` attributes.

The following attributes are supported in a JSON request body:

* `name`: Song name. String. Required.
* `duration`: Duration of the song in seconds. Integer. Required
* `genre`: Genre of the song. One of the following options: `alternative_rock`, `blues`, `classical`,`country`, `electronic`, `funk`, `heavy_metal`, `hip_hop`, `jazz`, `pop`, `reggae`, `soul`, `rock`
. String. Required
* `albums`: Collection of album IDs to associate with the song. Array. Required.
* `artists`: Collection of artist information to associate with the song. See conditions in the description. Hash. Required

### Request
```
POST /songs

Content-type: application/json

{
  "name": "Wicked Garden",
  "duration": 245,
  "genre": "alternative_rock",
  "albums": [98, 30],
  "artists": [{ "name": "Stone Temple Pilots", "biography": "Best alternative rock band ever" }, { "id": 120 }]
}
```

### Responses

#### Success
```
201 Created
Content-type: application/json; charset=utf-8

{
  "id": 102,
  "name": "Wicked Garden",
  "duration": 245,
  "genre": "alternative_rock",
  "artists": ["Stone Temple Pilots", "Scott Weiland"],
  "created_at": "2021-05-09T21:58:15Z",
  "updated_at": "2021-05-09T21:58:15Z"
}
```

#### Bad Request
```
400 Bad Request
Content-type: application/json; charset=utf-8

{
  "errors": {
    "name": ["not_present"],
    "duration": ["not_present", "not_numeric"],
    "genre": ["not_present", "not_valid"],
    "album_id": ["not_valid"],
    "artist_id": ["not_valid"]
  }
}
```

