--[[

  A server which only runs zombie outbreak mode.

]]--

if not os.getenv("ZOMBIEVPS") then return end
engine.writelog("Applying the zombie configuration.")

local servertag = require"utils.servertag"
servertag.tag = "zombie"

require"std.uuid"

local fp, L = require"utils.fp", require"utils.lambda"
local map, I = fp.map, fp.I
local abuse, playermsg, commands = require"std.abuse", require"std.playermsg", require"std.commands"

cs.maxclients = 42
cs.serverport = 6666
cs.serverbotbalance = 0
spaghetti.later(10000, L'engine.requestmaster("\\n")', true)
spaghetti.addhook("masterin", L'if _.input:match("^failreg") then engine.lastupdatemaster = 0 end', true)

cs.serverauth = "pisto"
local auth = require"std.auth"
cs.adduser("pisto", "pisto", "+515027a91c3de5eecb8d0e0267f46d6bbb0b4bd87c4faae0", "a")
cs.adduser("Fear", "pisto", "+6c9ab9b9815cd392f83edb0f8c6c1dd35e4e262ff2190a7f", "m")
cs.adduser("Frosty", "pisto", "+bebaea64312c9c9365b0d54f8d013b546811b0da44284d33", "m")
cs.adduser("llama", "pisto", "+2d04377064720d72467ec71c165d185fc776bb5b437e71e4", "m")
cs.adduser("Dino_Martino", "pisto", "+8e786719673d030939d873ca0258913c69379581666d6cb7", "m")
cs.adduser("Buck", "pisto", "+5028b0663cf878a8b14d57f97ec06295b7a87676f881b6bc", "m")
cs.adduser("Pink", "pisto", "+48188ad779be16a77820ecba07f198b8d5898b9b9932b0a9", "m")
cs.adduser("Zaharia", "pisto", "-402f911db546976370f9f971477dd3d0563a6d6125b685bf", "m")
cs.adduser("S4US3SCHR1TT", "pisto", "-976346001fbbbba812d28d8214bede17e71bd35c8aec68e2", "m")
cs.adduser("quico", "pisto", "-d4c7af1291e4b22d1c93639861e074af43de814495e9d69c", "m")
cs.adduser("LordBug", "pisto", "-2ea3c4511769fabceee754e7a22b71b7e02b31a25227f2bf", "m")
cs.adduser("ne0n", "pisto", "+c799c10fc19b95d230bb91430f4dfd92234896c1bcfa29f6", "m")
cs.adduser("hades", "pisto", "+2651a29f0060d48c37534a2509698c798c21fafd454fd9b8", "m")
cs.adduser("firefly", "pisto", "-88a2394cbb748897bb28ba2b37c949b29019ad12320c55bb", "m")
cs.adduser("Charlotte", "pisto", "-4b7f5b00186b068aba0f85942a154ef7389fba048de88832", "m")
cs.adduser("Jay", "pisto", "-2468d805d2fce755fb92114caa537e8787573300e0c049bd", "m")
cs.adduser("Galaxy", "pisto", "+1e9244443a171573839c19bb96fb59d2532e9f17a2dd10e0", "m")
cs.adduser("px", "pisto", "+bbec32b37c334bf798c9e79cdf8426ef33f3bdf83778ab52", "m")
cs.adduser("a-monster", "pisto", "+15cb72e43e9ca29981636edf9e771b53c878a36a07244708", "m")
cs.adduser("deathstar", "pisto", "+d7900617ee9d447a74692ff114384f8d2f2b8e8582fc7af0", "m")
cs.adduser("swatllama", "pisto", "+e544f11d6424497013bacf99f01a3555d311954efbd111fe", "m")
cs.adduser("noobie", "pisto", "-a590c205846c50b07ecfba22d3bc3e7fe6ad6bef554c73da", "m")
cs.adduser("GustavoLapasta", "pisto", "-d9bf1ea15b96042ebada9c2dd14b928ea06642eaae318410", "m")
cs.adduser("waye", "pisto", "-5abdcd19e8db67cc36d0fc35d49c79d0086cb00c31f02f1a", "m")
cs.adduser("Squatch", "pisto", "+066875663ce6278b0f433ad6c7131b224682d705e715f4bb", "m")
cs.adduser("Bourbon", "pisto", "+0f2a6f3683b17be2d2c8ba60cc2513a5ef12ada6599dfca0", "m")
cs.adduser("MysteryCube", "pisto", "-7e263e59a19f54246afe95455e0c748088792557038a6171", "m")
cs.adduser("miseria", "pisto", "-aca0a8e9e959dddf277abe812e38a6f9d66f8c5499dd12dc", "m")
cs.adduser("Caveman", "pisto", "+89d59cb5022e7a2e52669675d1b2800038fd910958bc04f6", "m")
cs.adduser("N", "pisto", "+ffdcd26483e457165452890f7cf1bd2b82fac852b254d7e3", "m")
cs.adduser("SilverBigToe", "pisto", "-84174827fc67a05fcdf0739919a2cd2737b226b943d85195", "m")
table.insert(auth.preauths, "pisto")

cs.adduser("benzomatic", "spaghetti", "+a26e607b5554fd5b316a4bdd1bfc4734587aa82480fb081f", "a")
table.insert(auth.preauths, "spaghetti")

spaghetti.addhook(server.N_SETMASTER, L"_.skip = _.skip or (_.mn ~= _.ci.clientnum and _.ci.privilege < server.PRIV_ADMIN)")

cs.serverdesc = "\f7 ZOMBIE OUTBREAK!"

cs.lockmaprotation = 2
cs.maprotationreset()

local zombiemaps = map.f(I, ("aard3c aastha abbey abyss academy access akaritori akimiski akroseum albatross alithia alloy antel aod aqueducts arabic asgard asteroids asthma authentic autumn averas awoken bad_moon berlin_wall bklyn breakout bt_falls bvdm_01 c_egypt c_lone c_valley campo capture_night caribbean cartel casa castle_trap catch22 church51 clash collide collusion core_refuge core_transfer corruption croma ctf_suite curvedm curvy_castle cwcastle daemex damnation darkdeath deathtek depot desecration destiny dirtndust disruption divine dock donya douze duomo dust2 earthsea earthstation enigma eris eternal_valley europium evilness face-capture fallen fanatic_quake fb_capture fc3 fc4 fc5 fdm6 fire_keep flagstone force forge forgotten fortress frag-lab fragnostic fragplaza frostbyte frozen fubuki fury fusion garden genesis ghetto gorge gothic-df guacamole gubo hades hallo harbor haste hator haze hdm3 helligsted hidden hillfort hog2 idris idyll3 imhotep industry infamy infernal injustice island justice kalking1 kastro killcore3 killfactory kiryu kmap5 konkuri-to kopenhagen ksauer1 l_ctf laucin legacy legazzo lost_soul lost_world lostinspace luna mach2 maple masdm mbt1 mbt10 mbt12 mbt2 mbt4 mbt9 mc-lab meltdown2 memento memoria mercury metl2 metl3 metl4 metro mill monastery mood moonlite neondevastation neonpanic nessus nevil_c new_energy nitro nmp10 nmp4 nmp8 nmp9 nucleus oasis oddworld ognjen ogrosupply orbe orion osiris ot outpost ow pandora paradigm pariah park pgdm ph-capture phosgene pul1ctf ra recovery redemption refuge regal reissen relic renegade risk river_c river_keep rm1 rm5 roughinery ruby ruebli ruine rust sacrifice saffier sdm1 serenity shadowed shellshock2 shindou shinmei1 shipwreck shiva siberia skrdm1 skycastle-r snapper_rocks souls spcr spcr2 stadium stemple stronghold subterra suburb suisei surge tatooine tectonic tejen tempest thetowers thor tortuga triforts tubes turbulence turmoil twinforts urban_c valhalla venice ventania waltz warlock wdcd xenon zamak zdm2"):gmatch("[^ ]+"))
for i = 2, #zombiemaps do
  local j = math.random(i)
  local s = zombiemaps[j]
  zombiemaps[j] = zombiemaps[i]
  zombiemaps[i] = s
end

cs.maprotation("regencapture", table.concat(zombiemaps, " "))
cs.publicserver = 1
spaghetti.addhook(server.N_MAPVOTE, function(info)
  if info.skip or info.ci.privilege > 0 or info.text ~= server.smapname then return end
  info.skip = true
  playermsg("Cannot revote the current map.", info.ci)
end)

local ents, vars, iterators, sound = require"std.ents", require"std.vars", require"std.iterators", require"std.sound"
require"std.notalive"
spaghetti.addhook("entsloaded", function()
  if server.smapname == "core_refuge" then
    ents.newent(server.MAPMODEL, {x = 495, y = 910, z = 509}, 60, "tentus/fattree")
    ents.newent(server.MAPMODEL, {x = 400, y = 910, z = 511}, 60, "tentus/fattree")
  elseif server.smapname == "fb_capture" then
    ents.newent(server.MAPMODEL, {x = 986, y = 572.5, z = 182}, 266, "vegetation/tree03")
  elseif server.smapname == "ruby" then
    ents.newent(server.TELEPORT, {x = 2352.1875, y = 2176, z = 2096}, 42)
    ents.newent(server.TELEDEST, {x = 2140.25, y = 2138.625, z = 2571.6875}, 270, 42)
    ents.newent(server.TELEPORT, {x = 2140.25, y = 2138.625, z = 2591.6875}, -1)
  end
end)
local function drowncleanup(ci)
  local drown = ci.extra.drown
  if not drown then return end
  spaghetti.cancel(drown.timer)
  drown.timer = nil
  for _, hook in pairs(drown) do spaghetti.removehook(hook) end
  ci.extra.drown = nil
end
local nullhitpush = engine.vec()
nullhitpush.x, nullhitpush.y, nullhitpush.z = 0, 0, 0
local function drowndamage(ci)
  server.dodamage(ci, ci, 10, server.GUN_FIST, nullhitpush)
  return ci.state.state ~= engine.CS_DEAD and sound(ci, server.S_PAIN6)
end
local drownhook
spaghetti.addhook("changemap", function()
  if drownhook then
    for ci in iterators.all() do drowncleanup(ci) end
    spaghetti.removehook(drownhook)
    drownhook = nil
  end
  if server.smapname == "caribbean" or server.smapname == "tortuga" then
    vars.editvar("watercolour", 0x680A08)
    vars.editvar("waterfog", 5)
    drownhook = spaghetti.addhook("positionupdate", function(info)
      local cp = info.cp
      if cp.team == "evil" then return end
      local inwater = info.lastpos.pos.z < (server.smapname == "caribbean" and 1781 or 896)
      if inwater == not not cp.extra.drown then return end
      if not inwater then drowncleanup(cp) return end
      local function drowncleanuphook(info) if info.ci.clientnum == cp.clientnum then drowncleanup(info.ci) end end
      cp.extra.drown = {
        timer = spaghetti.latergame(5000, function()
          cp.extra.drown.timer = spaghetti.latergame(1000, function() (cp.team == "evil" and drowncleanup or drowndamage)(cp) end, true)
          playermsg("\f3YOU ARE DROWNING!", cp)
          drowndamage(cp)
      end),
        disconnect = spaghetti.addhook("clientdisconnect", drowncleanuphook),
        notalive = spaghetti.addhook("notalive", drowncleanuphook),
        botleave = spaghetti.addhook("botleave", drowncleanuphook)
      }
    end)
  end
end)

local hitpush, vec3 = require"std.hitpush", require"utils.vec3"
spaghetti.addhook("changemap", function() for ci in iterators.all() do ci.extra.lasthop = nil end end)
local function castlejumppad(ci, pos, z)
  if server.gamemillis - (ci.extra.lasthop or -2000) < 500 then return end
  local yaw = math.atan2(446 - pos.y, 446 - pos.x)
  hitpush(ci, { x = 150 * math.cos(yaw), y = 150 * math.sin(yaw), z = z })
  sound(ci, server.S_JUMPPAD)
  local jumpo = vec3(pos)
  jumpo.z = 512
  local i = ents.newent(server.MAPMODEL, jumpo, 0 , 13)
  if i then spaghetti.latergame(300, function() ents.delent(i) end) end
  ci.extra.lasthop = server.gamemillis
end
spaghetti.addhook("positionupdate", function(info)
  local ci = info.cp
  if server.smapname ~= "castle_trap" or ci.team == "evil" then return end
  local pos = info.lastpos.pos
  if math.abs(pos.z - 512.5 ) > 1 then ci.extra.lasthop = nil return end
  if info.lastpos.physstate % 8 ~= engine.PHYS_FLOOR then return end
  castlejumppad(ci, pos, 75)
end)
spaghetti.addhook(server.N_SOUND, function(info)
  local ci = info.cq
  if not ci or ci.state.state ~= engine.CS_ALIVE or server.smapname ~= "castle_trap" or ci.team == "evil" then return end
  local lastpos = ci.extra.lastpos
  if info.sound ~= server.S_JUMP or not lastpos or math.abs(lastpos.pos.z - 512.5 ) > 1 then return end
  if server.gamemillis - (ci.extra.lasthop or -2000) < 500 then hitpush(ci, { x = 0, y = 0, z = -125 })
  else castlejumppad(info.cq, lastpos.pos, -50) end
end)

--gamemods

local normalmaps = { speed = 30, serverdesc = "\f7 ZOMBIE OUTBREAK!", spawninterval = 10000/100*30, matearmour = 6, badhealth = 120, healthdrop = 50, banner = "\f3ZOMBIE OUTBREAK IN 20 SECONDS\f7! Take cover!\n\f5MATING SEASON \f0is open\f7! Choose a \f5mate\f7 and \f0chainsaw\f7 each other: you will \f0share health and kills\f7, and get \f2EXTRA ARMOUR\f7 when standing close." }
local orgymaps = { speed = 60, serverdesc = "\f7 ZOMBIE ORGY!", spawninterval = 10000/100*60, initialspawn = 10, badhealth = 90, healthdrop = 100, goodhealth = 1000, banner = "\f3ZOMBIE \f6ORGY\f3 IN 20 SECONDS\f7! \f3Zombies\f7, use \f1GRENADES\f7 to pull humans!" }
local fastmaps = { speed = 30, serverdesc = "\f7 FAST ZOMBIE OUTBREAK!", matearmour = 6, badhealth = 120, spawninterval = 5000/100*30, healthdrop = 50, banner = "\f6FAST \f3ZOMBIE OUTBREAK IN 20 SECONDS\f7! Take cover!\n\f5MATING SEASON \f0is open\f7! Choose a \f5mate\f7 and \f0chainsaw\f7 each other: you will \f0share health and kills\f7, and get \f2EXTRA ARMOUR\f7 when standing close." }
local spmaps = { speed = 40, serverdesc = "\f7 ZOMBIE SWARM!", spawninterval = 7000/100*40, initialspawn = 4, healthdrop = 250, goodhealth = 500, banner = "\f3ZOMBIE \f6SWARM\f3 IN 20 SECONDS\f7! Health/healt boost give \f0250\f7/\f0500 hp\f7!\n\f3--> \f5GET THE HELL OUT OF THE SPAWNPOINT\f7!!" }
local overridemaps = map.mv(function(map) return map, orgymaps end, "complex", "douze", "ot", "justice", "turbine", "frozen", "curvy_castle", "tartech", "aard3c", "dune", "sdm1", "metl4", "simplicity")
map.tmv(overridemaps, function(map) return map, fastmaps end, "xenon", "asgard", "donya", "kopenhagen")
map.tmv(overridemaps, function(map) return map, spmaps end, "canyon", "firstevermap", "secondevermap", "mpsp10", "mpsp6a", "mpsp6b", "mpsp6c", "mpsp9a", "mpsp9b", "mpsp9c", "k_rpg1", "level9", "lost", "rpg_01")
local zombieconfig = setmetatable({burnhealth = true}, {__index = function(_, field) return (overridemaps[server.smapname] or normalmaps)[field] end})
function zombieconfig.ammo(ci)
  local st = ci.state
  for i = 0, server.NUMGUNS - 1 do st.ammo[i] = 0 end
  st.ammo[server.GUN_FIST], st.armourtype, st.armour = 1, server.A_BLUE, 0
  local goodhealth, badhealth = zombieconfig.goodhealth or 200, zombieconfig.badhealth or 90
  if ci.team == "good" then st.ammo[server.GUN_CG], st.gunselect, st.health, st.maxhealth = 9999, server.GUN_CG, goodhealth, goodhealth
  else
    st.ammo[server.GUN_GL], st.health, st.maxhealth = 9999, badhealth, 0
    if overridemaps[server.smapname] == orgymaps then
      st.ammo[server.GUN_GL], st.gunselect = st.aitype ~= server.AI_BOT and 3 or 0, server.GUN_FIST
    elseif overridemaps[server.smapname] ~= spmaps and overridemaps[server.smapname] ~= orgymaps then
      st.ammo[server.GUN_RL], st.gunselect = (st.aitype == server.AI_BOT and math.random() < 3/4) and 9999 or 4, st.aitype == server.AI_BOT and server.GUN_FIST or server.GUN_RL
    else st.gunselect = server.GUN_GL end
  end
end
require"gamemods.zombieoutbreak".on(zombieconfig, true)

spaghetti.addhook("changemap", function()
  require"std.serverdesc"(zombieconfig.serverdesc)
  if overridemaps[server.smapname] ~= spmaps then return end
  server.aiman.addai(0, -1)
  for i, sent, ment in ents.enum() do
    if ment.type == server.RESPAWNPOINT or (ment.type == server.MAPMODEL and ment.attr3 ~= 0) then
      ents.delent(i)
    elseif ment.type == server.ELEVATOR then
      ents.editent(i, server.MAPMODEL, ment.o, ment.attr1, "dcp/jumppad2")
      ents.newent(server.JUMPPAD, ment.o, 50)
    elseif sent.spawned then ents.setspawn(i, true, true) end
  end
  spaghetti.latergame(23000, L"_ = server.getinfo(128) return _ and server.sendspawn(_)")
end)
spaghetti.addhook(server.N_TRYSPAWN, L"_.skip = _.skip or server.gamemillis < 23000 and _.cq and _.cq.clientnum == 128")
spaghetti.addhook("dodamage", function(info)
  if overridemaps[server.smapname] ~= orgymaps then return end
  if info.actor.team == "evil" and info.target.team ~= "evil" and info.gun == server.GUN_GL then
    info.skip = true
    info.damage = info.damage * -1.5
  elseif info.gun == server.GUN_CG then
    local hp = info.hitpush
    local dir = vec3(hp)
    hp.x, hp.y, hp.z = 0, 0, 0
    hitpush(info.target, dir:mul(-70))
  end
end, true)
spaghetti.addhook(server.N_SOUND, function(info)
  if overridemaps[server.smapname] ~= orgymaps or not info.cq or info.cq.team ~= "evil" or info.cq.state.state ~= engine.CS_ALIVE then return end
  hitpush(info.cq, {x = 0, y = 0, z = 50})
end)
spaghetti.addhook("canspawnitem", function(info)
  if overridemaps[server.smapname] ~= spmaps then return end
  info.can = info.type >= server.I_SHELLS and info.type <= server.I_QUAD
end)
spaghetti.addhook("prepickup", function(info)
  local i, sent = ents.getent(info.i)
  if info.skip or not sent or not sent.spawned or sent.type ~= server.I_BOOST then return end
  info.skip = true
  ents.setspawn(i, false)
  if info.ci.team == "evil" then
    if info.ci.state.health ~= 1000 then server.sendservmsg("\f3" .. server.colorname(info.ci, nil) .. " \f7is now a \f3ZOMBIE LORD\f7 with \f31000\f7 hp!") end
    info.ci.state.health = 1000
  else info.ci.state.health = 500 end
  sent.spawntime = server.spawntime(server.I_BOOST);
  server.sendresume(info.ci)
  sound(info.ci, server.S_ITEMHEALTH)
end)
local itemspawnpoints = {}
spaghetti.addhook("pickup", function(info)
  if server.smapname ~= "mpsp10" or itemspawnpoints[info.i] then return end
  local _, _, ment = ents.getent(info.i)
  if ment.type < server.I_SHELLS or ment.type > server.I_HEALTH then return end
  ents.newent(server.PLAYERSTART, ment.o, math.random(360))
  itemspawnpoints[info.i] = true
end)
spaghetti.addhook("changemap", function() itemspawnpoints = {} end)

require"gamemods.antispawnkill".on(server.guns[server.GUN_FIST].range * 3, true)

require"std.pm"
require"std.getip"
require"std.specban"

--[[

require"std.discordrelay".new({
  relayHost = "127.0.0.1", 
  relayPort = 57575, 
  discordChannelID = "my-discord-channel-id",
  scoreboardChannelID = "my-scoreboard-channel-id",
  voice = {
    good = "good-voice-channel",
    evil = "evil-voice-channel"
  }
})

]]

spaghetti.addhook("entsloaded", function()
  if server.smapname ~= "thetowers" then return end
  for i, _, ment in ents.enum(server.JUMPPAD) do if ment.attr4 == 40 then
    ents.editent(i, server.JUMPPAD, ment.o, ment.attr1, ment.attr2, ment.attr3)
    break
  end end
end)

--moderation

--limit reconnects when banned, or to avoid spawn wait time
abuse.reconnectspam(1/60, 5)

--limit some message types
spaghetti.addhook(server.N_KICK, function(info)
  if info.skip or info.ci.privilege > server.PRIV_MASTER then return end
  info.skip = true
  playermsg("No. Use gauth.", info.ci)
end)
spaghetti.addhook(server.N_SOUND, function(info)
  if info.skip or abuse.clientsound(info.sound) then return end
  info.skip = true
  playermsg("I know I used to do that but... whatever.", info.ci)
end)
abuse.ratelimit({ server.N_TEXT, server.N_SAYTEAM }, 0.5, 10, L"nil, 'I don\\'t like spam.'")
abuse.ratelimit(server.N_SWITCHNAME, 1/30, 4, L"nil, 'You\\'re a pain.'")
abuse.ratelimit(server.N_MAPVOTE, 1/10, 3, L"nil, 'That map sucks anyway.'")
abuse.ratelimit(server.N_SPECTATOR, 1/30, 5, L"_.ci.clientnum ~= _.spectator, 'Can\\'t even describe you.'") --self spec
abuse.ratelimit(server.N_MASTERMODE, 1/30, 5, L"_.ci.privilege == server.PRIV_NONE, 'Can\\'t even describe you.'")
abuse.ratelimit({ server.N_AUTHTRY, server.N_AUTHKICK }, 1/60, 4, L"nil, 'Are you really trying to bruteforce a 192 bits number? Kudos to you!'")
abuse.ratelimit(server.N_SERVCMD, 0.5, 10, L"nil, 'Yes I\\'m filtering this too.'")
abuse.ratelimit(server.N_JUMPPAD, 1, 10, L"nil, 'I know I used to do that but... whatever.'")
abuse.ratelimit(server.N_TELEPORT, 1, 10, L"nil, 'I know I used to do that but... whatever.'")

--prevent masters from annoying players
local tb = require"utils.tokenbucket"
local function bullying(who, victim)
  local t = who.extra.bullying or {}
  local rate = t[victim.extra.uuid] or tb(1/30, 6)
  t[victim.extra.uuid] = rate
  who.extra.bullying = t
  return not rate()
end
spaghetti.addhook(server.N_SETTEAM, function(info)
  if info.skip or info.who == info.sender or not info.wi or info.ci.privilege == server.PRIV_NONE then return end
  local team = engine.filtertext(info.text):sub(1, engine.MAXTEAMLEN)
  if #team == 0 or team == info.wi.team then return end
  if bullying(info.ci, info.wi) then
    info.skip = true
    playermsg("...", info.ci)
  end
end)
spaghetti.addhook(server.N_SPECTATOR, function(info)
  if info.skip or info.spectator == info.sender or not info.spinfo or info.ci.privilege == server.PRIV_NONE or info.val == (info.spinfo.state.state == engine.CS_SPECTATOR and 1 or 0) then return end
  if bullying(info.ci, info.spinfo) then
    info.skip = true
    playermsg("...", info.ci)
  end
end)

--ratelimit just gobbles the packet. Use the selector to add a tag to the exceeding message, and append another hook to send the message
local function warnspam(packet)
  if not packet.ratelimited or type(packet.ratelimited) ~= "string" then return end
  playermsg(packet.ratelimited, packet.ci)
end
map.nv(function(type) spaghetti.addhook(type, warnspam) end,
  server.N_TEXT, server.N_SAYTEAM, server.N_SWITCHNAME, server.N_MAPVOTE, server.N_SPECTATOR, server.N_MASTERMODE, server.N_AUTHTRY, server.N_AUTHKICK, server.N_CLIENTPING
)

spaghetti.addhook(server.N_TEXT, function(info)
  if info.skip then return end
  local low = info.text:lower()
  if not low:match"cheat" and not low:match"hack" and not low:match"auth" and not low:match"kick" then return end
  local tellcheatcmd = info.ci.extra.tellcheatcmd or tb(1/30000, 1)
  info.ci.extra.tellcheatcmd = tellcheatcmd
  if not tellcheatcmd() then return end
  playermsg("\f2Problems with a cheater? Please use \f3#cheater [cn|name]\f2, and operators will look into the situation!\nYou can report zombies too, the controlling client will be reported.", info.ci)
  sound(info.ci, server.S_HIT, true) sound(info.ci, server.S_HIT, true)
end)

require"std.enetping"

local parsepacket = require"std.parsepacket"
spaghetti.addhook("martian", function(info)
  if info.skip or info.type ~= server.N_TEXT or info.ci.connected or parsepacket(info) then return end
  local text = engine.filtertext(info.text, true, true)
  engine.writelog(("limbotext: (%d) %s"):format(info.ci.clientnum, text))
  info.skip = true
end, true)

--simple banner

local git = io.popen("echo `git rev-parse --short HEAD` `git show -s --format=%ci`")
local gitversion = git:read()
git = nil, git:close()
commands.add("info", function(info)
  playermsg("spaghettimod is a reboot of hopmod for programmers. Will be used for SDoS.\nKindly brought to you by pisto." .. (gitversion and "\nCommit " .. gitversion or ""), info.ci)
end)

--lazy fix all bugs.

spaghetti.addhook("noclients", function()
  if engine.totalmillis >= 24 * 60 * 60 * 1000 then reboot, spaghetti.quit = true, true end
end)
