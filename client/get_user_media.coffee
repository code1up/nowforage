unless navigator.getUserMedia?
  navigator.getUserMedia =          \
    navigator.msGetUserMedia        \
    or navigator.mozGetUserMedia    \
    or navigator.webkitGetUserMedia

