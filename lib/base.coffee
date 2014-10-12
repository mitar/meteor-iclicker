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
