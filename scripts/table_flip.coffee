# Description:
#   Remind angry chatters that it'll be ok
#
# Author:
#   t.pickett66

module.exports = (robot) ->
  robot.hear /┻━┻/i, (msg) ->
    username = msg.message.user.name
    msg.send "┬─┬ノ( º _ ºノ) chill " + username
