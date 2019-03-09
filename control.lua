require("util")

require("stdlib/log/logger")
require("stdlib/game")

require("prototypes.gui.gui_setup")
require("prototypes.gui.gui_events")

require("prototypes.campaigns.campaignManager")

global.runOnce = false

local debug = false
local debugset = false

function init_questor()

    campaignManager.initCampaign()

    gui_event_init()

end

function load_questor()

   campaignManager.initCampaign()

end

function OnPlayerCreated(event)
    local index = event.player_index
    local player = game.players[index]

    gui_init(player)
    campaignManager.initPlayer(index, player)
end

function OnTick(event)
    for k=1, #questor.ticks do
        local v = questor.ticks[k]
        v(event)
    end
end

function onGuiClick(event)
    for k=1, #questor.guiClick do
        local v = questor.guiClick[k]
        v(event)
    end
end

function bootstrap()
    if debug then
        if not debugset then
            debugset = true
            for i,player in pairs(game.players) do
                player.force.research_all_technologies()
                player.cheat_mode=true
            end
        end
    end

    script.on_event(defines.events.on_tick, OnTick)
    OnTick(event)

end

if not questor then questor = {} end

function init_events()

    if not questor.ticks then questor.ticks = {} end
    if not questor.guiClick then questor.guiClick = {} end

    script.on_init(init_questor)
    script.on_load(load_questor)

    script.on_event(defines.events.on_player_created, OnPlayerCreated)
    script.on_event(defines.events.on_gui_click, onGuiClick)

    -- this on tick handler will get replaced on the first tick after 'live' migrations have run
    script.on_event(defines.events.on_tick, bootstrap)
end

init_events()

