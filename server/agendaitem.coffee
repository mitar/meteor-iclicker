Meteor.methods
  'create-agenda-item': (meetingId, actionItem, description) ->
    check meetingId, DocumentId
    check actionItem, Boolean
    check description, NonEmptyString

    throw new Meteor.Error 401, "User not signed in." unless @userId

    # TODO: Verify that meetingId exists

    AgendaItem.documents.insert
      createdAt: new Date()
      author:
        _id: @userId
      meeting:
        _id: meetingId
      actionItem: actionItem
      description: description
      notes: Random.id() unless actionItem

new PublishEndpoint 'agendaitems-by-meeting-id', (meetingId) ->
  check meetingId, DocumentId

  AgendaItem.documents.find
    'meeting._id': meetingId
