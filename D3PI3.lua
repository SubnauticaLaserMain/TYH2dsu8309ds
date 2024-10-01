repeat
	task.wait(0.2)
until (game:IsLoaded() or game:GetService("RunService"):IsRunning())


local function GetAPI_Placement()
	local a, b = pcall(function()
		local C = game:GetService("RobloxReplicatedStorage")

		if C.ClassName == 'RobloxReplicatedStorage' then
			return C
		end
	end)

	if a and b then
		return b
	end


	a, b = pcall(function()
		local C = game:GetService("CorePackages")


		if C.ClassName == 'CorePackages' then
			return C
		end
	end)

	if a and b then
		return b
	end



	a, b = pcall(function()
		local C = game:GetService("CoreGui")

		if C.ClassName == 'CoreGui' then
			return C
		end
	end)

	if a and b then
		return b
	end



	a, b = pcall(function()
		local G = game:GetService("StarterGui")


		if G and G.ClassName == 'StarterGui' then
			return G
		end
	end)

	if a and b then
		return b
	end


	a, b = pcall(function()
		local S = game:GetService("StarterPack")


		if S and S.ClassName == 'StarterPack' then
			return S
		end
	end)


	if a and b then
		return b
	end


	error('Your Executor is Hot Garbadge, cant even find a placement lol')
end


local placement = GetAPI_Placement()


local function genRandomName(length)
	local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local key = ""

	for i = 1, length do
		local randomIndex = math.random(1, #characters)
		key = key .. characters:sub(randomIndex, randomIndex)
	end

	return key
end


if shared.IsAPILoaded == true and shared.Name then
	placement:FindFirstChild(shared.Name):Destroy()
	print('API Is Already loaded in the CoreGui!')
end



shared.Name = genRandomName(20)
shared.IsAPILoaded = true







local function GiveOwnGlobals(Func, Script)
	local Fenv = {}
    local RealFenv = {script = Script}
    local FenvMt = {}
    function FenvMt:__index(b)
        if RealFenv[b] == nil then
            return getfenv()[b]
        else
            return RealFenv[b]
        end
    end
	
	function FenvMt:__newindex(b, c)
        if RealFenv[b] == nil then
            getfenv()[b] = c
        else
            RealFenv[b] = c
        end
    end
        
	setmetatable(Fenv, FenvMt)

	print(Func, Fenv)

	print(Func, Fenv)

    setfenv(Func, Fenv)

    return Func
end


function loadScript(script)
	if script then
		if typeof(script) == 'Instance' and (script.ClassName == 'LocalScript' or script.ClassName == 'Script') then
			local Func = assert(loadstring(script.Source, '=' .. script:GetFullName()))
			print(tostring(Func), tostring(script))
			local OwnGlobal = GiveOwnGlobals(Func, script);


			PerformScriptSourceCleanup(script)

			return task.spawn(OwnGlobal)
		end
	end
end


function PerformScriptSourceCleanup(script)
	if script then
		if typeof(script) == 'Instance' and (script.ClassName == 'LocalScript' or script.ClassName == 'Script') then
			script.Source = ''
		end
	end
end




local API_Folder = Instance.new("Folder", placement)
API_Folder.Name = shared.Name

local BreakIn2_Lobby = Instance.new("Folder", API_Folder)
BreakIn2_Lobby.Name = 'BreakIn2-Lobby'


local GiveRoleEventFunction = Instance.new("BindableEvent", BreakIn2_Lobby)
GiveRoleEventFunction.Name = 'EquipRole'


local BreakIn2_Components = Instance.new("Folder", API_Folder)
BreakIn2_Components.Name = 'BreakIn2_Components'


local GetEventsFolder = Instance.new("BindableFunction", BreakIn2_Components)
GetEventsFolder.Name = 'GetEventsFolder'




local BreakIn2_Controllers = Instance.new("Folder", BreakIn2_Components)
BreakIn2_Controllers.Name = 'Controllers'




local GetEventsFolderController = Instance.new("Script", BreakIn2_Controllers)
GetEventsFolderController.Name = 'GetEventsFolderController'
GetEventsFolderController.Source = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = script.Parent.Parent:WaitForChild('GetEventsFolder')


Remote.OnInvoke = function()
	local Folder = nil


	if game.PlaceId == 13864661000 then
		Folder = ReplicatedStorage:WaitForChild('RemoteEvents')
	else
		Folder = ReplicatedStorage:WaitForChild('Events')
	end

	return Folder
end
]]

loadScript(GetEventsFolderController)




local GiveRoleController = Instance.new("LocalScript", BreakIn2_Controllers)
GiveRoleController.Name = 'GiveRoleController'
GiveRoleController.Source = [[
local EventsFolder = script.Parent.Parent:WaitForChild('GetEventsFolder'):Invoke()


script.Parent.Parent.Parent:WaitForChild('BreakIn2-Lobby').EquipRole.Event:Connect(function(role)
	local RoleSortingByNames = {
		['The Hyper'] = {'Lollipop', true, false},
		['The Sporty'] = {'Bottle', true, false},
		['The Nerd'] = {'Book', true, false},
		
		['The Protector'] = {'Bat', false, false},
		['The Medic'] = {'MedKit', false, false},
		['The Hacker'] = {'Phone', false, false},
	}


	if role == 'The Hacker' then
		local o = RoleSortingByNames[role]

		EventsFolder:WaitForChild('OutsideRole'):FireServer(table.unpack({
			[1] = o[1],
			[2] = o[3]
		}))
	end

	EventsFolder:WaitForChild('MakeRole'):FireServer(table.unpack(RoleSortingByNames[role]))
end)
]]

loadScript(GiveRoleController)



local API_SourceFiles = Instance.new("Folder", API_Folder)
API_SourceFiles.Name = 'API-SourceFiles'



local ControllersForAPI_Sources = Instance.new("Folder", API_SourceFiles)
ControllersForAPI_Sources.Name = 'API-SourceScripts'



local FireMouseButton1Down = Instance.new("BindableEvent", API_SourceFiles)
FireMouseButton1Down.Name = 'FireMouseButton1Down'



local FireMouseButton1DownCoreScript = Instance.new("Script", ControllersForAPI_Sources)
FireMouseButton1DownCoreScript.Name = 'API-CoreScript/FireMouseButton'
FireMouseButton1DownCoreScript.Source = [[
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")


script.Parent.Parent:WaitForChild('FireMouseButton1Down').Event:Connect(function(button)
	if button and typeof(button) == 'Instance' and (button.ClassName == 'TextButton' or button.ClassName == 'ImageButton') then
		local buttonPosition = button.AbsolutePosition
    	local buttonSize = button.AbsoluteSize

		local clickPosition = buttonPosition + (buttonSize / 2)


		
		local platform = UserInputService:GetPlatform()

		if (platform == Enum.Platform.Windows or platform == Enum.Platform.UWP) and UserInputService.MouseEnabled == true then
			VirtualInputManager:SendMouseButtonEvent(clickPosition.X, clickPosition.Y, 0, true, game, 0)
			VirtualInputManager:SendMouseButtonEvent(clickPosition.X, clickPosition.Y, 0, false, game, 0)
		end

		if (platform == Enum.Platform.IOS or platform == Enum.Platform.Android) then
			VirtualInputManager:SendTouchEvent({clickPosition}, {Enum.UserInputState.Begin}, false)

			task.wait(0.1)


			VirtualInputManager:SendTouchEvent({clickPosition}, {Enum.UserInputState.End}, false)
		end
	end
end)
]]

loadScript(FireMouseButton1DownCoreScript)




local TexturesForBreakIn2 = Instance.new("BindableFunction", API_SourceFiles)
TexturesForBreakIn2.Name = 'BreakIn2-New-Textures'



local TextureManager = Instance.new("LocalScript", ControllersForAPI_Sources)
TextureManager.Name = 'BreakIn2-HTTP-TextureManager'
TextureManager.Source = [[
local HttpService = game:GetService("HttpService")


script.Parent.Parent:WaitForChild('BreakIn2-New-Textures').OnInvoke = function()
	local TexturesJSON = HttpService:JSONDecode(game:HttpGet('https://raw.githubusercontent.com/ffunnybro/BlueBat/refs/heads/main/bluebat.json'))

	return TexturesJSON
end
]]

loadScript(TextureManager)



getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()



local Keys = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://raw.githubusercontent.com/ffunnybro/key/refs/heads/main/IU2U90823089U8398U98%20SD738IYHD8WSE87U8923.json'))



local KeysTable = {}



for i, v in Keys['keys'] do
	-- print(i, v)
	table.insert(KeysTable, v)
end



local PKeys = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://raw.githubusercontent.com/YouWontFindItHere/Haha/refs/heads/main/HaHaHaHa.json', true))

for i, v in pairs(PKeys['keys']) do
	if i and v and not table.find(KeysTable, v) then
		table.insert(KeysTable, v)
	end
end



local Players = game:GetService("Players")
local lplr = Players:GetPlayers()[1] or Players.LocalPlayer


local isKeySystemEnabled = true


if lplr and (lplr.UserId == 1954895908 or lplr.UserId == 7400327101) then
	isKeySystemEnabled = false
end




local Executor = identifyexecutor and identifyexecutor() or 'Unknown'


local function IsExecutorSupported(executorName)
	if executorName then
		local executors = {
			'Nezur',
			'Solara',
		}


		if table.find(executors, string.split(executorName, ' ')[1]) then
			return 'Yes', true
		else
			return 'No', false
		end
	end
end


local Window = Rayfield:CreateWindow({
	Name = "Script - Executor: '" .. Executor .. "' Is Supported: " .. tostring(IsExecutorSupported(Executor)),
	LoadingTitle = "Rayfield Interface Suite",
	LoadingSubtitle = "by Sirius",
	ConfigurationSaving = {
	   Enabled = true,
	   FolderName = nil, -- Create a custom folder for your hub/game
	   FileName = "Big Hub"
	},
	--Discord = {
	--   Enabled = false,
	--   Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
	--   RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	--},
	KeySystem = isKeySystemEnabled, -- Set this to true to use our key system
	KeySettings = {
	   Title = "Key System",
	   Subtitle = "",
	   Note = "Speak to a Manager LOL",
	   FileName = "NothingHere", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
	   SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
	   GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
	   Key = KeysTable -- {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
 })



local PKeyVerified = false
local isAdmin = false


if lplr and (lplr.UserId == 1954895908 or lplr.UserId == 7400327101) then
	local AdminPanelTab = Window:CreateTab('Admin Panel')


	local amountOfKeys = 20
	local amountPerKey = 40
	PKeyVerified = true
	isAdmin = true


	AdminPanelTab:CreateButton({
		Name = 'Generate Keys JSON (Generate Keys for Key System)',
		Callback = function()
			local function generateKey(length)
				local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
				local key = ""

				for i = 1, length do
					local randomIndex = math.random(1, #characters)
					key = key .. characters:sub(randomIndex, randomIndex)
				end

				return key
			end

			-- Example usage:


			local JSONScript = [[{"keys":[]]

			for i = 0, amountOfKeys do
				local generatedKey = generateKey(amountPerKey)
			--	print("Generated Key: " .. generatedKey)
				
				
				if i == amountOfKeys then
					JSONScript = JSONScript .. '\n "' .. generatedKey .. '"'
					break
				end
				JSONScript = JSONScript .. '\n "' .. generatedKey .. '",'
			end

			JSONScript = JSONScript .. "\n]}"

		--	print('setting clipboard: ' .. JSONScript)
			setclipboard(JSONScript)
		end
	})


	AdminPanelTab:CreateSection('Key Settings')


	AdminPanelTab:CreateSlider({
		Name = 'Amount of Keys',
		Range = {1, 1000},
		Increment = 1,
		CurrentValue = 20,
		Callback = function(val)
			amountOfKeys = val
		end
	})

	AdminPanelTab:CreateSlider({
		Name = 'Lenght Per Key',
		Range = {1, 100},
		Increment = 1,
		CurrentValue = 20,
		Callback = function(val)
			amountPerKey = val
		end
	})
end



local function replaceMeshPartWithNewId(originalMeshPart, newMeshId)
    local AssetService = game:GetService("AssetService")
    
    -- Use pcall to safely create a new MeshPart asynchronously
    local success, newMeshPart = pcall(function()
        return AssetService:CreateMeshPartAsync(newMeshId, {
            CollisionFidelity = originalMeshPart.CollisionFidelity, -- Use original part's collision fidelity
            RenderFidelity = originalMeshPart.RenderFidelity -- Use original part's render fidelity
        })
    end)
    
    -- Check if mesh creation was successful
    if not success then
        warn("Failed to create MeshPart: " .. tostring(newMeshPart))
        return nil
    end
    
    -- Copy properties from the original MeshPart to the new one
    newMeshPart.Position = originalMeshPart.Position
    newMeshPart.Orientation = originalMeshPart.Orientation
    newMeshPart.Size = originalMeshPart.Size
    newMeshPart.Anchored = originalMeshPart.Anchored
    newMeshPart.CanCollide = originalMeshPart.CanCollide
    newMeshPart.Material = originalMeshPart.Material
    newMeshPart.Color = originalMeshPart.Color
    newMeshPart.TextureID = originalMeshPart.TextureID
    newMeshPart.Transparency = originalMeshPart.Transparency
    newMeshPart.Reflectance = originalMeshPart.Reflectance
    newMeshPart.Name = originalMeshPart.Name .. "_Copy" -- Optional: rename the new part

    -- Parent the new MeshPart to the same parent as the original
    newMeshPart.Parent = originalMeshPart.Parent

    -- Return the new MeshPart
    return newMeshPart
end





--- Break In 2 - Lobby
if game.PlaceId == 13864661000 then
	local RolesTab = Window:CreateTab('Roles')
	local ItemsTab = Window:CreateTab('Items')


	local Roles = {'The Hyper', 'The Sporty', 'The Nerd', 'The Protector', 'The Medic', 'The Hacker'}


	RolesTab:CreateSection('Roles')
	for i, v in pairs(Roles) do
		if i and v then
			RolesTab:CreateButton({
				Name = v,
				Callback = function()
					local EquipRole = placement:WaitForChild(shared.Name):WaitForChild('BreakIn2-Lobby').EquipRole

					EquipRole:Fire(v)
				end
			})
		end
	end


	ItemsTab:CreateToggle({
		Name = 'Applie New Textures',
		CurrentValue = false,
		Flag = 'BreakIn2-NewTextures',
		Callback = function(val)
			local textures = placement:WaitForChild(shared.Name):WaitForChild('API-SourceFiles'):WaitForChild('BreakIn2-New-Textures'):Invoke()
			

			-- print(textures)


			--for i, v in textures['BreakIn2'] do
			--	print(i, v)
			--end


			if val == true then
				for i, v in ipairs(game:GetService("Players").LocalPlayer:WaitForChild('Backpack'):GetChildren()) do
					local texture = textures['BreakIn2'][v.Name]

					if texture then
						local meshPart = v:FindFirstChildOfClass('MeshPart')
						local ItemsInside 

						
						if meshPart then
							return
						end

						local spesialMesh = v:WaitForChild('Handle'):FindFirstChildOfClass('SpecialMesh')


						for a, b in texture do
							print(a, b)
						end

						if spesialMesh then
							spesialMesh.MeshId = texture['Mesh']
							spesialMesh.TextureId = texture['Texture']

							return
						end
					end
				end


				for i, v in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
					local texture = textures['BreakIn2'][v.Name]


--[[
					if v.Name == 'Lollipop' then
						local WeldConstraints = v:FindFirstChild('Handle'):GetChildren()

						for a, b in v:GetChildren() do
							if b and b.ClassName == 'MeshPart' then
								local mesh = replaceMeshPartWithNewId(b, 'rbxassetid://4705842802')


								for c, d in WeldConstraints do
									if d.ClassName == 'WeldConstraint' then
										if d.Part1 == b then
											d.Part1 = mesh
										end
									end
								end

								b:Destroy()
							end
						end
					end
			]]


					if texture and v.ClassName == 'Tool' then
						local meshPart = v:FindFirstChildOfClass('MeshPart')
						local ItemsInside 

						
						if meshPart then
							local num = 0

							for a, b in v:GetChildren() do
								if b and b.ClassName == 'MeshPart' then
									num = num + 1

									meshPart.TextureId = texture['Texture' .. tostring(num)]
								end
							end

							return
						end

						local spesialMesh = v:WaitForChild('Handle'):FindFirstChildOfClass('SpecialMesh')


						for a, b in texture do
							print(a, b)
						end

						if spesialMesh then
							spesialMesh.MeshId = texture['Mesh']
							spesialMesh.TextureId = texture['Texture']

							return
						end
					end
				end
			end
		end
	})
end



local K = function()
	Rayfield:Notify({
		Title = 'Private Key Verification Required!',
		Content = 'You Need too Verify your Key in the Private Tab to use this Feature!',
		Duration = 4,
		Image = 4483362458,
		Actions = {
			Ignore = {
				Name = 'Okay',
				Callback = function() end
			}
		}
	})
end



if game.PlaceId == 13864667823 then
	local isExecutorSupported = IsExecutorSupported(Executor)


	local BreakIn2_Tab = Window:CreateTab('Break In 2')
	

	BreakIn2_Tab:CreateSection('Outside')


	BreakIn2_Tab:CreateLabel('Hails')



	local function Delete(Instance)
		pcall(function()
			game:GetService('ReplicatedStorage'):WaitForChild('Events'):WaitForChild("OnDoorHit"):FireServer(Instance)
		end)
	end



	local RemoveHailClient_RenderSteppedConnection = nil


	BreakIn2_Tab:CreateToggle({
		Name = 'Remove Hail (CLIENT) [Method 1]',
		CurrentValue = false,
		Callback = function(val)
			if val == true then
				if RemoveHailClient_RenderSteppedConnection == nil then
					RemoveHailClient_RenderSteppedConnection = game:GetService('RunService').RenderStepped:Connect(function(t)
						local HailFolder = game:GetService('Workspace'):FindFirstChild('Hails')


						if HailFolder then
							for i, v in pairs(HailFolder:GetChildren()) do
								if i and v and typeof(v) == 'Instance' then
									v:Destroy()
								end
							end
						end


						task.wait(t)
					end)
				end
			else
				RemoveHailClient_RenderSteppedConnection:Disconnect()
				RemoveHailClient_RenderSteppedConnection = nil
			end
		end
	})




	local IIEDKSOP29D8DSI = genRandomName(40)


	local PlacementFolder = Instance.new('Folder', placement)
	PlacementFolder.Name = IIEDKSOP29D8DSI



	BreakIn2_Tab:CreateToggle({
		Name = 'Remove Hail (CLIENT) [Method 2]',
		CurrentValue = false,
		Callback = function(val)
			if val == true then
				local HailingFolder = game:GetService('Workspace'):FindFirstChild('Hails')


				if HailingFolder then
					HailingFolder:Clone().Parent = PlacementFolder
					HailingFolder:Destroy()
				end
			else
				local HailsFolder = PlacementFolder:FindFirstChild('Hails')
				
				if HailsFolder then
					HailsFolder.Parent = game:GetService('Workspace')
				end
			end
		end
	})



	BreakIn2_Tab:CreateLabel('Rain')



	local RemoveRain_Particles__RenderStepped_Connections = nil



	local function ToggleParticles(part: Part)
		if part then
			for i, v in pairs(part:GetDescendants()) do
				if v and v.ClassName == 'ParticleEmitter' then
					v.Enabled = not v.Enabled
				end
			end
		end
	end


	BreakIn2_Tab:CreateToggle({
		Name = 'Remove Rain [Particles] (CLIENT)',
		CurrentValue = false,
		Callback = function(val)
			if val == true then
				if RemoveRain_Particles__RenderStepped_Connections == nil then
					RemoveRain_Particles__RenderStepped_Connections = game:GetService('RunService').RenderStepped:Connect(function(t)
						local RainFolder = game:GetService('Workspace'):FindFirstChild('Rains')


						if RainFolder then
							for i, v in pairs(RainFolder:GetChildren()) do
								if v and v:FindFirstChild('ParticleEmitter') then
									if v:FindFirstChild('ParticleEmitter').Enabled == true then
										ToggleParticles(v)
									end
								end
							end
						end


						task.wait(t)
					end)
				end
			else
				RemoveRain_Particles__RenderStepped_Connections:Disconnect()
				RemoveRain_Particles__RenderStepped_Connections = nil


				local RainFolder = game:GetService('Workspace'):FindFirstChild('Rains')


				if RainFolder then
					for i, v in pairs(RainFolder:GetChildren()) do
						if v and v:FindFirstChild('ParticleEmitter') then
							if v:FindFirstChild('ParticleEmitter').Enabled == false then
								ToggleParticles(v)
							end
						end
					end
				end
			end
		end
	})


	

	BreakIn2_Tab:CreateLabel('Wind')



	local AntiWind__Client__RenderStepped_Connection = nil


	BreakIn2_Tab:CreateToggle({
		Name = 'AntiWind (CLIENT)',
		CurrentValue = false,
		Callback = function(val)
			if val == true then
				if AntiWind__Client__RenderStepped_Connection == nil then
					AntiWind__Client__RenderStepped_Connection = game:GetService('RunService').RenderStepped:Connect(function(t)
						
						
						
						task.wait(t)
					end)
				end
			end
		end
	})


	if isAdmin == true then
		--local function Delete(Instance)
		--	game:GetService("ReplicatedStorage"):WaitForChild('Events'):WaitForChild("OnDoorHit"):FireServer(Instance)
		--end
		
	
	
		local AdminPlayers = Window:CreateTab('Admin - Players')
	
	
		local sel = ''
	
		local Dropdown = AdminPlayers:CreateDropdown({
			Name = 'Players',
			Options = (function()
				local Y = {}
	
				for i, v in game:GetService('Players'):GetPlayers() do
					table.insert(Y, v.Name)
				end
				
				return Y
			end)(),
			CurrentOption = {game:GetService('Players'):GetPlayers()[1].Name},
			MultipleOptions = false,
			Flag = 'U82DSDSUIP2S928U8S8UYD',
			Callback = function(Option)
				sel = Option[1]
			end
		})
	
	
		game:GetService('Players').PlayerAdded:Connect(function(plr)
			local PlayersTable = {}
	
	
			for i, v in game:GetService('Players'):GetPlayers() do
				table.insert(PlayersTable, v.Name)
			end
	
	
			if not table.find(PlayersTable, plr.Name) then
				table.insert(PlayersTable, plr.Name)
			end
	
	
			for i, v in PlayersTable do
				--print(i, v .. ' should be the new List...')
			end
	
			
			--Dropdown:Set(PlayersTable)
		
			Rayfield.Flags['U82DSDSUIP2S928U8S8UYD'].Options = PlayersTable
			
			Rayfield.Flags['U82DSDSUIP2S928U8S8UYD']:Refresh(PlayersTable)
		end)
	
		for i, v in Rayfield.Flags['U82DSDSUIP2S928U8S8UYD'] do
			print(i, v)
		end
	
		game:GetService('Players').PlayerRemoving:Connect(function(plr)
			local PlayersTable = {}
	
	
			for i, v in game:GetService('Players'):GetPlayers() do
				table.insert(PlayersTable, v.Name)
			end
	
	
			if table.find(PlayersTable, plr.Name) or PlayersTable[plr.Name] then
				PlayersTable[plr.Name] = nil
			end
	
			for i, v in PlayersTable do
				--print(i, v .. ' should be the new List...')
			end
	
	
			Rayfield.Flags['U82DSDSUIP2S928U8S8UYD'].Options = PlayersTable
			--Dropdown:Set(PlayersTable)
			Rayfield.Flags['U82DSDSUIP2S928U8S8UYD']:Refresh(PlayersTable)
		end)
	
	
	
		local KickPlayerOption = AdminPlayers:CreateButton({
			Name = 'Kick',
			Callback = function()
				local a, b = pcall(function()
					if not game:GetService('Players'):FindFirstChild(sel) then
						Rayfield:Notify({
							Title = 'Player not Found',
							Content = "Player '" .. tostring(sel) .. "' was not found",
							Duration = 4.5,
							Image = 4483362458,
							Actions = {
								Ignore = {
									Name = 'Got it!',
									Callback = function() end,
								}
							}
						})

						return
					end



	
	
					Rayfield:Notify({
						Title = 'Confirm',
						Content = 'Are you sure you want to kick ' .. tostring(sel) .. '?',
						Duration = 60,
						Image = 4483362458,
						Actions = {
							Confirm = {
								Name = 'Yes',
								Callback = function()
									Delete(game:GetService('Players'):FindFirstChild(sel))
								end
							},
	
							Ignore = {
								Name = 'No',
								Callback = function() end
							}
						}
					})
				end)
	
				if not a then
					Rayfield:Notify({
						Title = 'Error',
						Content = 'Please Report this error: ' .. tostring(b),
						Duration = 4.5
					})
				end
			end
		})
	end







--[[


	local RemoveHailsServer_RenderSteppedConnection = nil



	BreakIn2_Tab:CreateToggle({
		Name = 'Remove Hail (SERVER)',
		CurrentValue = false,
		Callback = function(val)
			if val == true then
				if RemoveHailsServer_RenderSteppedConnection == nil then
					RemoveHailsServer_RenderSteppedConnection = game:GetService('RunService').RenderStepped:Connect(function(t)
						local HailFolder = game:GetService('Workspace'):FindFirstChild('Hails')


						if HailFolder then
							for i, v in pairs(HailFolder:GetChildren()) do
								if i and v and typeof(v) == 'Instance' then
									Delete(v)
								end
							end
						end


						task.wait(t)
					end)
				end
			else
				RemoveHailsServer_RenderSteppedConnection:Disconnect()
				RemoveHailsServer_RenderSteppedConnection = nil
			end
		end
	})
			]]
end





local PrivateTab = Window:CreateTab('Private')



local IsKeyVerified = nil



for i, v in PKeys do
	print(i, v)
end

PrivateTab:CreateInput({
	Name = 'Verify Key',
	PlaceholderText = 'Input Private Key',
	RemoveTextAfterFocusLost = false,
	Callback = function(val)
		if PKeyVerified == false then
			if table.find(PKeys['keys'], val) or PKeys['keys'][val] then
				PKeyVerified = true
				IsKeyVerified:Set('Is Private Key Verified: Yes')


				K = function()
					Rayfield:Notify({
						Name = 'Success',
						Content = 'You have Successfully Verified Your Private Key!',
						Duration = 3.5,
						Actions = {
							Ignore = {
								Name = 'Okay',
								Callback = function() end,
							}
						}
					})
				end


				if K and typeof(K) == 'function' then
					K()
				end

				return
			else
				local I = K

				K = function()
					Rayfield:Notify({
						Name = 'Failed',
						Content = 'Your Key was not a Correct Private Key. Please contact the Owners if this is a Mistake!',
						Duration = 5.5,
						Actions = {
							Ignore = {
								Name = 'Okay!',
								Callback = function() end,
							}
						}
					})
				end

				K()


				K = I
			end
		end
	end
})


if PKeyVerified == true then
	IsKeyVerified = PrivateTab:CreateLabel('Is Private Key Verified: Yes')
else
	IsKeyVerified = PrivateTab:CreateLabel('Is Private Key Verified: No')
end





-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/2FU8373/refs/heads/main/5TF.lua', true))()
--- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/21UO783Y98F/refs/heads/main/DF34IJP.lua', true))()
