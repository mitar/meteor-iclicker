Template.addAgendaItem.events
  'submit form': (event, template) ->
    event.preventDefault()

    actionItem = template.$('.action-item').is(':checked')
    description = template.$('.description').val()

    return unless description

    Meteor.call 'create-agenda-item', @_id, actionItem, description, (error) ->
      alert error if error

    return # Make sure CoffeeScript does not return anything
