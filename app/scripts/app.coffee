App = Ember.Application.create
  LOG_TRANSITIONS: true

App.MESSAGES = [
  {
    messageId: '1'
    subject: 'statically typed language'
    text: 'A language in which types are fixed at compile time.'
  },
  {
    messageId: '2'
    subject: 'dynamically typed language'
    text: 'A language in which types are discovered at execution time'
  }
]

App.Router.map ->
  this.route 'about', path: '/aboutus'
  this.resource 'messages', ->
    this.resource 'message', path: '/:messageId'

App.MessagesRoute = Ember.Route.extend
  model: ->
    App.MESSAGES

App.MessageRoute = Ember.Route.extend
  model: (params) ->
    App.MESSAGES.findBy 'messageId', params.messageId

App.IndexController = Ember.Controller.extend
  messagesCount: 12
  time: (->
    (new Date()).toDateString()
  ).property()
