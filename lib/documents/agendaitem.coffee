class @AgendaItem extends Document
  # createdAt: time of creation
  # author:
  #   _id: User id
  # meeting:
  #   _id: Meeting id
  # actionItem: boolean
  # description: text

  @Meta
    name: 'AgendaItem'
    fields: =>
      author: @ReferenceField User
      meeting: @ReferenceField Meeting
