<<<<<<< HEAD:NewMainScript.lua
repeat task.wait() until game:IsLoaded() == true

local function GetURL(scripturl)
	return game:HttpGet("https://raw.githubusercontent.com/Cadez650/VapeCustom/main/"..scripturl, true)
end
local getasset = getsynasset or getcustomasset
if getasset == nil and getgenv().getcustomasset == nil then
	getgenv().getcustomasset = function(location) return "rbxasset://"..location end
	getasset = getgenv().getcustomasset
end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request

local function checkassetversion()
	local req = requestfunc({
		Url = "https://raw.githubusercontent.com/Cadez650/VapeCustom/main/assetsversion.dat",
		Method = "GET"
	})
	if req.StatusCode == 200 then
		return req.Body
	else
		return nil
	end
end
--
if not (getasset and requestfunc and queueteleport) then
	print("Vape not supported with your exploit.")
	return
end

if shared.VapeExecuted then
	error("Vape Already Injected")
	return
else
	shared.VapeExecuted = true
end

if isfolder("vape") == false then
	makefolder("vape")
end
if isfile("vape/assetsversion.dat") == false then
	writefile("vape/assetsversion.dat", "1")
end
if isfolder("vape/CustomModules") == false then
	makefolder("vape/CustomModules")
end
if isfolder("vape/Profiles") == false then
	makefolder("vape/Profiles")
end
local assetver = checkassetversion()
if assetver and assetver > readfile("vape/assetsversion.dat") then
	if shared.VapeDeveloper == nil then
		if isfolder("vape/assets") then
			if delfolder then
				delfolder("vape/assets")
			end
		end
		writefile("vape/assetsversion.dat", assetver)
	end
end
if isfolder("vape/assets") == false then
	makefolder("vape/assets")
end

local GuiLibrary = loadstring(GetURL("NewGuiLibrary.lua"))()

local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function(id)
	local suc, req = pcall(function() return requestfunc({
		Url = "https://raw.githubusercontent.com/Cadez650/VapeCustom/main/CustomModules/"..id..".vape",
		Method = "GET"
	}) end)
	if not suc then
		checkpublicreponum = checkpublicreponum + 1
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Loading CustomModule Failed!, Attempts : "..checkpublicreponum
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			task.wait(2)
			textlabel:Remove()
		end)
		task.wait(2)
		return checkpublicrepo(id)
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end

local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until isfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

shared.GuiLibrary = GuiLibrary
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local selfdestruct = false
local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
	["Name"] = "Combat", 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
local Blatant = GuiLibrary.CreateWindow({
	["Name"] = "Blatant", 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
local Render = GuiLibrary.CreateWindow({
	["Name"] = "Render", 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 17
})
local Utility = GuiLibrary.CreateWindow({
	["Name"] = "Utility", 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
local World = GuiLibrary.CreateWindow({
	["Name"] = "World", 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
local Friends = GuiLibrary.CreateWindow2({
	["Name"] = "Friends", 
	["Icon"] = "vape/assets/FriendsIcon.png", 
	["IconSize"] = 17
})
local Profiles = GuiLibrary.CreateWindow2({
	["Name"] = "Profiles", 
	["Icon"] = "vape/assets/ProfilesIcon.png", 
	["IconSize"] = 19
})
GUI.CreateDivider()
GUI.CreateButton({
	["Name"] = "Combat", 
	["Function"] = function(callback) Combat.SetVisible(callback) end, 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
GUI.CreateButton({
	["Name"] = "Blatant", 
	["Function"] = function(callback) Blatant.SetVisible(callback) end, 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
GUI.CreateButton({
	["Name"] = "Render", 
	["Function"] = function(callback) Render.SetVisible(callback) end, 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "Utility", 
	["Function"] = function(callback) Utility.SetVisible(callback) end, 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "World", 
	["Function"] = function(callback) World.SetVisible(callback) end, 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
GUI.CreateDivider("MISC")
GUI.CreateButton({
	["Name"] = "Friends", 
	["Function"] = function(callback) Friends.SetVisible(callback) end, 
})
GUI.CreateButton({
	["Name"] = "Profiles", 
	["Function"] = function(callback) Profiles.SetVisible(callback) end, 
})
local FriendsTextList = {["RefreshValues"] = function() end}
local FriendsColor = {["Value"] = 0.44}
FriendsTextList = Friends.CreateCircleTextList({
	["Name"] = "FriendsList", 
	["TempText"] = "Username / Alias", 
	["Color"] = Color3.fromRGB(5, 133, 104),	
	["CustomFunction"] = function(obj)
		obj.ItemText.TextColor3 = Color3.new(1, 1, 1)
		local friendcircle = Instance.new("Frame")
		friendcircle.Size = UDim2.new(0, 10, 0, 10)
		friendcircle.Name = "FriendCircle"
		friendcircle.BackgroundColor3 = Color3.fromHSV(FriendsColor["Value"], 0.7, 0.9)
		friendcircle.BorderSizePixel = 0
		friendcircle.Position = UDim2.new(0, 10, 0, 13)
		friendcircle.Parent = obj
		local friendcorner = Instance.new("UICorner")
		friendcorner.CornerRadius = UDim.new(0, 8)
		friendcorner.Parent = friendcircle
		obj.ItemText.Position = UDim2.new(0, 36, 0, 0)
		obj.ItemText.Size = UDim2.new(0, 157, 0, 33)
	end
})
Friends.CreateToggle({
	["Name"] = "Use Friends",
	["Function"] = function(callback) end,
	["Default"] = true
})
Friends.CreateToggle({
	["Name"] = "Use Alias",
	["Function"] = function(callback) end,
	["Default"] = true,
})
Friends.CreateToggle({
	["Name"] = "Spoof alias",
	["Function"] = function(callback) end,
})
Friends.CreateToggle({
	["Name"] = "Recolor visuals",
	["Function"] = function(callback) end,
	["Default"] = true
})
FriendsColor = Friends.CreateColorSlider({
	["Name"] = "Friends Color", 
	["Function"] = function(val) 

	end
})
local ProfilesTextList = {["RefreshValues"] = function() end}
local profilesloaded = false
ProfilesTextList = Profiles.CreateTextList({
	["Name"] = "ProfilesList",
	["TempText"] = "Type name", 
	["AddFunction"] = function(user)
		GuiLibrary["Profiles"][user] = {["Keybind"] = "", ["Selected"] = false}
	end, 
	["RemoveFunction"] = function(num) 
		if #ProfilesTextList["ObjectList"] == 0 then
			table.insert(ProfilesTextList["ObjectList"], "default")
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
	end, 
	["CustomFunction"] = function(obj, profilename) 
		if GuiLibrary["Profiles"][profilename] == nil then
			GuiLibrary["Profiles"][profilename] = {["Keybind"] = ""}
		end
		obj.MouseButton1Click:connect(function()
			GuiLibrary["SwitchProfile"](profilename)
		end)
		local newsize = UDim2.new(0, 20, 0, 21)
		local bindbkg = Instance.new("TextButton")
		bindbkg.Text = ""
		bindbkg.AutoButtonColor = false
		bindbkg.Size = UDim2.new(0, 20, 0, 21)
		bindbkg.Position = UDim2.new(1, -50, 0, 6)
		bindbkg.BorderSizePixel = 0
		bindbkg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindbkg.BackgroundTransparency = 0.95
		bindbkg.Visible = GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		bindbkg.Parent = obj
		local bindimg = Instance.new("ImageLabel")
		bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
		bindimg.BackgroundTransparency = 1
		bindimg.Size = UDim2.new(0, 12, 0, 12)
		bindimg.Position = UDim2.new(0, 4, 0, 5)
		bindimg.ImageTransparency = 0.2
		bindimg.Active = false
		bindimg.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] == "")
		bindimg.Parent = bindbkg
		local bindtext = Instance.new("TextLabel")
		bindtext.Active = false
		bindtext.BackgroundTransparency = 1
		bindtext.TextSize = 16
		bindtext.Parent = bindbkg
		bindtext.Font = Enum.Font.SourceSans
		bindtext.Size = UDim2.new(1, 0, 1, 0)
		bindtext.TextColor3 = Color3.fromRGB(85, 85, 85)
		bindtext.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] ~= "")
		local bindtext2 = Instance.new("TextLabel")
		bindtext2.Text = "PRESS A KEY TO BIND"
		bindtext2.Size = UDim2.new(0, 150, 0, 33)
		bindtext2.Font = Enum.Font.SourceSans
		bindtext2.TextSize = 17
		bindtext2.TextColor3 = Color3.fromRGB(201, 201, 201)
		bindtext2.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
		bindtext2.BorderSizePixel = 0
		bindtext2.Visible = false
		bindtext2.Parent = obj
		local bindround = Instance.new("UICorner")
		bindround.CornerRadius = UDim.new(0, 4)
		bindround.Parent = bindbkg
		bindbkg.MouseButton1Click:connect(function()
			if GuiLibrary["KeybindCaptured"] == false then
				GuiLibrary["KeybindCaptured"] = true
				spawn(function()
					bindtext2.Visible = true
					repeat task.wait() until GuiLibrary["PressedKeybindKey"] ~= ""
					local key = (GuiLibrary["PressedKeybindKey"] == GuiLibrary["Profiles"][profilename]["Keybind"] and "" or GuiLibrary["PressedKeybindKey"])
					if key == "" then
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						newsize = UDim2.new(0, 20, 0, 21)
						bindbkg.Size = newsize
						bindbkg.Visible = true
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = true
						bindtext.Visible = false
						bindtext.Text = key
					else
						local textsize = game:GetService("TextService"):GetTextSize(key, 16, bindtext.Font, Vector2.new(99999, 99999))
						newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						bindbkg.Visible = true
						bindbkg.Size = newsize
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = false
						bindtext.Visible = true
						bindtext.Text = key
					end
					GuiLibrary["PressedKeybindKey"] = ""
					GuiLibrary["KeybindCaptured"] = false
					bindtext2.Visible = false
				end)
			end
		end)
		bindbkg.MouseEnter:connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/PencilIcon.png") 
			bindimg.Visible = true
			bindtext.Visible = false
			bindbkg.Size = UDim2.new(0, 20, 0, 21)
			bindbkg.Position = UDim2.new(1, -50, 0, 6)
		end)
		bindbkg.MouseLeave:connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
			if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then
				bindimg.Visible = false
				bindtext.Visible = true
				bindbkg.Size = newsize
				bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
			end
		end)
		obj.MouseEnter:connect(function()
			bindbkg.Visible = true
		end)
		obj.MouseLeave:connect(function()
			bindbkg.Visible = GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		end)
		if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then

			bindtext.Text = GuiLibrary["Profiles"][profilename]["Keybind"]
			local textsize = game:GetService("TextService"):GetTextSize(GuiLibrary["Profiles"][profilename]["Keybind"], 16, bindtext.Font, Vector2.new(99999, 99999))
			newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
			bindbkg.Size = newsize
			bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
		end
		if profilename == GuiLibrary["CurrentProfile"] then
			obj.BackgroundColor3 = Color3.fromHSV(GuiLibrary["Settings"]["GUIObject"]["Color"], 0.7, 0.9)
			obj.ImageButton.BackgroundColor3 = Color3.fromHSV(GuiLibrary["Settings"]["GUIObject"]["Color"], 0.7, 0.9)
			obj.ItemText.TextColor3 = Color3.new(1, 1, 1)
			obj.ItemText.TextStrokeTransparency = 0.75
			bindbkg.BackgroundTransparency = 0.9
			bindtext.TextColor3 = Color3.fromRGB(214, 214, 214)
		end
	end
})
local OnlineProfilesButton = Instance.new("TextButton")
OnlineProfilesButton.Name = "OnlineProfilesButton"
OnlineProfilesButton.LayoutOrder = 1
OnlineProfilesButton.AutoButtonColor = false
OnlineProfilesButton.Size = UDim2.new(0, 45, 0, 29)
OnlineProfilesButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesButton.Active = false
OnlineProfilesButton.Text = ""
OnlineProfilesButton.ZIndex = 4
OnlineProfilesButton.Font = Enum.Font.SourceSans
OnlineProfilesButton.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesButton.Position = UDim2.new(0, 166, 0, 6)
OnlineProfilesButton.Parent = ProfilesTextList["Object"]
local OnlineProfilesButtonBKG = Instance.new("Frame")
OnlineProfilesButtonBKG.BackgroundColor3 = Color3.fromRGB(38, 37, 38)
OnlineProfilesButtonBKG.Size = UDim2.new(0, 47, 0, 31)
OnlineProfilesButtonBKG.Position = UDim2.new(0, 165, 0, 5)
OnlineProfilesButtonBKG.ZIndex = 3
OnlineProfilesButtonBKG.Parent = ProfilesTextList["Object"]
local OnlineProfilesButtonImage = Instance.new("ImageLabel")
OnlineProfilesButtonImage.BackgroundTransparency = 1
OnlineProfilesButtonImage.Position = UDim2.new(0, 14, 0, 7)
OnlineProfilesButtonImage.Size = UDim2.new(0, 17, 0, 16)
OnlineProfilesButtonImage.Image = getcustomassetfunc("vape/assets/OnlineProfilesButton.png")
OnlineProfilesButtonImage.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesButtonImage.ZIndex = 5
OnlineProfilesButtonImage.Active = false
OnlineProfilesButtonImage.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround1 = Instance.new("UICorner")
OnlineProfilesbuttonround1.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround1.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround2 = Instance.new("UICorner")
OnlineProfilesbuttonround2.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround2.Parent = OnlineProfilesButtonBKG
local OnlineProfilesFrame = Instance.new("Frame")
OnlineProfilesFrame.Size = UDim2.new(0, 660, 0, 445)
OnlineProfilesFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
OnlineProfilesFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesFrame.Parent = GuiLibrary["MainGui"].ScaledGui.OnlineProfiles
local OnlineProfilesExitButton = Instance.new("ImageButton")
OnlineProfilesExitButton.Name = "OnlineProfilesExitButton"
OnlineProfilesExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesExitButton.Size = UDim2.new(0, 24, 0, 24)
OnlineProfilesExitButton.AutoButtonColor = false
OnlineProfilesExitButton.Image = getcustomassetfunc("vape/assets/ExitIcon1.png")
OnlineProfilesExitButton.Visible = true
OnlineProfilesExitButton.Position = UDim2.new(1, -31, 0, 8)
OnlineProfilesExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesExitButton.Parent = OnlineProfilesFrame
local OnlineProfilesExitButtonround = Instance.new("UICorner")
OnlineProfilesExitButtonround.CornerRadius = UDim.new(0, 16)
OnlineProfilesExitButtonround.Parent = OnlineProfilesExitButton
OnlineProfilesExitButton.MouseEnter:connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
OnlineProfilesExitButton.MouseLeave:connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
end)
local OnlineProfilesFrameShadow = Instance.new("ImageLabel")
OnlineProfilesFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
OnlineProfilesFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
OnlineProfilesFrameShadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
OnlineProfilesFrameShadow.BackgroundTransparency = 1
OnlineProfilesFrameShadow.ZIndex = -1
OnlineProfilesFrameShadow.Size = UDim2.new(1, 6, 1, 6)
OnlineProfilesFrameShadow.ImageColor3 = Color3.new(0, 0, 0)
OnlineProfilesFrameShadow.ScaleType = Enum.ScaleType.Slice
OnlineProfilesFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
OnlineProfilesFrameShadow.Parent = OnlineProfilesFrame
local OnlineProfilesFrameIcon = Instance.new("ImageLabel")
OnlineProfilesFrameIcon.Size = UDim2.new(0, 19, 0, 16)
OnlineProfilesFrameIcon.Image = getcustomassetfunc("vape/assets/ProfilesIcon.png")
OnlineProfilesFrameIcon.Name = "WindowIcon"
OnlineProfilesFrameIcon.BackgroundTransparency = 1
OnlineProfilesFrameIcon.Position = UDim2.new(0, 10, 0, 13)
OnlineProfilesFrameIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
OnlineProfilesFrameIcon.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText = Instance.new("TextLabel")
OnlineProfilesFrameText.Size = UDim2.new(0, 155, 0, 41)
OnlineProfilesFrameText.BackgroundTransparency = 1
OnlineProfilesFrameText.Name = "WindowTitle"
OnlineProfilesFrameText.Position = UDim2.new(0, 36, 0, 0)
OnlineProfilesFrameText.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText.Font = Enum.Font.SourceSans
OnlineProfilesFrameText.TextSize = 17
OnlineProfilesFrameText.Text = "Profiles"
OnlineProfilesFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
OnlineProfilesFrameText.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText2 = Instance.new("TextLabel")
OnlineProfilesFrameText2.TextSize = 15
OnlineProfilesFrameText2.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText2.Text = "YOUR PROFILES"
OnlineProfilesFrameText2.Font = Enum.Font.SourceSans
OnlineProfilesFrameText2.BackgroundTransparency = 1
OnlineProfilesFrameText2.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText2.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText2.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText2.Position = UDim2.new(0, 10, 0, 48)
OnlineProfilesFrameText2.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText3 = Instance.new("TextLabel")
OnlineProfilesFrameText3.TextSize = 15
OnlineProfilesFrameText3.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText3.Text = "PUBLIC PROFILES"
OnlineProfilesFrameText3.Font = Enum.Font.SourceSans
OnlineProfilesFrameText3.BackgroundTransparency = 1
OnlineProfilesFrameText3.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText3.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText3.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText3.Position = UDim2.new(0, 231, 0, 48)
OnlineProfilesFrameText3.Parent = OnlineProfilesFrame
local OnlineProfilesBorder1 = Instance.new("Frame")
OnlineProfilesBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder1.BorderSizePixel = 0
OnlineProfilesBorder1.Size = UDim2.new(1, 0, 0, 1)
OnlineProfilesBorder1.Position = UDim2.new(0, 0, 0, 41)
OnlineProfilesBorder1.Parent = OnlineProfilesFrame
local OnlineProfilesBorder2 = Instance.new("Frame")
OnlineProfilesBorder2.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder2.BorderSizePixel = 0
OnlineProfilesBorder2.Size = UDim2.new(0, 1, 1, -41)
OnlineProfilesBorder2.Position = UDim2.new(0, 220, 0, 41)
OnlineProfilesBorder2.Parent = OnlineProfilesFrame
local OnlineProfilesList = Instance.new("ScrollingFrame")
OnlineProfilesList.BackgroundTransparency = 1
OnlineProfilesList.Size = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Position = UDim2.new(0, 230, 0, 122)
OnlineProfilesList.CanvasSize = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Parent = OnlineProfilesFrame
local OnlineProfilesListGrid = Instance.new("UIGridLayout")
OnlineProfilesListGrid.CellSize = UDim2.new(0, 134, 0, 144)
OnlineProfilesListGrid.CellPadding = UDim2.new(0, 4, 0, 4)
OnlineProfilesListGrid.Parent = OnlineProfilesList
local OnlineProfilesFrameCorner = Instance.new("UICorner")
OnlineProfilesFrameCorner.CornerRadius = UDim.new(0, 4)
OnlineProfilesFrameCorner.Parent = OnlineProfilesFrame
OnlineProfilesButton.MouseButton1Click:connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = true
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = false
	if profilesloaded == false then
		local onlineprofiles = {}
		local success, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode((shared.VapeDeveloper and readfile("vape/OnlineProfiles.vapeonline") or game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/OnlineProfiles.vapeonline", true)))
		end)
		onlineprofiles = (success and result or {})
		for i2,v2 in pairs(onlineprofiles) do
			if v2["ProfileGame"] == game.PlaceId then
				local profilebox = Instance.new("Frame")
				profilebox.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
				profilebox.Parent = OnlineProfilesList
				local profiletext = Instance.new("TextLabel")
				profiletext.TextSize = 15
				profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
				profiletext.Size = UDim2.new(0, 100, 0, 20)
				profiletext.Position = UDim2.new(0, 18, 0, 25)
				profiletext.Font = Enum.Font.SourceSans
				profiletext.TextXAlignment = Enum.TextXAlignment.Left
				profiletext.TextYAlignment = Enum.TextYAlignment.Top
				profiletext.BackgroundTransparency = 1
				profiletext.Text = i2
				profiletext.Parent = profilebox
				local profiledownload = Instance.new("TextButton")
				profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
				profiledownload.Size = UDim2.new(0, 69, 0, 31)
				profiledownload.Font = Enum.Font.SourceSans
				profiledownload.TextColor3 = Color3.fromRGB(200, 200, 200)
				profiledownload.TextSize = 15
				profiledownload.AutoButtonColor = false
				profiledownload.Text = "DOWNLOAD"
				profiledownload.Position = UDim2.new(0, 14, 0, 96)
				profiledownload.Visible = false 
				profiledownload.Parent = profilebox
				profiledownload.ZIndex = 2
				local profiledownloadbkg = Instance.new("Frame")
				profiledownloadbkg.Size = UDim2.new(0, 71, 0, 33)
				profiledownloadbkg.BackgroundColor3 = Color3.fromRGB(42, 41, 42)
				profiledownloadbkg.Position = UDim2.new(0, 13, 0, 95)
				profiledownloadbkg.ZIndex = 1
				profiledownloadbkg.Visible = false
				profiledownloadbkg.Parent = profilebox
				profilebox.MouseEnter:connect(function()
					profiletext.TextColor3 = Color3.fromRGB(200, 200, 200)
					profiledownload.Visible = true 
					profiledownloadbkg.Visible = true
				end)
				profilebox.MouseLeave:connect(function()
					profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
					profiledownload.Visible = false
					profiledownloadbkg.Visible = false
				end)
				profiledownload.MouseEnter:connect(function()
					profiledownload.BackgroundColor3 = Color3.fromRGB(5, 134, 105)
				end)
				profiledownload.MouseLeave:connect(function()
					profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
				end)
				profiledownload.MouseButton1Click:connect(function()
					writefile("vape/Profiles/"..v2["ProfileName"]..tostring(game.PlaceId)..".vapeprofile", (shared.VapeDeveloper and readfile("vape/OnlineProfiles/"..v2["OnlineProfileName"]) or game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/OnlineProfiles/"..v2["OnlineProfileName"], true)))
					GuiLibrary["Profiles"][v2["ProfileName"]] = {["Keybind"] = "", ["Selected"] = false}
					if table.find(ProfilesTextList["ObjectList"], v2["ProfileName"]) == nil then
						table.insert(ProfilesTextList["ObjectList"], v2["ProfileName"])
					end
					ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
				end)
				local profileround = Instance.new("UICorner")
				profileround.CornerRadius = UDim.new(0, 4)
				profileround.Parent = profilebox
				local profileround2 = Instance.new("UICorner")
				profileround2.CornerRadius = UDim.new(0, 4)
				profileround2.Parent = profiledownload
				local profileround3 = Instance.new("UICorner")
				profileround3.CornerRadius = UDim.new(0, 4)
				profileround3.Parent = profiledownloadbkg
			end
		end
		profilesloaded = true
	end
end)
OnlineProfilesExitButton.MouseButton1Click:connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = false
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
end)

GUI.CreateDivider()
---GUI.CreateCustomButton("Favorites", "vape/assets/FavoritesListIcon.png", UDim2.new(0, 17, 0, 14), function() end, function() end)
--GUI.CreateCustomButton("Text GUIVertical", "vape/assets/TextGUIIcon3.png", UDim2.new(1, -56, 0, 15), function() end, function() end)
local TextGui = GuiLibrary.CreateCustomWindow({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon1.png", 
	["IconSize"] = 21
})
local TextGuiCircleObject = {["CircleList"] = {}}
--GUI.CreateCustomButton("Text GUI", "vape/assets/TextGUIIcon2.png", UDim2.new(1, -23, 0, 15), function() TextGui.SetVisible(true) end, function() TextGui.SetVisible(false) end, "OptionsButton")
GUI.CreateCustomToggle({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon3.png",
	["Function"] = function(callback) TextGui.SetVisible(callback) end,
	["Priority"] = 2
})	

local rainbowval = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local rainbowval2 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0.42)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 0.42))})
local rainbowval3 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local guicolorslider = {["RainbowValue"] = false}
local textguiscaleslider = {["Value"] = 10}

local onething = Instance.new("ImageLabel")
onething.Parent = TextGui.GetCustomChildren()
onething.Name = "Logo"
onething.Size = UDim2.new(0, 100, 0, 27)
onething.Position = UDim2.new(1, -140, 0, 3)
onething.BackgroundColor3 = Color3.new(0, 0, 0)
onething.BorderSizePixel = 0
onething.BackgroundTransparency = 1
onething.Visible = false
onething.Image = getcustomassetfunc("vape/assets/VapeLogo3.png")
local onething2 = Instance.new("ImageLabel")
onething2.Parent = onething
onething2.Size = UDim2.new(0, 41, 0, 24)
onething2.Name = "Logo2"
onething2.Position = UDim2.new(1, 0, 0, 1)
onething2.BorderSizePixel = 0
onething2.BackgroundColor3 = Color3.new(0, 0, 0)
onething2.BackgroundTransparency = 1
onething2.Image = getcustomassetfunc("vape/assets/VapeLogo4.png")
local onething3 = onething:Clone()
onething3.ImageColor3 = Color3.new(0, 0, 0)
onething3.ImageTransparency = 0.5
onething3.ZIndex = 0
onething3.Position = UDim2.new(0, 1, 0, 1)
onething3.Visible = false
onething3.Parent = onething
onething3.Logo2.ImageColor3 = Color3.new(0, 0, 0)
onething3.Logo2.ZIndex = 0
onething3.Logo2.ImageTransparency = 0.5
local onetext = Instance.new("TextLabel")
onetext.Parent = TextGui.GetCustomChildren()
onetext.Size = UDim2.new(1, 0, 1, 0)
onetext.Position = UDim2.new(1, -154, 0, 35)
onetext.TextColor3 = Color3.new(1, 1, 1)
onetext.RichText = true
onetext.BackgroundTransparency = 1
onetext.TextXAlignment = Enum.TextXAlignment.Left
onetext.TextYAlignment = Enum.TextYAlignment.Top
onetext.BorderSizePixel = 0
onetext.BackgroundColor3 = Color3.new(0, 0, 0)
onetext.Font = Enum.Font.SourceSans
onetext.Text = ""
onetext.TextSize = 23
local onetext2 = Instance.new("TextLabel")
onetext2.Name = "ExtraText"
onetext2.Parent = onetext
onetext2.Size = UDim2.new(1, 0, 1, 0)
onetext2.Position = UDim2.new(0, 1, 0, 1)
onetext2.BorderSizePixel = 0
onetext2.Visible = false
onetext2.ZIndex = 0
onetext2.Text = ""
onetext2.BackgroundTransparency = 1
onetext2.TextTransparency = 0.5
onetext2.TextXAlignment = Enum.TextXAlignment.Left
onetext2.TextYAlignment = Enum.TextYAlignment.Top
onetext2.TextColor3 = Color3.new(0, 0, 0)
onetext2.Font = Enum.Font.SourceSans
onetext2.TextSize = 23
local onetext3 = onetext:Clone()
onetext3.Name = "ExtraText"
onetext3.Position = UDim2.new(0, 0, 0, 0)
onetext3.TextColor3 = Color3.new(0.65, 0.65, 0.65)
onetext3.Parent = onetext
local onetext4 = onetext3.ExtraText
onetext4.TextColor3 = Color3.new(0, 0, 0)
onetext4.TextTransparency = 0.5
local onebackground = Instance.new("Frame")
onebackground.BackgroundTransparency = 0.5
onebackground.BorderSizePixel = 0
onebackground.BackgroundColor3 = Color3.new(0, 0, 0)
onebackground.Visible = false 
onebackground.Parent = TextGui.GetCustomChildren()
onebackground.ZIndex = 0
local onescale = Instance.new("UIScale")
onescale.Parent = TextGui.GetCustomChildren()
onescale:GetPropertyChangedSignal("Scale"):connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
end)
onetext3:GetPropertyChangedSignal("Text"):connect(function() onetext4.Text = onetext3.Text end)
onetext:GetPropertyChangedSignal("Size"):connect(function()
	onebackground.Position = onething.Position - UDim2.new(0, (onetext.Position.X.Offset == -154 and 10 or 0), 0, 0)
	onebackground.Size = UDim2.new(0, onetext.Size.X.Offset, 0, onetext.Size.Y.Offset + (onething.Visible and 27 or 0))
end)
onetext:GetPropertyChangedSignal("Position"):connect(function()
	onebackground.Position = onething.Position - UDim2.new(0, (onetext.Position.X.Offset == -154 and 10 or 0), 0, 0)
	onebackground.Size = UDim2.new(0, onetext.Size.X.Offset, 0, onetext.Size.Y.Offset + (onething.Visible and 27 or 0))
end)
TextGui.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
	if check then
		onetext.TextXAlignment = Enum.TextXAlignment.Right
		onetext2.TextXAlignment = Enum.TextXAlignment.Right
		onetext3.TextXAlignment = Enum.TextXAlignment.Right
		onetext4.TextXAlignment = Enum.TextXAlignment.Right
		onetext2.Position = UDim2.new(0, 1, 0, 1)
		onething.Position = UDim2.new(1, -142, 0, 8)
		onetext.Position = UDim2.new(1, -154, 0, (onething.Visible and 35 or 5))
	else
		onetext.TextXAlignment = Enum.TextXAlignment.Left
		onetext2.TextXAlignment = Enum.TextXAlignment.Left
		onetext2.Position = UDim2.new(0, 4, 0, 1)
		onetext3.TextXAlignment = Enum.TextXAlignment.Left
		onetext4.TextXAlignment = Enum.TextXAlignment.Left
		onething.Position = UDim2.new(0, 2, 0, 8)
		onetext.Position = UDim2.new(0, 6, 0, (onething.Visible and 35 or 5))
	end
end)
=======
local function getScript(URL)
    print('https://raw.githubusercontent.com/Cadez650/VapeCustom/main/'..url)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/Cadez650/VapeCustom/main/'..url, true))
end
>>>>>>> parent of db9f4a9 (dd):main.lua

local mainVape = getScript('best.lua')

print('Vape Custom: Loading Vape Custom...')