new PublishEndpoint 'motions-by-meeting-id', (meetingId) ->
  check meetingId, DocumentId

  Motion.documents.find
    'meeting._id': meetingId
