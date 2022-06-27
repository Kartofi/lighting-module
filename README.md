# lighting-module
A module that generates lightning bolts ⚡

## Usage 👀

```lua
local module = require(game.ReplicatedStorage.modules.Lighting)
while wait(1) do
	module.Create(game.Workspace.part1.Position , game.Workspace.part2.Position, 20, Enum.Material.Neon, Color3.new(0, 1, 0.933333))
end

```
