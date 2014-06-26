App = Ember.Application.create
  LOG_TRANSITIONS: true

App.ApplicationAdapter = DS.FixtureAdapter

App.Router.map ->
  this.route 'about', path: '/aboutus'
  this.resource 'messages', ->
    this.resource 'message', path: '/:message_id'

App.IndexRoute = Ember.Route.extend
  model: ->
    this.store.findAll 'message'

App.MessagesRoute = Ember.Route.extend
  model: ->
    this.store.findAll 'message'

App.MessageRoute = Ember.Route.extend
  model: (params) ->
    this.store.find 'message', params.message_id

App.Message = DS.Model.extend
  subject: DS.attr 'string'
  text: DS.attr 'string'
  isUnread: DS.attr 'boolean'
  comments: DS.hasMany 'comment', async: true
App.Message.FIXTURES = [
  {
    id: 1
    subject: 'statically typed language'
    text: 'A language in which types are fixed at compile time.'
    isUnread: false
    comments: [100, 200]
  }
  {
    id: 2
    subject: 'dynamically typed language'
    text: 'A language in which types are discovered at execution time'
    isUnread: true
  }
]

App.Comment = DS.Model.extend
  message: DS.belongsTo 'message'
  text: DS.attr 'string'
  postedAt: DS.attr 'date'
App.Comment.FIXTURES = [
  {
    id: 100
    message: 1
    text: 'C is statically typed language.'
  }
  {
    id: 200
    message: 1
    text: 'So is Java.'
  }
]

App.IndexController = Ember.ArrayController.extend
  unreadMessages: (->
    this.filterBy 'isUnread'
  ).property('@each.isUnread')
  messagesCount: (->
    # Look at "length" property at ArrayController.
    # Then it will delegate to the model, and call "model.length".
    this.get 'length'
  ).property('length')
  time: (->
    (new Date()).toDateString()
  ).property()

App.MessagesController = Ember.ArrayController.extend
  sortProperties: ['subject']

App.MessageController = Ember.ObjectController.extend
  feedback_text: ''
  actions:
    createComment: ->
      # Build a new Comment object.
      feedback = this.store.createRecord 'comment',
        text: this.get 'feedback_text'
        message: this.get 'model'
        postedAt: new Date()
      # Need to be able to reference the controller in the save callback.
      controller = this
      # Save it in a storage.
      feedback.save().then (comment) ->
        controller.set('feedback_text', '')
        controller.get('model.comments').addObject(comment)

App.MessageDetailsComponent = Ember.Component.extend
  commentsCount: Ember.computed.alias 'message.comments.length'
  hasComments: (->
    this.get('commentsCount') > 0
  ).property('commentsCount')
