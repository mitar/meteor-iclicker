Meteor.methods
  'create-meeting': (name) ->
    check name, NonEmptyString

    throw new Meteor.Error 401, "User not signed in." unless @userId

    Meeting.documents.insert
      createdAt: new Date()
      facilitator:
        _id: @userId
      name: name

new PublishEndpoint 'meeting-by-id', (meetingId) ->
  check meetingId, DocumentId

  Meeting.documents.find
    _id: meetingId

new PublishEndpoint 'meetings', ->
  Meeting.documents.find {},
    fields:
      items: 0
