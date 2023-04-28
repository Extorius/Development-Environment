if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Services = {}
Services = setmetatable({}, {
	__index = function(self, index)
		return game:GetService(index) -- Easily get services without having to list all of them manually
	end
})

-- Ensuring the game load's entirely before doing anything (prevents bugs)

repeat
	task.wait(0.5)
until Services.Players and Services.Workspace and Services.ReplicatedStorage and Services.TweenService

local Players, Workspace, ReplicatedStorage, TweenService, RunService = Services.Players, Services.Workspace, Services.ReplicatedStorage, Services.TweenService, Services.RunService -- Shortens common services even more
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local RootPart = Humanoid.RootPart or Character:WaitForChild('HumanoidRootPart')

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = Character:WaitForChild('Humanoid')
    RootPart = Humanoid.RootPart or Character:WaitForChild('HumanoidRootPart')
end)

local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

wait = task.wait -- Automatically optimize scripts by replacing slow / deprecated functions with their faster / working alternatives
spawn = task.spawn
pcall = xpcall

-- Commonly used functions

local function Raycast(point1, point2)
    local Direction = point2 - point1
    local Result = Workspace:Raycast(point1, Direction)

    if Result then
        return Result
    else
        return nil
    end
end

local function GetClosestPlayer(health, forcefield, team)
    health = health or false
    forcefield = forcefield or false
    team = team or false

    local Closest = nil
    local Lowest = math.huge

    for i,v in next, Players:GetPlayers() do
        if v ~= LocalPlayer then
            pcall(function()
                local PlrCharacter = v.Character
                local PlrRoot = PlrCharacter:FindFirstChild('HumanoidRootPart')
                local PlrHum = PlrCharacter:FindFirstChild('Humanoid')
                local Mag = (RootPart - PlrRoot).Magnitude

                local CanContinue = true

                if health and PlrHum.Health == 0 then
                    CanContinue = false
                end

                if forcefield and PlrCharacter:FindFirstChildOfClass('ForceField') then
                    CanContinue = false
                end

                if team and v.Team == LocalPlayer.Team then
                    CanContinue = false
                end

                if CanContinue and Mag < Lowest then
                    Lowest = Mag
                    Closest = v
                end
            end)
        end
    end

    return Closest, Lowest
end

local function GetRandomPlayer()
    local Players = {}
    table.foreach(Players:GetPlayers(), function(i, v)
        if v ~= LocalPlayer then
            table.insert(Players, v)
        end
    end)

    return Players[math.random(1, #Players)]
end
