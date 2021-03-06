--[[

  Private messages. Shown as team messages with a header.

]]--

local commands, playermsg, putf, chatisolate = require"std.commands", require"std.playermsg", require"std.putf", require"std.chatisolate"

commands.add("pm", function(info)
  if info.skip then return end
  local sendercn, cn, msg = info.ci.clientnum, engine.filtertext(info.args, true, true):match("(%d+) +(.+)")
  cn = tonumber(cn)
  if not cn or msg == "" then playermsg("Invalid format.", info.ci) return end
  if cn == sendercn then return end
  local who = engine.getclientinfo(cn)
  if not who then playermsg("Cannot find cn " .. cn, info.ci) return end
  if not chatisolate.cantalkto(info.ci, who) then playermsg("You can't pm " .. server.colorname(who, nil) .. " now", info.ci) return end
  local hdr = "[PM, reply #pm " .. sendercn .. "]:"
  engine.sendpacket(who.clientnum, 1, putf({ 6 + #hdr + #msg, r = 1}, server.N_SAYTEAM, sendercn, hdr, server.N_SAYTEAM, sendercn, msg):finalize(), -1)
  engine.writelog(("pm: %s (%d) => %s (%d): "):format(info.ci.name, sendercn, who.name, who.clientnum) .. msg)
end, "#pm <cn> <text>: send text to client as a private message")
