# Development-Environment
An open-source utility you can copy and paste to the top of your next script to save yourself some time.

Use this for Roblox studio, or for cheats; we support both.
# Docs
## Variables
### Services
```lua
-- In this example we can see how Services is a shortcut to any Roblox service
print(Services.Players.LocalPlayer)
```
```lua
-- Predefined Services
Players
Workspace
ReplicatedStorage
TweenService
RunService
```
### LocalPlayer
```lua
-- LocalPlayer, Character, Humanoid, and RootPart are predefined
print(LocalPlayer)
print(Character)
print(Humanoid)
print(RootPart)
```
```lua
print(Camera) -- Workspace.CurrentCamera shortcut
print(Mouse) -- LocalPlayer:GetMouse() shortcut
```
## Optimization
### Replaced Functions
```lua
wait == task.wait
spawn == task.spawn
pcall == xpcall
```
## Premade Functions
### GetClosestPlayer
Returns the closest player to LocalPlayer
```lua
print(GetClosestPlayer(true, true, true))
```
```lua
GetClosestPlayer(
  true, -- health check, if a player's health is equal to 0 then they won't be accounted for
  true, -- forcefield check, if a player's character has a forcefield they won't be accounted for
  true -- teamcheck, if a player's on the same team as LocalPlayer they won't be accounted for
)
```
### GetRandomPlayer
Returns a random player (excluding LocalPlayer)
```lua
print(GetRandomPlayer())
```
