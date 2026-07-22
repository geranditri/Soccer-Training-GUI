local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. ScreenGui Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SoccerTrainingGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. Frame Utama
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 185)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

-- 3. Judul GUI ("Soccer Training")
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -30, 0, 25)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Soccer Training"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- 4. Tombol Close (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.Parent = mainFrame

-- ----------------------------------------------------
-- VIEW 1: HALAMAN UTAMA (AUTO TRAINING)
-- ----------------------------------------------------
local mainView = Instance.new("Frame")
mainView.Name = "MainView"
mainView.Size = UDim2.new(1, 0, 1, -45)
mainView.Position = UDim2.new(0, 0, 0, 30)
mainView.BackgroundTransparency = 1
mainView.Visible = true
mainView.Parent = mainFrame

local subTitleLabel = Instance.new("TextLabel")
subTitleLabel.Name = "SubTitleLabel"
subTitleLabel.Size = UDim2.new(1, -20, 0, 18)
subTitleLabel.Position = UDim2.new(0, 10, 0, 0)
subTitleLabel.BackgroundTransparency = 1
subTitleLabel.Text = "Auto Training"
subTitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subTitleLabel.Font = Enum.Font.SourceSans
subTitleLabel.TextSize = 14
subTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subTitleLabel.Parent = mainView

local trainButton = Instance.new("TextButton")
trainButton.Name = "TrainButton"
trainButton.Size = UDim2.new(0, 200, 0, 30)
trainButton.Position = UDim2.new(0, 10, 0, 22)
trainButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
trainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
trainButton.Text = "Status: OFF"
trainButton.Font = Enum.Font.SourceSansBold
trainButton.TextSize = 13
trainButton.Parent = mainView

local trainCorner = Instance.new("UICorner")
trainCorner.CornerRadius = UDim.new(0, 6)
trainCorner.Parent = trainButton

local openHatchMenuBtn = Instance.new("TextButton")
openHatchMenuBtn.Name = "OpenHatchMenuBtn"
openHatchMenuBtn.Size = UDim2.new(0, 200, 0, 30)
openHatchMenuBtn.Position = UDim2.new(0, 10, 0, 60)
openHatchMenuBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 150)
openHatchMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openHatchMenuBtn.Text = "🥚 Hatch Egg Menu"
openHatchMenuBtn.Font = Enum.Font.SourceSansBold
openHatchMenuBtn.TextSize = 13
openHatchMenuBtn.Parent = mainView

local openHatchCorner = Instance.new("UICorner")
openHatchCorner.CornerRadius = UDim.new(0, 6)
openHatchCorner.Parent = openHatchMenuBtn

-- ----------------------------------------------------
-- VIEW 2: HALAMAN SUB-MENU (HATCH EGG)
-- ----------------------------------------------------
local hatchView = Instance.new("Frame")
hatchView.Name = "HatchView"
hatchView.Size = UDim2.new(1, 0, 1, -45)
hatchView.Position = UDim2.new(0, 0, 0, 30)
hatchView.BackgroundTransparency = 1
hatchView.Visible = false
hatchView.Parent = mainFrame

local backButton = Instance.new("TextButton")
backButton.Name = "BackButton"
backButton.Size = UDim2.new(0, 200, 0, 22)
backButton.Position = UDim2.new(0, 10, 0, 0)
backButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.Text = "⬅️ Kembali ke Menu"
backButton.Font = Enum.Font.SourceSansBold
backButton.TextSize = 12
backButton.Parent = hatchView

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 4)
backCorner.Parent = backButton

-- SCROLLING FRAME UNTUK DAFTAR TELUR
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "EggScrollFrame"
scrollFrame.Size = UDim2.new(0, 200, 0, 105)
scrollFrame.Position = UDim2.new(0, 10, 0, 26)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
scrollFrame.Parent = hatchView

-- Layout Otomatis
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 4)

-- DATA DAFTAR TELUR (6 Telur Baru ditaruh di Atas)
local eggData = {
	{ ID = "Basic", Name = "Basic Egg", Label = "Basic (75)" },
	{ ID = "Dragon", Name = "Dragon Egg", Label = "Dragon (3 K)" },
	{ ID = "Bee", Name = "Bee Egg", Label = "Bee (200 K)" },
	{ ID = "Desert", Name = "Desert Egg", Label = "Desert (75 M)" },
	{ ID = "Pyramid", Name = "Pyramid Egg", Label = "Pyramid (20 B)" },
	{ ID = "Cactus", Name = "Cactus Egg", Label = "Cactus (1 T)" },
	-- 3 Telur Sebelumnya:
	{ ID = "Mystic", Name = "Mystic Egg", Label = "Mystic (1 Qd)" },
	{ ID = "WorldCup", Name = "World Cup Egg", Label = "World Cup (750 Qd)" },
	{ ID = "Dice", Name = "Dice Egg", Label = "Dice (150 Qn)" },
}

local eggButtons = {}
local selectedEggID = nil 

for i, data in ipairs(eggData) do
	local btn = Instance.new("TextButton")
	btn.Name = data.ID .. "Button"
	btn.Size = UDim2.new(1, -8, 0, 26)
	btn.LayoutOrder = i
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Text = data.Label .. ": OFF"
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = scrollFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = btn

	eggButtons[data.ID] = { Button = btn, Data = data }
end

-- Otomatis Menyesuaikan Panjang Area Scroll
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end)

-- Watermark Footer
local footerLabel = Instance.new("TextLabel")
footerLabel.Name = "FooterLabel"
footerLabel.Size = UDim2.new(1, 0, 0, 16)
footerLabel.Position = UDim2.new(0, 0, 1, -18)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "Made by Trouble Maker"
footerLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
footerLabel.Font = Enum.Font.SourceSansItalic
footerLabel.TextSize = 11
footerLabel.Parent = mainFrame

-- ====================================================
-- REFERENSI REMOTE EVENT
-- ====================================================
local knitServices = ReplicatedStorage:WaitForChild("Library")
	:WaitForChild("Knit")
	:WaitForChild("Services")

local trainEvent = knitServices:WaitForChild("TrainingService")
	:WaitForChild("RE")
	:WaitForChild("Train")

local hatchEvent = knitServices:WaitForChild("EggsService")
	:WaitForChild("RE")
	:WaitForChild("HatchEgg")

-- ====================================================
-- LOGIKA PERPINDAHAN TAMPILAN SUB-MENU
-- ====================================================
openHatchMenuBtn.MouseButton1Click:Connect(function()
	mainView.Visible = false
	hatchView.Visible = true
end)

backButton.MouseButton1Click:Connect(function()
	hatchView.Visible = false
	mainView.Visible = true
end)

-- ====================================================
-- LOGIKA AUTO TRAINING (5x Eksekusi per 0.1 Detik)
-- ====================================================
local isTraining = false

trainButton.MouseButton1Click:Connect(function()
	isTraining = not isTraining
	if isTraining then
		trainButton.Text = "Status: ON"
		trainButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		task.spawn(function()
			while isTraining do
				-- Eksekusi perintah 3 kali secara langsung
				for i = 1, 5 do
					trainEvent:FireServer()
				end
				-- Beri delay 0.1 detik setelah 3 kali eksekusi
				task.wait(0.1)
			end
		end)
	else
		trainButton.Text = "Status: OFF"
		trainButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	end
end)

-- ====================================================
-- LOGIKA SINGLE SELECTION (HATCH EGG)
-- ====================================================
local function selectEgg(targetID)
	if selectedEggID == targetID then
		selectedEggID = nil
		local item = eggButtons[targetID]
		item.Button.Text = item.Data.Label .. ": OFF"
		item.Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		return
	end

	selectedEggID = targetID

	for id, item in pairs(eggButtons) do
		if id == selectedEggID then
			item.Button.Text = item.Data.Label .. ": ON"
			item.Button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		else
			item.Button.Text = item.Data.Label .. ": OFF"
			item.Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end

	task.spawn(function()
		local currentActiveID = selectedEggID
		local eggName = eggButtons[currentActiveID].Data.Name
		
		while selectedEggID == currentActiveID do
			hatchEvent:FireServer(eggName, "Triple")
			task.wait(0.1)
		end
	end)
end

for id, item in pairs(eggButtons) do
	item.Button.MouseButton1Click:Connect(function()
		selectEgg(id)
	end)
end

-- ====================================================
-- LOGIKA TOMBOL CLOSE (X)
-- ====================================================
closeButton.MouseButton1Click:Connect(function()
	isTraining = false
	selectedEggID = nil
	screenGui:Destroy()
end)

-- ====================================================
-- SISTEM DRAGGABLE
-- ====================================================
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
