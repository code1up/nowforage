Router.configure ->
  layoutTemplate: 'layout'

Router.map ->
  @route 'addItem',
    path: '/items/add'
    template: 'addItem'

    load: ->
      unsetForAddItem()
      if Session.get 'isGeolocationSupported'
        enableGeolocator()
      else
        Router.go 'listItems'
        @stop()

    before: ->
      category = Session.get 'category'
      description = Session.get 'description'
      isValid = _.isString(category)   \
          and category.length > 0      \
          and _.isString(description)  \
          and description.length > 0   \
          and Session.get('position')? \
          and Session.get('picture')?
      Session.set 'isValid', isValid

    unload: ->
      if Session.get 'isGeolocationSupported'
        disableGeolocator()
      unsetForAddItem()


  @route 'listItems',
    path: '/'
    template: 'listItems'

unsetForAddItem = ->
  unset 'category'
  unset 'description'
  unset 'isValid'
  unset 'picture'
  unset 'position'

unset = (key) ->
  Session.set key
