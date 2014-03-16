class Camera
  constructor: (@_video) ->
    @_canvas = document.createElement 'canvas'
    @_ctx = @_canvas.getContext '2d'
    @_stream = null

  takePicture: ->
    @_canvas.width = @_video.videoWidth
    @_canvas.height = @_video.videoHeight
    @_ctx.drawImage @_video, 0, 0
    @_canvas.toDataURL 'image/jpeg'

  enable: ->
    return if @_stream?
    options = video: true
    success = (stream) =>
      @_stream = stream
      @_video.src = window.URL.createObjectURL stream
    error = (error) ->
      console.warn "ERROR(#{ error.code }): #{ error.message }"
    navigator.getUserMedia options, success, error
    return

  disable: ->
    return unless @_stream?
    @_stream.stop()
    return

@createCamera = (video) ->
  new Camera video

