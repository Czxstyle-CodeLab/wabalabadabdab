-- ╔══════════════════════════════════════════════════════╗
-- ║           MINI GUI — Main Controller                 ║
-- ╚══════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Загружаем модули
local TrailsModule = loadstring(game:HttpGet("URL_TO_TRAILS_MODULE"))()
local ChinaHatModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Czxstyle-CodeLab/wabalabadabdab/refs/heads/main/ChinaHatModule"))()
local JumpCirclesModule = loadstring(game:HttpGet("URL_TO_JUMPCIRCLES_MODULE"))()

-- Создаем GUI
local sg = Instance.new("ScreenGui")
sg.Name = "MiniGUI"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset = true
pcall(function() sg.Parent = game.CoreGui end)

-- Фон
local bg = Instance.new("Frame", sg)
bg.Size = UDim2.new(0, 280, 0, 200)
bg.Position = UDim2.new(0.5, -140, 0.5, -100)
bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bg.BorderSizePixel = 0
bg.ZIndex = 2
Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 20)

local stroke = Instance.new("UIStroke", bg)
stroke.Color = Color3.fromRGB(200, 200, 200)
stroke.Thickness = 2

-- Заголовок
local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "⚡ MINI Visuals"
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center

-- Подзаголовок
local sub = Instance.new("TextLabel", bg)
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 45)
sub.BackgroundTransparency = 1
sub.Text = "Визуальные эффекты"
sub.TextColor3 = Color3.fromRGB(120, 120, 120)
sub.TextSize = 12
sub.Font = Enum.Font.Gotham
sub.TextXAlignment = Enum.TextXAlignment.Center

-- Функция создания кнопки
local function createButton(name, module, yPos)
    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0, 240, 0, 40)
    btn.Position = UDim2.new(0.5, -120, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Text = name .. " — OFF"
    btn.TextColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(220, 220, 220)
    btnStroke.Thickness = 1.5

    local enabled = false

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end)

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.Text = name .. " — ON"
            btn.TextColor3 = Color3.fromRGB(0, 180, 0)
            btnStroke.Color = Color3.fromRGB(0, 200, 0)
            module.Enable()
        else
            btn.Text = name .. " — OFF"
            btn.TextColor3 = Color3.fromRGB(80, 80, 80)
            btnStroke.Color = Color3.fromRGB(220, 220, 220)
            module.Disable()
        end
    end)

    return btn
end

-- Создаем 3 кнопки
createButton("Trails", TrailsModule, 75)
createButton("China Hat", ChinaHatModule, 125)
createButton("Jump Circles", JumpCirclesModule, 175)

-- Drag система
local dragging = false
local dragStart, startPos
bg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = bg.Position
    end
end)
bg.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        bg.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
bg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
