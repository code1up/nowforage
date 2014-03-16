Template.addItem.rendered = ->
  return if @_alreadyCalled
  @_alreadyCalled = true

  video = @find '#camera'
  @_camera = createCamera video
  @_camera.enable()

Template.addItem.preserve ['#camera']

Template.addItem.helpers
  categories: ->
    Categories.find()

  disabled: ->
    if Session.get('isValid') != true
      'disabled'

  location: ->
    coords = Session.get('position')?.coords
    if coords?
      "#{ coords.latitude }, #{ coords.longitude }"
    else
      "Waiting for location"

  picture: ->
    Session.get 'picture'

Template.addItem.events
  'change #description': (event, template) ->
    event.preventDefault()
    description = $(event.target).val()
    Session.set 'description', description

  'change #category': (event, template) ->
    event.preventDefault()
    category = $(event.target).val()
    Session.set 'category', category

  'click button': (event, template) ->
    event.preventDefault()
    coords = Session.get('position').coords
    Items.insert
      category: Session.get 'category'
      description: Session.get 'description'
      latitude: coords.latitude
      longitude: coords.longitude
      picture: Session.get 'picture'
    ,
      (error, _id) ->
        Router.go 'listItems' unless error?

  'click #camera': (event, template) ->
    event.preventDefault()
    picture = template._camera.takePicture()
    template._camera.disable()
    Session.set 'picture', picture

Template.addItem.destroyed = ->
  @_camera.disable()
  delete @_camera

