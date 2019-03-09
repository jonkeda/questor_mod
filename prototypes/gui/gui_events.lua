require("exporter")

--testing GUI events
function on_gui_click(event)
    if not event.element.valid then return end

	local player = game.players[event.player_index]
    local event_name = event.element.name
    
	Game.print_all( string.format("on_gui_click %s %s", player.name, event_name ))

    if event_name == "export-data" then
        export_all()
    end

end

function on_gui_render(event)

    if game.tick % 20 ~= 0 then
        return
    end

    for i,p in pairs(game.players) do
        local questor = p.gui.left.questor
--        if global.selected_squad ~= nil then
--            if global.selected_squad[i] ~= nil then
--                roba.flow.squadId.caption = tostring(global.selected_squad[i])
--            end
--        end
    end

end

function gui_event_init()

    table.insert(questor.guiClick, on_gui_click)

end
