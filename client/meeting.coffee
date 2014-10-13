Template.meeting.agendaItems = ->
  AgendaItem.documents.find
    'meeting._id': @_id

Template.addMeeting.events
  'submit form': (event, template) ->
    event.preventDefault()

    name = template.$('.name').val().trim()

    return unless name

    Meteor.call 'create-meeting', name, (error) ->
      return alert error if error

      template.$('.name').val('')

    return # Make sure CoffeeScript does not return anything
