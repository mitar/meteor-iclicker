class @User extends Document
  # createdAt: time of creation
  # username: user's username
  # emails: list of
  #   address: e-mail address
  #   verified: is e-mail address verified
  # services: list of authentication/linked services
  # isFacilitator
  # iClickerId

  @Meta
    name: 'User'
    collection: Meteor.users
