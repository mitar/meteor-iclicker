Meteor.publish null, ->
  return unless @userId

  User.documents.find
    _id: @userId
    active: true
  ,
    fields:
      isFacilitator: 1
      iClickerId: 1

Accounts.validateLoginAttempt (loginAttempt) ->
  return false unless loginAttempt.allowed

  # No dot at the end of the error message to match Meteor messages.
  throw new Meteor.Error 403, "User is deactivated" unless loginAttempt.user.active

  return true

# Forbid users from making any modifications to their user document.
User.Meta.collection.deny
  update: ->
    true
