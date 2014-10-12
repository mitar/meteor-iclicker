fs = Npm.require 'fs'

syncUsers = (usersFile) ->
  users = JSON.parse fs.readFileSync usersFile
  usersEmail = _.pluck users, 'email'

  User.documents.find(
    'emails.address':
      $nin: usersEmail
    active:
      $ne: false
  ).forEach (user) ->
    count = User.documents.update
      _id: user._id
      'emails.address':
        $nin: usersEmail
      active:
        $ne: false
    ,
      $set:
        active: false

    if count
      console.log "user account has been disabled", user.emails[0].address
      # TODO: Send an e-mail that user account has been disabled
      null

  for user in users
    count = User.documents.update
      'emails.address': user.email
      active:
        $ne: true
    ,
      $set:
        active: true

    if count
      console.log "user account has been enabled", user.email
      # TODO: Send an e-mail that user account has been enabled
      null

    count = User.documents.update
      'emails.address': user.email
      isFacilitator:
        $ne: !!user.isFacilitator
    ,
      $set:
        isFacilitator: !!user.isFacilitator

    if count
      if !!user.isFacilitator
        console.log "user account has become a facilitator", user.email
        # TODO: Send an e-mail that user account has become a facilitator
        null
      else
        console.log "user account has ceased to be a facilitator", user.email
        # TODO: Send an e-mail that user account has ceased to be a facilitator
        null

    unless User.documents.exists('emails.address': user.email)
      userId = Accounts.createUser
        email: user.email

      User.documents.update userId,
        $set:
          active: true
          isFacilitator: !!user.isFacilitator

      Accounts.sendEnrollmentEmail userId

  watcher = fs.watch usersFile, {persistent: false}, Meteor.bindEnvironment (event, filename) ->
    watcher.close()
    syncUsers usersFile

Meteor.startup ->
  usersFile = Meteor.settings?.usersFile

  unless usersFile
    Log.warn "No users file specified in settings"
    return

  syncUsers usersFile
