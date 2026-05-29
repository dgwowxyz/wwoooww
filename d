--@ generated using Luauify
--@ generation settions:
--@ > ADD_COMMENTS = false
--@ > FUNCTION_NAME = create
--@ > USE_COMPRESSION = false
--@ > ABBREVIATE_PROPERTIES = true

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local httpService = game:GetService("HttpService")
local coreGui = game:GetService("CoreGui")
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera

local function create(class: string, properties: {}?): Instance | boolean
	local success, instance = pcall(Instance.new, class)
	if not success then return false end
	if properties then
		for key, value in next, properties do
			local succ, err = pcall(function()
				(instance :: any)[key] = value
			end)
			if not succ then warn(err) return false end
		end
	end
	return instance
end

local CSK = ColorSequenceKeypoint.new
local NSK = NumberSequenceKeypoint.new
local BSP = Enum.BorderStrokePosition
local ASM = Enum.ApplyStrokeMode
local UFA = Enum.UIFlexAlignment
local TXA = Enum.TextXAlignment
local TYA = Enum.TextYAlignment
local UIT = Enum.UserInputType
local ETT = Enum.TextTruncate
local UFO = UDim2.fromOffset
local UFS = UDim2.fromScale
local EGS = Enum.GuiState
local EKC = Enum.KeyCode
local TCC = table.concat
local TIS = table.insert
local TR = table.remove
local TU = table.unpack
local TC = table.clone
local TF = table.find
local MC = math.clamp
local MR = math.round
local MF = math.floor
local MM = math.min
local MH = math.huge
local ED = Enum.EasingDirection
local AS = Enum.AutomaticSize
local FD = Enum.FillDirection
local ES = Enum.EasingStyle
local FW = Enum.FontWeight
local SO = Enum.SortOrder
local FS = Enum.FontStyle
local EF = Enum.Font
local TI = TweenInfo.new
local SF = string.format
local V2 = Vector2.new
local UD2 = UDim2.new
local UD = UDim.new
local FN = Font.new
local RGB = Color3.fromRGB
local HSV = Color3.fromHSV
local CS = ColorSequence.new
local NS = NumberSequence.new
local GR = math.round
local GV = Vector2.new

local Library; do
	Library = {
		Directory = "MyUI",
		Flags = {},
		ConfigFlags = {},
		FlagCount = 0,
		Connections = {},
		Threads = {},
		Elements = {},
		Notifications = {},
		OpenElement = {},
		Keybinds = {},
		Guis = {},
		Tweening = false,
		TweenSpeed = 0.25,
		EasingStyle = ES.Cubic,
		EasingDirection = ED.Out,
		Accent = RGB(255, 174, 82),
		Background = RGB(38, 35, 35),
		BackgroundSecondary = RGB(30, 28, 28),
		BackgroundTertiary = RGB(54, 50, 50),
		TextMain = RGB(255, 255, 255),
		TextMuted = RGB(145, 145, 145),
		Outline = RGB(54, 50, 50),
	}
	Library.__index = Library

local createSection, createColumn, createPage

local Themes = {
	Accent = RGB(255, 174, 82),
	Background = RGB(38, 35, 35),
	BackgroundSecondary = RGB(30, 28, 28),
	BackgroundTertiary = RGB(54, 50, 50),
	TextMain = RGB(255, 255, 255),
	TextMuted = RGB(145, 145, 145),
	Outline = RGB(54, 50, 50),
}

local Dragging = false

local CustomFont, FontLoaded = nil, false

do
	local fontDir = Library.Directory .. "/fonts"
	local success, err = pcall(function()
		local fontFile = fontDir .. "/main.ttf"
		local encodedFile = fontDir .. "/main_encoded.ttf"
		makefolder(fontDir)
		if isfile(fontFile) then delfile(fontFile) end
		writefile(fontFile, game:HttpGet("https://github.com/f1nobe7650/Nebula/raw/refs/heads/main/Minecraftia-Regular.ttf"))
		local minecraftia = {
			name = "Minecraftia",
			faces = {{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset(fontFile)
			}}
		}
		if not isfile(encodedFile) then
			writefile(encodedFile, httpService:JSONEncode(minecraftia))
		end
		CustomFont = FN(getcustomasset(encodedFile), FW.Regular, FS.Normal)
		FontLoaded = true
	end)
	if not success then
		FontLoaded = false
	end
end

local function getFont()
	if FontLoaded and CustomFont then
		return CustomFont
	end
	return FN("rbxasset://fonts/families/PressStart2P.json", FW.Regular, FS.Normal)
end

local function tweenObject(obj, properties, info)
	info = info or TI(Library.TweenSpeed, Library.EasingStyle, Library.EasingDirection)
	local tw = tweenService:Create(obj, info, properties)
	tw:Play()
	return tw
end

function Library:Tween(properties, info, obj)
	local instance = (self.Instance or self) :: Instance
	if obj then instance = obj end
	return tweenObject(instance, properties, info)
end

function Library:Connect(signal, callback)
	local connInfo = {Event = signal, Callback = callback, Connection = nil}
	connInfo.Connection = signal:Connect(callback)
	TIS(self.Connections, connInfo)
	return connInfo
end

function Library:Thread(func)
	local thread = coroutine.create(func)
	coroutine.wrap(function() coroutine.resume(thread) end)()
	TIS(self.Threads, thread)
	return thread
end

function Library:Hovering()
	local inst = self.Instance
	if not inst then return false end
	local pos = inst.AbsolutePosition
	local size = inst.AbsoluteSize
	return mouse.Y >= pos.Y and mouse.Y <= pos.Y + size.Y and mouse.X >= pos.X and mouse.X <= pos.X + size.X
end

function Library:OnClick(callback)
	return self:Connect(self.Instance.InputBegan, function(input)
		if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
			callback()
		end
	end)
end

function Library:OnHover(enterCb, leaveCb)
	leaveCb = leaveCb or function() end
	self:Connect(self.Instance.MouseEnter, enterCb)
	self:Connect(self.Instance.MouseLeave, leaveCb)
	return self
end

function Library:CreateWindow(data)
	data = data or {}
	local Cfg = {
		Title = data.Title or "Menu Title",
		Size = data.Size or UFO(527, 333),
		Position = data.Position or UFS(0.2852, 0.2891),
		Items = {},
		Open = true,
		Tabs = {},
		TabCount = 0,
		ActiveTab = nil,
	}
	Cfg.__index = Cfg

	local Items = Cfg.Items

	local ScreenGui = create("ScreenGui", {
		Parent = coreGui,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
		DisplayOrder = 100,
	}) :: ScreenGui
	TIS(Library.Guis, ScreenGui)
	Items.ScreenGui = ScreenGui

	local main_ui = create("Frame", {
		Parent = ScreenGui,
		Name = "main_ui",
		Position = Cfg.Position,
		BorderColor3 = RGB(0, 0, 0),
		Size = Cfg.Size,
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(38, 35, 35),
	}) :: Frame
	Items.Main = main_ui

	create("UIStroke", {
		Parent = main_ui,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local window_title = create("Frame", {
		Parent = main_ui,
		BackgroundTransparency = 1,
		Name = "window_title",
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(527, 29),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame
	Items.TitleBar = window_title

	local title_label = create("TextLabel", {
		Parent = window_title,
		TextWrapped = true,
		TextColor3 = RGB(255, 255, 255),
		BorderColor3 = RGB(0, 0, 0),
		Text = Cfg.Title,
		TextStrokeTransparency = 0,
		BackgroundTransparency = 1,
		Size = UFO(527, 25),
		BorderSizePixel = 0,
		FontFace = getFont(),
		TextSize = 10,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: TextLabel
	Items.TitleLabel = title_label

	create("UIStroke", {
		Parent = title_label,
		LineJoinMode = Enum.LineJoinMode.Miter,
		Transparency = 1,
	})

	local background_another = create("Frame", {
		Parent = main_ui,
		Name = "background_another",
		Position = UFS(0.0128, 0.0841),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(514, 299),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(30, 28, 28),
	}) :: Frame
	Items.BackgroundAnother = background_another

	create("UIStroke", {
		Parent = background_another,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local content = create("Frame", {
		Parent = background_another,
		Name = "content",
		Position = UFS(0.0128, 0.1175),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(501, 257),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(38, 35, 35),
	}) :: Frame
	Items.Content = content

	create("UIStroke", {
		Parent = content,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local tabs_bg = create("Frame", {
		Parent = background_another,
		Name = "tabs_background",
		Position = UFS(0.0117, 0.0201),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(501, 20),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame
	Items.TabsBackground = tabs_bg

	create("UIStroke", {
		Parent = tabs_bg,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local tabs_list = create("UIListLayout", {
		Parent = tabs_bg,
		FillDirection = FD.Horizontal,
		VerticalFlex = UFA.Fill,
		HorizontalFlex = UFA.Fill,
	})
	Items.TabsListLayout = tabs_list

	local dragStart, dragPos

	window_title.InputBegan:Connect(function(input)
		if not Dragging and (input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch) then
			Dragging = true
			dragStart = input.Position
			dragPos = main_ui.Position
		end
	end)

	window_title.InputEnded:Connect(function(input)
		if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
			Dragging = false
		end
	end)

	Library:Connect(userInputService.InputChanged, function(input)
		if Dragging and (input.UserInputType == UIT.MouseMovement or input.UserInputType == UIT.Touch) then
			local newPos = UD2(0, dragPos.X.Offset + (input.Position.X - dragStart.X), 0, dragPos.Y.Offset + (input.Position.Y - dragStart.Y))
			tweenObject(main_ui, {Position = newPos})
		end
	end)

	function Cfg:AddTab(data)
		data = data or {}
		self.TabCount += 1
		local tabCfg = {
			Text = data.Text or "Tab " .. self.TabCount,
			Items = {},
			Window = self,
			Active = false,
		}
		tabCfg.__index = tabCfg

		local tabItems = tabCfg.Items

		local tab_frame = create("Frame", {
			Parent = tabs_bg,
			Name = "tab_" .. self.TabCount,
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(100, 100),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(30, 28, 28),
		}) :: Frame
		tabItems.TabFrame = tab_frame

		local tab_text = create("TextLabel", {
			Parent = tab_frame,
			TextWrapped = true,
			TextColor3 = RGB(145, 145, 145),
			BorderColor3 = RGB(0, 0, 0),
			Text = tabCfg.Text,
			TextStrokeTransparency = 0,
			Name = "tab_text",
			BackgroundTransparency = 1,
			Size = UFO(167, 23),
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		tabItems.TabText = tab_text

		local tab_page = create("Frame", {
			Parent = ScreenGui,
			Name = "tab_page_" .. self.TabCount,
			Visible = false,
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(501, 257),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(38, 35, 35),
		}) :: Frame
		tabItems.TabPage = tab_page

		local page_layout = create("UIListLayout", {
			Parent = tab_page,
			FillDirection = FD.Horizontal,
			HorizontalFlex = UFA.Fill,
			Padding = UD(0, 4),
			SortOrder = SO.LayoutOrder,
			VerticalFlex = UFA.Fill,
		})
		tabItems.PageLayout = page_layout

		function tabCfg:AddColumn()
			return createColumn(tab_page)
		end

		tab_frame.InputBegan:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				self:SelectTab(tabCfg)
			end
		end)

		TIS(self.Tabs, tabCfg)
		if self.TabCount == 1 then
			self:SelectTab(tabCfg)
		end

		return tabCfg
	end

	function Cfg:SelectTab(tab)
		if self.ActiveTab == tab then return end
		if self.ActiveTab then
			local old = self.ActiveTab
			tweenObject(old.Items.TabFrame, {BackgroundColor3 = RGB(30, 28, 28)})
			tweenObject(old.Items.TabText, {TextColor3 = RGB(145, 145, 145)})
			old.Items.TabPage.Visible = false
		end
		self.ActiveTab = tab
		tweenObject(tab.Items.TabFrame, {BackgroundColor3 = RGB(38, 35, 35)})
		tweenObject(tab.Items.TabText, {TextColor3 = RGB(255, 255, 255)})
		tab.Items.TabPage.Visible = true
		tab.Items.TabPage.Parent = content
		tab.Items.TabPage.Position = UFO(0, 0)
	end

	local notif_bg = create("Frame", {
		Parent = ScreenGui,
		Name = "notifications",
		BackgroundTransparency = 1,
		Position = UFS(0, 0),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(300, 500),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame
	Items.Notifications = notif_bg

	local notif_list = create("UIListLayout", {
		Parent = notif_bg,
		Padding = UD(0, 4),
		SortOrder = SO.LayoutOrder,
		VerticalFlex = UFA.Fill,
	})
	Items.NotifListLayout = notif_list

	local notif_pad = create("UIPadding", {
		Parent = notif_bg,
		PaddingTop = UD(0, 4),
		PaddingLeft = UD(0, 4),
	})

	function Cfg:Notify(text, duration)
		duration = duration or 3
		local notif_frame = create("Frame", {
			Parent = notif_bg,
			Name = "notification",
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(0, 17),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(30, 28, 28),
			AutomaticSize = AS.X,
		}) :: Frame
		local n_stroke = create("UIStroke", {
			Parent = notif_frame,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})
		local n_c = create("Frame", {
			Parent = notif_frame,
			Name = "c",
			BackgroundTransparency = 1,
			Position = UFS(0.0098, 0.0667),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(0, 11),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(38, 35, 35),
			AutomaticSize = AS.X,
		}) :: Frame
		local n_pad = create("UIPadding", {
			Parent = n_c,
			PaddingRight = UD(0, 6),
		})
		local n_text = create("TextLabel", {
			Parent = n_c,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = text,
			Name = "text",
			Size = UFO(0, 11),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Left,
			BorderSizePixel = 0,
			AutomaticSize = AS.X,
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		local n_accent = create("Frame", {
			Parent = n_c,
			Name = "accent",
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(1, 14),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(255, 174, 82),
		})
		local n_accent_line = create("Frame", {
			Parent = notif_frame,
			Name = "accent_line",
			Position = UFS(0.0105, 0.8902),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(0, 1),
			BorderSizePixel = 0,
			AutomaticSize = AS.X,
			BackgroundColor3 = RGB(255, 174, 82),
		})
		task.spawn(function()
			task.wait(duration)
			tweenObject(notif_frame, {BackgroundTransparency = 1}, TI(0.25, ES.Cubic, ED.Out))
			local c_trans = tweenObject(n_c, {BackgroundTransparency = 1}, TI(0.25, ES.Cubic, ED.Out))
			tweenObject(n_text, {TextTransparency = 1}, TI(0.25, ES.Cubic, ED.Out))
			tweenObject(n_accent, {BackgroundTransparency = 1}, TI(0.25, ES.Cubic, ED.Out))
			tweenObject(n_accent_line, {BackgroundTransparency = 1}, TI(0.25, ES.Cubic, ED.Out))
			c_trans.Completed:Wait()
			notif_frame:Destroy()
		end)
	end

	local watermark = create("Frame", {
		Parent = ScreenGui,
		Name = "watermark",
		Position = UFS(0.0252, 0.0379),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(0, 17),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(30, 28, 28),
		AutomaticSize = AS.X,
	}) :: Frame
	Items.Watermark = watermark

	local w_stroke = create("UIStroke", {
		Parent = watermark,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local w_c = create("Frame", {
		Parent = watermark,
		Name = "c",
		Position = UFS(0.01, 0.2125),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(0, 12),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(38, 35, 35),
		AutomaticSize = AS.X,
	}) :: Frame

	local w_pad = create("UIPadding", {
		Parent = w_c,
		PaddingRight = UD(0, 6),
	})

	local w_text = create("TextLabel", {
		Parent = w_c,
		FontFace = getFont(),
		TextColor3 = RGB(255, 255, 255),
		BorderColor3 = RGB(0, 0, 0),
		Text = "Watermark | 0 ms",
		Size = UFO(0, 11),
		BackgroundTransparency = 1,
		TextXAlignment = TXA.Left,
		BorderSizePixel = 0,
		AutomaticSize = AS.X,
		TextSize = 10,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: TextLabel
	Items.WatermarkText = w_text

	create("UIStroke", {
		Parent = w_text,
		LineJoinMode = Enum.LineJoinMode.Miter,
		Transparency = 1,
	})

	local w_accent = create("Frame", {
		Parent = watermark,
		Name = "accent",
		Position = UFS(0.0098, 0.0667),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(0, 2),
		BorderSizePixel = 0,
		AutomaticSize = AS.X,
		BackgroundColor3 = RGB(255, 174, 82),
	}) :: Frame

	create("UIGradient", {
		Parent = w_accent,
		Rotation = 90,
		Color = CS{CSK(0, RGB(255, 255, 255)), CSK(1, RGB(30, 30, 30))},
	})

	Library:Connect(runService.RenderStepped, function()
		local fps = GR(1 / runService.RenderStepped:Wait())
		w_text.Text = "Watermark | " .. fps .. " ms"
	end)

	return Cfg
end

createSection = function(parent)
	local section_self = {
		Items = {},
		Elements = {},
	}

	local s_items = section_self.Items

	local section_frame = create("Frame", {
		Parent = parent,
		Name = "section",
		Position = UFS(0, 0),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(175, 84),
		BorderSizePixel = 0,
		AutomaticSize = AS.Y,
		BackgroundColor3 = RGB(30, 28, 28),
	}) :: Frame
	s_items.Section = section_frame

	create("UIStroke", {
		Parent = section_frame,
		Color = RGB(54, 50, 50),
		LineJoinMode = Enum.LineJoinMode.Bevel,
		Thickness = 1.3,
	})

	local section_accent_right = create("Frame", {
		Parent = section_frame,
		Name = "section_accent_right",
		Position = UD2(0, 0, 0, 1),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(0, 1),
		BorderSizePixel = 0,
		AutomaticSize = AS.X,
		BackgroundColor3 = RGB(255, 174, 82),
	})
	s_items.AccentRight = section_accent_right

	local section_accent_left = create("Frame", {
		Parent = section_frame,
		Name = "section_accent_left",
		Position = UFO(1, 1),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(12, 1),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 174, 82),
	})
	s_items.AccentLeft = section_accent_left

	local section_content = create("Frame", {
		Parent = section_frame,
		Name = "section_content",
		BackgroundTransparency = 1,
		Position = UFS(0.0057, 0.0413),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(173, 73),
		BorderSizePixel = 0,
		AutomaticSize = AS.Y,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame
	s_items.Content = section_content

	local section_layout = create("UIListLayout", {
		Parent = section_content,
		Padding = UD(0, 2),
		SortOrder = SO.LayoutOrder,
	})
	s_items.Layout = section_layout

	function section_self:SetTitle(title)
		if s_items.Title then
			s_items.Title:Destroy()
		end
		local title_label = create("TextLabel", {
			Parent = section_frame,
			TextWrapped = true,
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = title or "section",
			TextStrokeTransparency = 0,
			Name = "section_title",
			Size = UFO(38, 12),
			BackgroundTransparency = 1,
			Position = UFS(0.08, -0.116),
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		s_items.Title = title_label
		create("UIStroke", {
			Parent = title_label,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})
	end

	function section_self:AddToggle(data)
		data = data or {}
		local toggle_cfg = {
			Text = data.Text or "toggle",
			Value = data.Default or false,
			Callback = data.Callback or function() end,
			Flag = data.Flag or nil,
			Items = {},
			Section = section_self,
		}
		toggle_cfg.__index = toggle_cfg

		local t_items = toggle_cfg.Items

		if data.Flag then
			Library.Flags[data.Flag] = toggle_cfg.Value
		end

		local toggle_frame = create("Frame", {
			Parent = section_content,
			Name = "toggle",
			BackgroundTransparency = 1,
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(173, 15),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: Frame
		t_items.Frame = toggle_frame

		local toggle_box = create("Frame", {
			Parent = toggle_frame,
			Name = "toggle_box",
			Position = UFS(0.037, 0.2),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(9, 9),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(0, 0, 0),
		}) :: Frame
		t_items.Box = toggle_box

		create("UIStroke", {
			Parent = toggle_box,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})

		local toggle_accent = create("Frame", {
			Parent = toggle_box,
			Name = "toggle_accent",
			Position = UFS(0.09, 0.1),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(7, 7),
			BorderSizePixel = 0,
			BackgroundColor3 = toggle_cfg.Value and RGB(255, 174, 82) or RGB(30, 28, 28),
		}) :: Frame
		t_items.Accent = toggle_accent

		local toggle_text = create("TextLabel", {
			Parent = toggle_frame,
			TextWrapped = true,
			TextColor3 = toggle_cfg.Value and RGB(255, 255, 255) or RGB(145, 145, 145),
			BorderColor3 = RGB(0, 0, 0),
			Text = toggle_cfg.Text,
			Name = "toggle_text",
			TextStrokeTransparency = 0,
			Size = UFO(151, 9),
			Position = UFS(0.1243, 0.1333),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Left,
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		t_items.Text = toggle_text

		create("UIStroke", {
			Parent = toggle_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local function setValue(v)
			toggle_cfg.Value = v
			tweenObject(toggle_accent, {BackgroundColor3 = v and RGB(255, 174, 82) or RGB(30, 28, 28)})
			tweenObject(toggle_text, {TextColor3 = v and RGB(255, 255, 255) or RGB(145, 145, 145)})
			if data.Flag then Library.Flags[data.Flag] = v end
			toggle_cfg.Callback(v)
		end

		toggle_frame.InputBegan:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				setValue(not toggle_cfg.Value)
			end
		end)

		if data.ColorPicker then
			local cp_data = data.ColorPicker
			local cp_frame = create("Frame", {
				Parent = toggle_frame,
				Name = "colorpicker",
				Position = UFS(0.8367, 0.2),
				BorderColor3 = RGB(0, 0, 0),
				Size = UFO(21, 9),
				BorderSizePixel = 0,
				BackgroundColor3 = RGB(30, 28, 28),
			}) :: Frame
			t_items.ColorPicker = cp_frame

			create("UIStroke", {
				Parent = cp_frame,
				Color = RGB(54, 50, 50),
				LineJoinMode = Enum.LineJoinMode.Bevel,
				Thickness = 1.3,
			})

			local cp_color = create("Frame", {
				Parent = cp_frame,
				Name = "cp_color",
				Position = UFS(0.0476, 0.1),
				BorderColor3 = RGB(0, 0, 0),
				Size = UFO(19, 7),
				BorderSizePixel = 0,
				BackgroundColor3 = cp_data.Default or RGB(255, 0, 0),
			}) :: Frame
			t_items.CPColor = cp_color

			cp_frame.InputBegan:Connect(function(input)
				if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				end
			end)
		end

		if data.KeyPicker then
			local kp_data = data.KeyPicker
			local kp_frame = create("Frame", {
				Parent = toggle_frame,
				Name = "keypicker",
				Position = UFS(0.8367, 0.2),
				BorderColor3 = RGB(0, 0, 0),
				Size = UFO(21, 9),
				BorderSizePixel = 0,
				BackgroundColor3 = RGB(30, 28, 28),
			}) :: Frame
			t_items.KeyPicker = kp_frame

			create("UIStroke", {
				Parent = kp_frame,
				Color = RGB(54, 50, 50),
				LineJoinMode = Enum.LineJoinMode.Bevel,
				Thickness = 1.3,
			})

			local kp_text = create("TextLabel", {
				Parent = kp_frame,
				FontFace = getFont(),
				TextColor3 = RGB(255, 255, 255),
				BorderColor3 = RGB(0, 0, 0),
				Text = kp_data.Default or "RMB",
				Name = "key_text",
				Size = UFO(21, 8),
				BackgroundTransparency = 1,
				Position = UFS(0, 0.0427),
				BorderSizePixel = 0,
				TextSize = 10,
				BackgroundColor3 = RGB(255, 255, 255),
			}) :: TextLabel
			t_items.KPText = kp_text

			create("UIStroke", {
				Parent = kp_text,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Transparency = 1,
			})
		end

		function toggle_cfg:Set(v)
			setValue(v)
		end

		TIS(section_self.Elements, toggle_cfg)
		return toggle_cfg
	end

	function section_self:AddButton(data)
		data = data or {}
		local btn_cfg = {
			Text = data.Text or "button",
			Callback = data.Callback or function() end,
			Items = {},
			Section = section_self,
		}
		btn_cfg.__index = btn_cfg

		local b_items = btn_cfg.Items

		local btn_frame = create("Frame", {
			Parent = section_content,
			Name = "button",
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(159, 15),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(30, 28, 28),
		}) :: Frame
		b_items.Frame = btn_frame

		create("UIStroke", {
			Parent = btn_frame,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})

		local clickable = create("Frame", {
			Parent = btn_frame,
			Name = "clickable",
			Position = UFS(0.0058, 0.0667),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(157, 13),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(38, 35, 35),
		}) :: Frame
		b_items.Clickable = clickable

		local btn_text = create("TextLabel", {
			Parent = clickable,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = btn_cfg.Text,
			Name = "button_text",
			Size = UFO(158, 15),
			BackgroundTransparency = 1,
			Position = UFS(0, -0.0769),
			BorderSizePixel = 0,
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		b_items.Text = btn_text

		create("UIStroke", {
			Parent = btn_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		clickable.InputBegan:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				tweenObject(clickable, {BackgroundColor3 = RGB(54, 50, 50)}, TI(0.25, ES.Cubic, ED.Out))
				task.delay(0.1, function()
					tweenObject(clickable, {BackgroundColor3 = RGB(38, 35, 35)}, TI(0.25, ES.Cubic, ED.Out))
				end)
				btn_cfg.Callback()
			end
		end)

		TIS(section_self.Elements, btn_cfg)
		return btn_cfg
	end

	function section_self:AddLabel(data)
		data = data or {}
		local label_cfg = {
			Text = data.Text or "label",
			Items = {},
			Section = section_self,
		}
		label_cfg.__index = label_cfg

		local l_items = label_cfg.Items

		local label_frame = create("Frame", {
			Parent = section_content,
			Name = "label",
			BackgroundTransparency = 1,
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(173, 15),
			BorderSizePixel = 0,
			AutomaticSize = AS.Y,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: Frame
		l_items.Frame = label_frame

		local label_text = create("TextLabel", {
			Parent = label_frame,
			TextWrapped = true,
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = label_cfg.Text,
			Name = "label_text",
			TextStrokeTransparency = 0,
			Size = UFO(167, 9),
			Position = UFS(0.03, 0.133),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Left,
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			AutomaticSize = AS.Y,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		l_items.Text = label_text

		create("UIStroke", {
			Parent = label_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		function label_cfg:Set(text)
			label_text.Text = text
		end

		TIS(section_self.Elements, label_cfg)
		return label_cfg
	end

	function section_self:AddSlider(data)
		data = data or {}
		local slider_cfg = {
			Text = data.Text or "slider",
			Min = data.Min or 0,
			Max = data.Max or 100,
			Default = data.Default or 50,
			Value = data.Default or 50,
			Callback = data.Callback or function() end,
			Flag = data.Flag or nil,
			Items = {},
			Section = section_self,
		}
		slider_cfg.__index = slider_cfg

		local s_items = slider_cfg.Items

		if data.Flag then
			Library.Flags[data.Flag] = slider_cfg.Value
		end

		local slider_frame = create("Frame", {
			Parent = section_content,
			Name = "slider",
			BackgroundTransparency = 1,
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(173, 21),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: Frame
		s_items.Frame = slider_frame

		local slider_text = create("TextLabel", {
			Parent = slider_frame,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = slider_cfg.Text,
			Name = "slider_text",
			Size = UFO(159, 7),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Left,
			Position = UFS(0.03, -0.0155),
			BorderSizePixel = 0,
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		s_items.SliderText = slider_text

		create("UIStroke", {
			Parent = slider_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local pm_text = create("TextLabel", {
			Parent = slider_frame,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = "+ -",
			Name = "plusminus",
			Size = UFO(159, 7),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Right,
			Position = UFS(0.03, -0.0155),
			BorderSizePixel = 0,
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		s_items.PlusMinus = pm_text

		create("UIStroke", {
			Parent = pm_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local slider_body = create("Frame", {
			Parent = slider_frame,
			Name = "slider_body",
			Position = UFS(0.0347, 0.502),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(160, 9),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(30, 28, 28),
		}) :: Frame
		s_items.Body = slider_body

		create("UIStroke", {
			Parent = slider_body,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})

		local slider_clickable = create("Frame", {
			Parent = slider_body,
			Name = "slider_clickable",
			Position = UFS(0.0058, 0.1788),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(158, 7),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(38, 35, 35),
		}) :: Frame
		s_items.Clickable = slider_clickable

		local slider_fill = create("Frame", {
			Parent = slider_clickable,
			Name = "slider_fill",
			Position = UFS(0, -0.0822),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(0, 7),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(255, 174, 82),
		}) :: Frame
		s_items.Fill = slider_fill

		local slider_val = create("TextLabel", {
			Parent = slider_fill,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = tostring(slider_cfg.Default) .. "%",
			Size = UFO(0, 6),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Right,
			Position = UFS(0, 0.5714),
			BorderSizePixel = 0,
			AutomaticSize = AS.X,
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		s_items.ValueText = slider_val

		create("UIStroke", {
			Parent = slider_val,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local function updateSlider(input)
			local size = (input.Position.X - slider_clickable.AbsolutePosition.X) / slider_clickable.AbsoluteSize.X
			local value = ((slider_cfg.Max - slider_cfg.Min) * MC(size, 0, 1)) + slider_cfg.Min
			value = GR(value)
			slider_cfg.Value = value
			local pct = (value - slider_cfg.Min) / (slider_cfg.Max - slider_cfg.Min)
			slider_fill.Size = UFO(158 * pct, 7)
			slider_val.Text = tostring(value) .. "%"
			slider_val.Size = UFO(0, 6)
			if data.Flag then Library.Flags[data.Flag] = value end
			slider_cfg.Callback(value)
		end

		local sliding = false
		slider_clickable.InputBegan:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				sliding = true
				updateSlider(input)
			end
		end)

		slider_clickable.InputEnded:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 or input.UserInputType == UIT.Touch then
				sliding = false
			end
		end)

		Library:Connect(userInputService.InputChanged, function(input)
			if sliding and (input.UserInputType == UIT.MouseMovement or input.UserInputType == UIT.Touch) then
				updateSlider(input)
			end
		end)

		local pct = (slider_cfg.Default - slider_cfg.Min) / (slider_cfg.Max - slider_cfg.Min)
		slider_fill.Size = UFO(158 * pct, 7)
		slider_val.Text = tostring(slider_cfg.Default) .. "%"
		slider_val.Size = UFO(0, 6)

		function slider_cfg:Set(v)
			slider_cfg.Value = v
			local pct = (v - slider_cfg.Min) / (slider_cfg.Max - slider_cfg.Min)
			slider_fill.Size = UFO(158 * pct, 7)
			slider_val.Text = tostring(v) .. "%"
			slider_val.Size = UFO(0, 6)
			if data.Flag then Library.Flags[data.Flag] = v end
			slider_cfg.Callback(v)
		end

		TIS(section_self.Elements, slider_cfg)
		return slider_cfg
	end

	function section_self:AddDropdown(data)
		data = data or {}
		local drop_cfg = {
			Text = data.Text or "dropdown",
			Options = data.Options or {},
			Default = data.Default or "",
			Multi = data.Multi or false,
			Callback = data.Callback or function() end,
			Flag = data.Flag or nil,
			Items = {},
			Section = section_self,
			Open = false,
			OptionInstances = {},
			MultiItems = {},
		}
		drop_cfg.__index = drop_cfg

		local d_items = drop_cfg.Items

		if data.Flag then
			Library.Flags[data.Flag] = drop_cfg.Multi and {} or ""
		end

		local drop_frame = create("Frame", {
			Parent = section_content,
			Name = "dropdown",
			Position = UFS(0, 0),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(159, 15),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(30, 28, 28),
		}) :: Frame
		d_items.Frame = drop_frame

		create("UIStroke", {
			Parent = drop_frame,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})

		local clickable = create("Frame", {
			Parent = drop_frame,
			Name = "clickable",
			Position = UFS(0.0058, 0.0667),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(157, 13),
			BorderSizePixel = 0,
			BackgroundColor3 = RGB(38, 35, 35),
		}) :: Frame
		d_items.Clickable = clickable

		local value_text = create("TextLabel", {
			Parent = clickable,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = drop_cfg.Default or (drop_cfg.Multi and "" or drop_cfg.Options[1] or "select"),
			Name = "value_text",
			TextStrokeTransparency = 0,
			Size = UFO(154, 8),
			Position = UFS(0.018, 0.1538),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Left,
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		d_items.ValueText = value_text

		create("UIStroke", {
			Parent = value_text,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local expand_btn = create("TextLabel", {
			Parent = clickable,
			FontFace = getFont(),
			TextColor3 = RGB(255, 255, 255),
			BorderColor3 = RGB(0, 0, 0),
			Text = "+",
			Name = "expand",
			TextStrokeTransparency = 0,
			Size = UFO(18, 6),
			Position = UFS(0.8587, 0.1538),
			BackgroundTransparency = 1,
			TextXAlignment = TXA.Right,
			BorderSizePixel = 0,
			FontFace = getFont(),
			TextSize = 10,
			BackgroundColor3 = RGB(255, 255, 255),
		}) :: TextLabel
		d_items.Expand = expand_btn

		create("UIStroke", {
			Parent = expand_btn,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Transparency = 1,
		})

		local drop_container = create("Frame", {
			Parent = drop_frame,
			Name = "drop_container",
			Position = UFS(0, 1),
			BorderColor3 = RGB(0, 0, 0),
			Size = UFO(159, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			BackgroundColor3 = RGB(30, 28, 28),
			Visible = false,
		}) :: Frame
		d_items.Container = drop_container

		create("UIStroke", {
			Parent = drop_container,
			Color = RGB(54, 50, 50),
			LineJoinMode = Enum.LineJoinMode.Bevel,
			Thickness = 1.3,
		})

		local option_list = create("UIListLayout", {
			Parent = drop_container,
			Padding = UD(0, 1),
			SortOrder = SO.LayoutOrder,
		})
		d_items.OptionList = option_list

		local function renderOptions(options)
			for _, old in drop_cfg.OptionInstances do
				if old.Instance then old.Instance:Destroy() end
			end
			drop_cfg.OptionInstances = {}

			for _, opt in options do
				local opt_btn = create("TextButton", {
					Parent = drop_container,
					Text = "",
					AutoButtonColor = false,
					BorderColor3 = RGB(0, 0, 0),
					Size = UFO(159, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = RGB(38, 35, 35),
				}) :: TextButton
				local opt_text = create("TextLabel", {
					Parent = opt_btn,
					FontFace = getFont(),
					TextColor3 = RGB(255, 255, 255),
					BorderColor3 = RGB(0, 0, 0),
					Text = opt,
					TextStrokeTransparency = 0,
					Position = UFS(0.03, 0.1),
					Size = UFO(150, 12),
					BackgroundTransparency = 1,
					TextXAlignment = TXA.Left,
					BorderSizePixel = 0,
					TextSize = 10,
					BackgroundColor3 = RGB(255, 255, 255),
				}) :: TextLabel
				TIS(drop_cfg.OptionInstances, {Instance = opt_btn, Text = opt_text})

				opt_btn.InputBegan:Connect(function(input)
					if input.UserInputType == UIT.MouseButton1 then
						if drop_cfg.Multi then
							local idx = TF(drop_cfg.MultiItems, opt)
							if idx then
								TR(drop_cfg.MultiItems, idx)
							else
								TIS(drop_cfg.MultiItems, opt)
							end
							value_text.Text = #drop_cfg.MultiItems > 0 and TCC(drop_cfg.MultiItems, ", ") or "select"
							drop_cfg.Callback(drop_cfg.MultiItems)
							if data.Flag then Library.Flags[data.Flag] = drop_cfg.MultiItems end
						else
							value_text.Text = opt
							drop_cfg:SetOpen(false)
							drop_cfg.Callback(opt)
							if data.Flag then Library.Flags[data.Flag] = opt end
						end
					end
				end)

				opt_btn.MouseEnter:Connect(function()
					tweenObject(opt_btn, {BackgroundColor3 = RGB(54, 50, 50)}, TI(0.25, ES.Cubic, ED.Out))
				end)
				opt_btn.MouseLeave:Connect(function()
					tweenObject(opt_btn, {BackgroundColor3 = RGB(38, 35, 35)}, TI(0.25, ES.Cubic, ED.Out))
				end)
			end
		end

		renderOptions(drop_cfg.Options)

		function drop_cfg:SetOpen(bool)
			self.Open = bool
			drop_container.Visible = bool
			if bool then
				local count = #drop_cfg.Options
				local h = MM(count * 14, 100)
				tweenObject(drop_container, {Size = UFO(159, h)}, TI(0.25, ES.Cubic, ED.Out))
				drop_frame.Size = UFO(159, 15 + h)
			else
				tweenObject(drop_container, {Size = UFO(159, 0)}, TI(0.25, ES.Cubic, ED.Out))
				drop_frame.Size = UFO(159, 15)
			end
		end

		clickable.InputBegan:Connect(function(input)
			if input.UserInputType == UIT.MouseButton1 then
				drop_cfg:SetOpen(not drop_cfg.Open)
			end
		end)

		function drop_cfg:Refresh(options)
			drop_cfg.Options = options
			renderOptions(options)
		end

		TIS(section_self.Elements, drop_cfg)
		return drop_cfg
	end

	TIS(Library.Elements, section_self)
	return section_self
end

createColumn = function(parent)
	local col = create("Frame", {
		Parent = parent,
		Name = "column",
		BackgroundTransparency = 1,
		Position = UFS(0, 0),
		BorderColor3 = RGB(0, 0, 0),
		Size = UFO(175, 257),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame

	local col_layout = create("UIListLayout", {
		Parent = col,
		Padding = UD(0, 4),
		SortOrder = SO.LayoutOrder,
	})

	local col_cfg = {
		Instance = col,
		Sections = {},
	}

	function col_cfg:AddSection(title)
		local section = createSection(col)
		if title then section:SetTitle(title) end
		TIS(self.Sections, section)
		return section
	end

	return col_cfg
end

createPage = function(parent, tabPage)
	local page = create("Frame", {
		Parent = tabPage or parent,
		Name = "page",
		BackgroundTransparency = 1,
		Position = UFO(0, 0),
		BorderColor3 = RGB(0, 0, 0),
		Size = UD2(0, 501, 0, 257),
		BorderSizePixel = 0,
		BackgroundColor3 = RGB(255, 255, 255),
	}) :: Frame

	local page_layout = create("UIListLayout", {
		Parent = page,
		FillDirection = FD.Horizontal,
		HorizontalFlex = UFA.Fill,
		Padding = UD(0, 4),
		SortOrder = SO.LayoutOrder,
		VerticalFlex = UFA.Fill,
	})

	local page_cfg = {
		Instance = page,
		Columns = {},
	}

	function page_cfg:AddColumn()
		local col = createColumn(page)
		TIS(self.Columns, col)
		return col
	end

	return page_cfg
end

function Library:Unload()
	for _, conn in self.Connections do
		if conn.Connection then
			conn.Connection:Disconnect()
		end
	end
	for _, thread in self.Threads do
		coroutine.close(thread)
	end
	for _, gui in self.Guis do
		if gui then
			gui:Destroy()
		end
	end
	for _, v in self.Elements do
		if type(v) == "table" and v.Instance and v.Instance:IsA("Instance") then
			v.Instance:Destroy()
		end
	end
	Library = nil
	getgenv().Library = nil
end

-- Example usage
local Window = Library:CreateWindow({
	Title = "My UI",
})

local MainTab = Window:AddTab({
	Text = "Main",
})

local Col1 = MainTab:AddColumn()

local Combat = Col1:AddSection("Combat")
Combat:AddToggle({
	Text = "Aimbot",
	Flag = "aimbot",
	Default = true,
})
Combat:AddToggle({
	Text = "ESP",
	Flag = "esp",
	ColorPicker = {Default = RGB(255, 0, 0)},
	KeyPicker = {Default = "RMB"},
})
Combat:AddButton({
	Text = "Click Me",
	Callback = function()
		Window:Notify("Button was clicked!", 2)
	end,
})

local Col2 = MainTab:AddColumn()

local Visuals = Col2:AddSection("Visuals")
Visuals:AddLabel("Hello World")
Visuals:AddSlider({
	Text = "FOV",
	Flag = "fov",
	Default = 90,
	Min = 0,
	Max = 180,
})
Visuals:AddDropdown({
	Text = "Weapon",
	Flag = "weapon",
	Values = {"AK47", "M4A1", "AWP"},
	Default = 1,
})
Visuals:AddDropdown({
	Text = "Mode",
	Flag = "mode",
	Values = {"Deathmatch", "Competitive", "Casual"},
	Multi = true,
})

local OtherTab = Window:AddTab({
	Text = "Settings",
})
local Col3 = OtherTab:AddColumn()
local Settings = Col3:AddSection("Settings")
Settings:AddButton({
	Text = "Unload",
	Callback = function()
		Library:Unload()
	end,
})

print("UI loaded successfully!")

end

getgenv().Library = Library
return Library
