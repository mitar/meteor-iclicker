class @Meeting extends Document
  # createdAt: time of creation
  # facilitator:
  #   _id: User id
  # name: text

  @Meta
    name: 'Meeting'
    fields: =>
      facilitator: @ReferenceField User
