class @Meeting extends Document
  # createdAt: time of creation
  # facilitator:
  #   _id: User id
  # name: text
  # items: list of
  #   _id: AgendaItem id

  @Meta
    name: 'Meeting'
    fields: =>
      facilitator: @ReferenceField User
      items: [@ReferenceField AgendaItem]
