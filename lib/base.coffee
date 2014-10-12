Router.route '/',
  name: 'index'
  template: 'index'
  waitOn: ->
    Meteor.subscribe 'meetings',
      onError: (error) -> alert error

Router.route '/meeting/:_id',
  name: 'meeting'
  template: 'meeting'
  waitOn: ->
    [
      Meteor.subscribe 'meeting-by-id', @params._id,
        onError: (error) -> alert error
      Meteor.subscribe 'agendaitems-by-meeting-id', @params._id,
        onError: (error) -> alert error
      Meteor.subscribe 'motions-by-meeting-id', @params._id,
        onError: (error) -> alert error
    ]
  data: ->
    Meeting.documents.findOne @params._id

Router.route '/reset-password/:resetPasswordToken',
  action: ->
    # Make sure nobody is logged in, it would be confusing otherwise
    # TODO: How to make it sure we do not log in in the first place? How could we set autoLoginEnabled in time? Because this logs out user in all tabs
    Meteor.logout()

    Accounts._loginButtonsSession.set 'resetPasswordToken', @params.resetPasswordToken

    # TODO: Replace current page with the index page, without keeping tokens location in the history
    @redirect 'index'

Router.route '/enroll-account/:enrollAccountToken',
  action: ->
    # Make sure nobody is logged in, it would be confusing otherwise
    # TODO: How to make it sure we do not log in in the first place? How could we set autoLoginEnabled in time? Because this logs out user in all tabs
    Meteor.logout()

    Accounts._loginButtonsSession.set 'enrollAccountToken', @params.enrollAccountToken

    # TODO: Replace current page with the index page, without keeping tokens location in the history
    @redirect 'index'
