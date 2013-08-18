class Utils
  random_string: () ->
    charSet = 'abcdefghijklmnopqrstuvwxyz'
    randomString = ''
    i = 30
    while i > 0
        randomPoz = Math.floor(Math.random() * charSet.length)
        randomString += charSet.substring(randomPoz,randomPoz+1)
        i = i-1
    randomString
window.nut = new Utils
