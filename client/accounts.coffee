Template.registerHelper 'curentUserIsFacilitator', ->
  !!Meteor.user()?.isFacilitator
