# Description:
#   Quote of The Day script
# 
# Commands:
#   quote, return quote of the day
#
# Notes:
#   This is currently broken

module.exports = (robot) ->

  robot.hear /(Quote|QOD)/i, (res) ->
    show_qod res, (err, _) ->
      res.send "You got your quote!"

  robot.on "quote", (quote) ->
    show_qod null, (err, _) ->
      if !err
        setTimeout(emit_quote_event, 10000)


  show_qod = (res, cb) ->
    res = res || robot
    robot.http("https://quotes.rest/qod")
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
            if !err
                data = JSON.parse body
                console.dir(data)
                if data.error
                  res.send "Bzzt! Brrrttt! Could NOT get qUote of THe DAy@! : #{data.error}"
                  cb(data.error, null)
                else
                  qod = data.contents.quotes[0].quote
                  res.send "Quote of the Day: \"#{qod}\""
                  cb(null, qod)
            else
                res.send "Bzzt! Brrrttt! Could NOT get qUote of THe DAy@! :-("
                cb(err, null)

  emit_quote_event = ()->
      robot.emit "quote", {
          user: {},
      }


  emit_quote_event()
