--[[

  Improve logging to stdout: add timestamp, track connects/renames/disconnects better, map changes.

]]--

local L = require"utils.lambda"

spaghetti.addhook("log", function(info) info.s = os.date("%c | ") .. info.s end)

spaghetti.addhook("log", function(info)
  if info.s:match"^client connected" or info.s:match"^client [^ ]+ disconnected" or info.s:match"^disconnected client" then info.skip = true return end
end, true)

local ip = require"utils.ip"
local function conninfo(client)
  local name, cn = "", client
  if type(client) ~= 'number' then name, cn = client.name, client.clientnum end
  local peer = engine.getclientpeer(cn)
  return string.format('%s (%d) %s:%d:%d', name, cn, tostring(ip.ip(engine.ENET_NET_TO_HOST_32(peer.address.host))), peer.address.port, peer.incomingPeerID)
end
spaghetti.addhook("connected", function(info)
  engine.writelog("join: " .. conninfo(info.ci))
end)
spaghetti.addhook(server.N_SWITCHNAME, function(info)
  if info.skip then return end
  engine.writelog(string.format('rename: %s -> %s(%d)', conninfo(info.ci), engine.filtertext(info.text):sub(1, server.MAXNAMELEN):gsub("^$", "unnamed"), info.ci.clientnum))
end)
spaghetti.addhook("master", function(info)
  if info.authname then engine.writelog(string.format('master%s: %s %s %s [%s]', (info.kick and " (authkick)" or ""), conninfo(info.ci), server.privname(info.privilege), info.authname, info.authdesc or ""))
  else engine.writelog(string.format('master: %s %s', conninfo(info.ci), (info.privilege > server.PRIV_NONE or info.authname) and server.privname(info.privilege) or "relinquished")) end
end)
spaghetti.addhook("kick", function(info)
  if not info.actor then return end
  engine.writelog(string.format('kick: %s => %s', conninfo(info.actor), conninfo(info.c)))
end)
spaghetti.addhook("clientdisconnect", function(info)
  engine.writelog(string.format("leave: %s %s", conninfo(info.ci), engine.disconnectreason(info.reason) or "none"))
end)
spaghetti.addhook("enetdisconnect", function(info)
  if info.skip then return end
  local peer = info.event.peer
  local timeout = peer.timedOut == 1
  if info.ci then engine.writelog((timeout and "timeout: " or "disconnect: ") .. conninfo(info.ci))
  else
    engine.writelog(string.format((timeout and "timeout: %s:%d:%d" or "disconnect: %s:%d:%d"), tostring(ip.ip(engine.ENET_NET_TO_HOST_32(peer.address.host))), peer.address.port, peer.incomingPeerID))
  end
  if timeout and info.ci then server.sendservmsg("\f4timeout:\f7 " .. server.colorname(info.ci, nil)) end
end)

spaghetti.addhook("changemap", L"engine.writelog(string.format('new %s on %s', server.modename(_.mode, '?'), _.map))")

spaghetti.addhook("mastermode", function(info)
  engine.writelog(string.format('mastermode: %s %s', conninfo(info.ci), server.mastermodename(server.mastermode, nil)))
end)

spaghetti.addhook("masterconnected", L'engine.writelog("master server connected")')
spaghetti.addhook("masterdisconnected", L'engine.writelog("master server disconnected")')
