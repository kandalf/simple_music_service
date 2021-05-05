# Albums API

This document describes the `/albums` API

## Create Album

`POST /albums`

Creates an album record. The following attributes are supported in a JSON request body:

* `name`: Album name. String. Required.
* `year`: Album release year. Integer. Required
* `album_art`: Album art cover URL. String. Optional

### Request
```
POST /albumbs

Content-type: application/json

{
  "name": "Ten",
  "year": 1991,
  "album_art": "https://en.wikipedia.org/wiki/Ten_(Pearl_Jam_album)#/media/File:PearlJam-Ten2.jpg"
}
```

### Responses

#### Success
```
201 Created
Content-type: application/json; charset=utf-8

{
  "id": 36,
  "name": "Ten",
  "year": 1990,
  "album_art": "https://en.wikipedia.org/wiki/Ten_(Pearl_Jam_album)#/media/File:PearlJam-Ten2.jpg",
  "total_duration": 0,
  "cached_songs": {},
  "created_at": "2021-05-05T13:07:23.433Z",
  "updated_at": "2021-05-05T13:07:23.433Z"
}
```

#### Bad Request
```
400 Bad Request
Content-type: application/json; charset=utf-8

{
  "errors": {
    "name": ["not_present"],
    "year": ["not_present", "not_numeric"]
  }
}
```
