
local add_styles = function(styles)
	local default_styles = data.raw["gui-style"].default
	for name, style in pairs(styles) do
		default_styles[name] = style
	end
end

add_styles(
	{
		questor_item_description =
		{
			type = "label_style",
			font = "default",
			font_color = {r=1, g=1, b=1},
			rich_text_setting = "enabled",
			single_line = false,
			maximal_width = 200,
			left_padding = 3,
			horizontal_align = "left"
		},
		questor_item_description_progressbar =
		{
			type = "progressbar_style",
			bar_width = 7,
		},

		questor_item_subheading =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=255, g=230, b=192},
			font = "default-semibold",
		},
		questor_item_description_uncomplete =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=1, g=1, b=1},
		},
		questor_item_description_progressing =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=255, g=204, b=0},
		},
		questor_item_description_complete =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=210, g=253, b=145},
		},
		questor_item_description_failed =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=250, g=90, b=90},
		},
		questor_item_description_info =
		{
			type = "label_style",
			parent = "questor_item_description",
			font_color = {r=128, g=206, b=240},
		},
		questor_vertical_flow =
		{
			type = "vertical_flow_style",
			vertical_spacing = 0,
		},
		questor_gui_frame =
		{
			type = "frame_style",
			parent = "frame",
			title_top_padding = 0,
			title_left_padding = 0,
			title_bottom_padding = 8,
			title_right_padding = 0,
			padding = 0,
			use_header_filler = false,
			horizontally_stretchable = "on",
			minimal_width = 200
		},
		questor_item_table =
		{
			type = "table_style",
			parent = "table",
			cell_padding = 0,
			top_padding = 0,
			left_padding = 4,
			right_padding = 4,
			bottom_padding = 4,
			vertical_spacing = 0,
			horizontally_stretchable = "on",
			odd_row_graphical_set =
			{
				base = {position = {43, 8}, size = {1, 1}},
			}
		},

		questor_gui_entry_wrapper_common =
		{
			type = "horizontal_flow_style",
			horizontal_spacing = 2,
			minimal_height = 26,
			vertical_align = 'top'
		},


		questor_hint_row =
		{
			type = "horizontal_flow_style",
			horizontal_spacing = 2,
			top_padding = 0,
			bottom_padding = 0,
			left_padding = 0,
			right_padding = 0,
			vertically_stretchable = "off",
			horizontally_stretchable = "on",
		},
		questor_hint_wrapper =
		{
			type = "horizontal_flow_style",
			parent = "questor_gui_entry_wrapper_common",
			minimal_width = 30,
			horizontal_align = "center"
		},
		questor_hint_icon_label =
		{
			type = "label_style",
			parent = "label",
			font = 'default'
		},
		questor_hint_description_wrapper =
		{
			type = "horizontal_flow_style",
			parent = 'questor_gui_entry_wrapper_common'
		},
		questor_hint_description =
		{
			type = "label_style",
			font = "default",
			font_color = { r = 128, g = 206, b = 240 },
			rich_text_setting = "enabled",
			single_line = false,
			left_padding = 3,
			horizontal_align = "left",
			maximal_width = 350
		},

		questor_item_description_wrapper =
		{
			type = "horizontal_flow_style",
			parent = 'questor_gui_entry_wrapper_common',
		},
		questor_item_count_wrapper =
		{
			type = "horizontal_flow_style",
			parent = 'questor_gui_entry_wrapper_common',
			left_padding = 4
		},
		questor_item_icons_wrapper =
		{
			type = "horizontal_flow_style",
			parent = 'questor_gui_entry_wrapper_common',
			horizontal_align = "left",
			left_padding = 4
		},
		questor_item_icons_label =
		{
			type = "label_style",
			parent = "label",
			font = 'default'
		},
		questor_item_state_icon_wrapper =
		{
			type = "horizontal_flow_style",
			parent = 'questor_gui_entry_wrapper_common',
			horizontal_align = 'center',
			left_padding = 4
		},
		questor_item_state_icon_label =
		{
			type = "label_style",
			parent = "label",
			font = 'default'
		},
	}
)

data:extend({

	-- export-data
	{
		type="sprite",
		name = "export-data",
		filename = "__Questor__/graphics/gui/commands/export.png",
		priority = "extra-high",
		width = 64,
		height = 64
	},
})
