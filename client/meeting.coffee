Template.meeting.agendaItems = ->
  AgendaItem.documents.find
    'meeting._id': @_id

Template.addMeeting.events
  'submit form': (event, template) ->
    event.preventDefault()

    name = template.$('.name').val()

    return unless name

    Meteor.call 'create-meeting', name, (error) ->
      alert error if error

    return # Make sure CoffeeScript does not return anything
