App = Ember.Application.create
  LOG_TRANSITIONS: true

App.ApplicationAdapter = DS.FixtureAdapter

App.Router.map ->
  this.route 'about', path: '/aboutus'
  this.resource 'messages', ->
    this.resource 'message', path: '/:message_id'

App.MessagesRoute = Ember.Route.extend
  model: ->
    this.store.findAll 'message'

App.MessageRoute = Ember.Route.extend
  model: (params) ->
    this.store.find 'message', params.message_id

App.Message = DS.Model.extend
  subject: DS.attr 'string'
  text: DS.attr 'string'
App.Message.FIXTURES = [
  {
    id: 1
    subject: 'statically typed language'
    text: 'A language in which types are fixed at compile time.'
  }
  {
    id: 2
    subject: 'dynamically typed language'
    text: 'A language in which types are discovered at execution time'
  }
]

App.IndexController = Ember.Controller.extend
  messagesCount: 12
  time: (->
    (new Date()).toDateString()
  ).property()
