local module = {}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

function tab_index(tab_info)
	local index = tab_info.tab_index
	return (index + 1)
end

function module.apply_format_title(wezterm)
	local theme_color = require("mocha_theme")
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		local index = tab_index(tab)
		local index_background = theme_color.thm_blue
		local index_foreground = theme_color.thm_black
		if tab.is_active then
			index_background = theme_color.thm_orange
		end
		title = title.sub(title, 1, 11)
		return {
			{ Background = { Color = theme_color.thm_gray } },
			{ Foreground = { Color = theme_color.thm_fg } },
			{ Text = " " .. title .. " " },
			{ Background = { Color = index_background } },
			{ Foreground = { Color = index_foreground } },
			{ Text = " " .. tostring(index) .. " " },
		}
	end)
end

function module.apply_right_status(wezterm)
	local theme_color = require("mocha_theme")
	wezterm.on("update-right-status", function(window, pane)
		-- Each element holds the text for a cell in a "powerline" style << fade
		local cells = {}

		-- Figure out the cwd and host of the current pane.
		-- This will pick up the hostname for the remote host if your
		-- shell is using OSC 7 on the remote host.
		local cwd_uri = pane:get_current_working_dir()
		if cwd_uri then
			local cwd = ""
			local hostname = ""

			if type(cwd_uri) == "userdata" then
				-- Running on a newer version of wezterm and we have
				-- a URL object here, making this simple!

				cwd = cwd_uri.file_path
				hostname = cwd_uri.host or wezterm.hostname()
			else
				-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
				-- which doesn't have the Url object
				cwd_uri = cwd_uri:sub(8)
				local slash = cwd_uri:find("/")
				if slash then
					hostname = cwd_uri:sub(1, slash - 1)
					-- and extract the cwd from the uri, decoding %-encoding
					cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
						return string.char(tonumber(hex, 16))
					end)
				end
			end

			-- Remove the domain name portion of the hostname
			local dot = hostname:find("[.]")
			if dot then
				hostname = hostname:sub(1, dot - 1)
			end
			if hostname == "" then
				hostname = wezterm.hostname()
			end

			-- table.insert(cells, cwd)
			table.insert(cells, hostname)
		end

		-- date/time format: "01:07 Thu Jul 4"
		local date = wezterm.strftime("%H:%M %a %b %-d")
		table.insert(cells, date)

		-- An entry for each battery (typically 0 or 1 battery)
		for _, b in ipairs(wezterm.battery_info()) do
			table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
		end

		-- The elements to be formatted
		local elements = {}
		-- Date
		table.insert(elements, { Foreground = { Color = theme_color.thm_blue } })
		-- table.insert(elements, { Background = { Color = theme_color.thm_green } })
		table.insert(elements, { Text = wezterm.nerdfonts.ple_left_half_circle_thick })
		table.insert(elements, { Foreground = { Color = "#000000" } })
		table.insert(elements, { Background = { Color = theme_color.thm_blue } })
		table.insert(elements, { Text = " " .. wezterm.nerdfonts.fa_calendar .. " " .. date .. " " })

		window:set_right_status(wezterm.format(elements))
	end)
end
return module
