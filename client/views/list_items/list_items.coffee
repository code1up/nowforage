Template.listItems.helpers
  items: ->
    Items.find()

  latitude: ->
    Session.get('position')?.coord.latitude
