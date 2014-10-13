Router.route '/',
  name: 'index'
  template: 'index'
  waitOn: ->
    Meteor.subscribe 'meetings',
      onError: (error) -> alert error

# TODO: Slug is not really optional, why?
Router.route '/meeting/:_id/:slug?',
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
  onBeforeAction: ->
    meeting = @data()

    return @next() unless meeting

    # @params.slug is null if slug is not present in location, so we use
    # null when meeting.slug is empty string to prevent infinite looping
    return @next() if (meeting.slug or null) is @params.slug

    # TODO: Replace current page with the correct slug, without keeping tokens location in the history
    @redirect 'meeting', meeting

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
