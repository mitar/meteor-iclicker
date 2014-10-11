new PublishEndpoint 'meeting-by-id', (meetingId) ->
  check meetingId, DocumentId

  Meeting.documents.find
    _id: meetingId

new PublishEndpoint 'meetings', ->
  Meeting.documents.find {},
    fields:
      items: 0
