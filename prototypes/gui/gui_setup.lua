require("mod-gui")
local util = require('util')

function updateQuestGui(parent, text, max, code)

	local key = 'desc_flow'..code

	if parent[key] == nil then
		local flow = parent.add
			{
				type = 'flow',
				direction='vertical',
				name = key,
				--style= 'quest_item_description_wrapper'
				--column_count = 1
			}
		flow.add
			{
				type = 'label',
				style = 'questor_item_description',
				caption = text,
				name = "inner"
			}
		flow.add
			{
				type = 'progressbar',
				style = "questor_item_description_progressbar",
				name = "pbValue",
				--caption = text,
				value =  0,
			}
	end
end

function gui_init(player)

	local root = nil
	if player.gui.left.questor then
		root = player.gui.left.questor
		player.gui.left.questor.clear()
	else
		root = player.gui.left.add{
			type = "frame",
			name = "questor",
			direction = "vertical", --horizontal
			column_count = 1
		}
		root.style.top_padding = 4
		root.style.bottom_padding = 4
		--root.style.minimal_width = 230
	end

	local flow = root.add{
		type = "table",
		name = "flow",
		column_count = 16
	}

	-- squad id

	flow.add{
		type = "sprite-button",
		name = "export-data",
		tooltip = {"property.export-data"},
		sprite = "export-data",
		style = mod_gui.button_style
	}

	local quest_gui_frame = root.add
		{
			type = 'frame',
			name = 'frmQuest',
			direction = 'vertical',
			style='questor_gui_frame',
			caption = {"property.quests"},
		}
	local questTable = quest_gui_frame.add{
		type = "table",
		name = "tblQuests",
		column_count = 1
	}

--	addQuest(questTable, "Create 10 iron-plates", 10, "a")
--
--	addQuest(questTable, "Create 2 assembly machines", 2, "b")

end
