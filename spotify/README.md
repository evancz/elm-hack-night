# A Simple Spotify Client for Elm

## Building & Developing

``` sh
$ elm package install --yes
$ elm reactor

Then open http://localhost:8000/Main.elm.
```

## Challenges

### Learn About Rendering (Easy)

The UI is a bit dull. Liven it up.

Play around with `View.elm`. See how it creates HTML from the
data-model, and how it handles attributes and children. We've pulling
in Bootstrap 3, so you have those components available if you want
them.

### Clean Up The Compiler Warnings (Medium)

If you compile the app with `elm make Main.elm --warn`, you'll see
we've got some work to do. Going through that list will teach you a
lot about how Elm's types work, and hence how the app is structured.

### Learn About JSON-Handling (Harder)

We need album art. Pull the album art links from Spotify's JSON
response.

Start by looking at the payload in the console, then change
`Types.elm` and `Rest.elm` to extract it into the data-model. Lastly,
change `View` to render it.

For bonus points, put an HTML5 audio player in so the user can click
for a preview of each track.

### Support More Query Types (Hard)

The app is hard-coded to search for albums. If you look in `Rest.elm`
you'll see why. Expand this so that the user has control over their
search type. Start looking in `Types.elm` and expanding `model.query`
to be a richer type. Then follow the compiler errors through until the
rest of the app agrees with your new model.

You'll need to read (the Spotify API docs)[https://developer.spotify.com/web-api/console/get-search-item/#complete] to know what's available.
