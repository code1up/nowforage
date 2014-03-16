Meteor.startup ->
  Session.set 'isGeolocationSupported', navigator.geolocation?

class Geolocator
  @instance: null

  constructor: ->
    @_successCallback = _.bind @_success, this
    @_errorCallback = _.bind @_error, this
    @_options =
      enableHighAccuracy: true
      timeout: 5000
      maximumAge: 0

  _success: (position) ->
    Session.set 'position', position
    return

  _error: (error) ->
    console.warn "ERROR(#{ error.code }): #{ error.message }"
    return

  enable: ->
    return if @_id?
    @_id = navigator.geolocation.watchPosition(
      @_successCallback,
      @_errorCallback,
      @_options
    )
    return

  disable: ->
    return unless @_id?
    navigator.geolocation.clearWatch @_id
    delete @_id
    return

  @getInstance: ->
    unless Geolocator.instance?
      Geolocator.instance = new Geolocator
    Geolocator.instance

@enableGeolocator = ->
  Geolocator.getInstance().enable()

@disableGeolocator = ->
  Geolocator.getInstance().disable()

