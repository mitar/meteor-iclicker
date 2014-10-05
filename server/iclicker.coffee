displayCollection = new Meteor.Collection null

Meteor.methods
  'iclicker-vote': (clickerId, response, time) ->
    console.log clickerId, response, time

    displayCollection.upsert {},
      $set:
        line: "#{ clickerId }"

Meteor.publish 'display', ->
  handle = displayCollection.find().observeChanges
    added: (id, fields) =>
      @added 'display', id, fields

    changed: (id, fields) =>
      @changed 'display', id, fields

    removed: (id) =>
      @removed 'display', id

  @ready()

  @onStop =>
    handle.stop()
