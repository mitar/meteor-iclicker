# When password is reset or user enrolls we change the location to the index page.
Deps.autorun ->
  userId = Meteor.userId()

  return unless userId

  currentRouteController = Router.current()

  return unless currentRouteController?.route.getName() in ['resetPassword', 'enrollAccount']

  # User is logged in, but we are on reset password on enroll account page, go to the index page.
  # TODO: Replace current page with the index page, without keeping tokens location in the history
  Router.go 'index'
