Router.route '/',
  name: 'index'
  template: 'index'
  waitOn: ->
    Meteor.subscribe 'meetings'

Router.route '/meeting/:_id',
  name: 'meeting'
  template: 'meeting'
  waitOn: ->
    Meteor.subscribe 'meeting-by-id', @params._id
  data: ->
    Meeting.documents.findOne @params._id
