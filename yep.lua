-- create GUI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local runButton = Instance.new("TextButton")
local stopButton = Instance.new("TextButton")

screenGui.Name = "GalaxySpawnerGUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

frame.Name = "Frame"
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, -75, 0.5, -25)
frame.Size = UDim2.new(0, 150, 0, 50)

runButton.Name = "RunButton"
runButton.Parent = frame
runButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
runButton.BorderSizePixel = 0
runButton.Position = UDim2.new(0.05, 0, 0.2, 0)
runButton.Size = UDim2.new(0.4, 0, 0.6, 0)
runButton.Font = Enum.Font.SourceSans
runButton.Text = "Run (G)"
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.TextSize = 20
runButton.AutoButtonColor = false

stopButton.Name = "StopButton"
stopButton.Parent = frame
stopButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
stopButton.BorderSizePixel = 0
stopButton.Position = UDim2.new(0.55, 0, 0.2, 0)
stopButton.Size = UDim2.new(0.4, 0, 0.6, 0)
stopButton.Font = Enum.Font.SourceSans
stopButton.Text = "Stop (B)"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextSize = 20
stopButton.AutoButtonColor = false

-- set initial state of run variable
local run = false

-- define functions for button click events
local function onRunButtonClicked()
    run = true
    runButton.Text = "Running (G)"
end

local function onStopButtonClicked()
    run = false
    runButton.Text = "Run (G)"
end

-- connect button click events to functions
runButton.MouseButton1Click:Connect(onRunButtonClicked)
stopButton.MouseButton1Click:Connect(onStopButtonClicked)

-- define function to spawn galaxy block
local spawnEvent = Instance.new("BindableEvent")

spawnEvent.Event:Connect(function()
    game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
end)

-- define input handling function
local input = game:GetService("UserInputService")

input.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.G and not run then
        onRunButtonClicked()
    elseif key.KeyCode == Enum.KeyCode.B and run then
        onStopButtonClicked()
    elseif key.KeyCode == Enum.KeyCode.T then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- main loop
while true do
    wait()
    if run then
        spawnEvent:Fire()
    end
end
