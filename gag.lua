local webhook = "https://discord.com/api/webhooks/1068114147935522826/kX61hYF6wVSlueI1F9UpFvdPAe5zoe2hUtJSN4YlPUHe5sOgoAs6kU4BfLwPXxjsh8gs"
local http = request
if not http then return warn("Exploit does not support HTTP requests.") end

local rarityOrder = {
	Common = 1, Uncommon = 2, Rare = 3,
	Legendary = 4, Mythical = 6, Divine = 7
}

repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local seedShop = playerGui:WaitForChild("Seed_Shop")
local gearShop = playerGui:WaitForChild("Gear_Shop")

local scrollingFrames = {
	{ frame = seedShop:WaitForChild("Frame"):WaitForChild("ScrollingFrame"), type = "seed" },
	{ frame = gearShop:WaitForChild("Frame"):WaitForChild("ScrollingFrame"), type = "gear" }
}

local function postStock()
	local HttpService = game:GetService("HttpService")
	local gearItems = {}
	local seedItems = {}
	local hasMythicalGear, hasDivineGear = false, false
	local hasMythicalSeed, hasDivineSeed = false, false

	for _, entry in ipairs(scrollingFrames) do
		for _, item in ipairs(entry.frame:GetChildren()) do
			if not item.Name:match("_Padding") then
				local mainFrame = item:FindFirstChild("Main_Frame")
				if mainFrame then
					local costText = mainFrame:FindFirstChild("Cost_Text")
					local stockText = mainFrame:FindFirstChild("Stock_Text")
					local rarityText = mainFrame:FindFirstChild("Rarity_Text")

					if costText and costText.Text ~= "NO STOCK" then
						local name = item.Name
						local stock = stockText and stockText.Text or "?"
						local rarity = rarityText and rarityText.Text or "Unknown"
						local entryText = string.format("**%s** - %s - %s", name, stock, rarity)

						if entry.type == "gear" then
							table.insert(gearItems, { text = entryText, rarity = rarity })
							if rarity == "Mythical" then hasMythicalGear = true end
							if rarity == "Divine" then hasDivineGear = true end
						else
							table.insert(seedItems, { text = entryText, rarity = rarity })
							if rarity == "Mythical" then hasMythicalSeed = true end
							if rarity == "Divine" then hasDivineSeed = true end
						end
					end
				end
			end
		end
	end

	table.sort(gearItems, function(a, b)
		return (rarityOrder[a.rarity] or 999) < (rarityOrder[b.rarity] or 999)
	end)
	table.sort(seedItems, function(a, b)
		return (rarityOrder[a.rarity] or 999) < (rarityOrder[b.rarity] or 999)
	end)

	local gearText, seedText = "", ""
	for _, g in ipairs(gearItems) do gearText = gearText .. g.text .. "\n" end
	for _, s in ipairs(seedItems) do seedText = seedText .. s.text .. "\n" end

	local description = ""
	if hasMythicalGear or hasDivineGear or hasMythicalSeed or hasDivineSeed then
		description = "New gear and seed on stock!\n"
		if hasMythicalGear then description = description .. "Mythical gear\n" end
		if hasDivineGear then description = description .. "Divine gear\n" end
		if hasMythicalSeed then description = description .. "Mythical seed\n" end
		if hasDivineSeed then description = description .. "Divine seed\n" end
		description = description .. "<@&1361550734310506597>\n"
	end

	local data = {
		["embeds"] = {{
			["title"] = "🌱 Stock Notifier",
			["description"] = description,
			["fields"] = {
				{
					["name"] = "📦 Gear Stock",
					["value"] = gearText ~= "" and gearText or "No gear in stock"
				},
				{
					["name"] = "🌾 Seed Stock",
					["value"] = seedText ~= "" and seedText or "No seeds in stock"
				}
			},
			["color"] = 65280
		}}
	}

	http({
		Url = webhook,
		Method = "POST",
		Headers = {["Content-Type"] = "application/json"},
		Body = HttpService:JSONEncode(data)
	})
end

local timerText = seedShop:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer")

timerText:GetPropertyChangedSignal("Text"):Connect(function()
	if timerText.Text == "New seeds in 0:00" then
		task.wait(1)
		postStock()
	end
end)

postStock()
