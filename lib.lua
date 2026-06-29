-- Custom GUI Library - Made for Pilgrammed
-- With NewToggle/NewButton/NewSlider/NewSection compatibility

local CustomUI = {}
CustomUI.__index = CustomUI

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

-- Create GUI
function CustomUI:CreateLib(title, theme)
    local self = setmetatable({}, CustomUI)
    self.Title = title
    self.Theme = theme or "Dark"
    self.Tabs = {}
    self.CurrentTab = nil
    self.Buttons = {}
    
    -- Create ScreenGui
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "CustomUI"
    self.Gui.Parent = lp:WaitForChild("PlayerGui")
    self.Gui.ResetOnSpawn = false
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 550, 0, 450)
    self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.Gui
    
    -- Main Corner
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = self.MainFrame
    
    -- Shadow effect
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 0, 1, 0)
    shadow.Position = UDim2.new(0, 3, 0, 3)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.5
    shadow.ZIndex = -1
    shadow.Parent = self.MainFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadow
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    titleBar.Parent = self.MainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -38, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        self.Gui.Enabled = false
    end)
    
    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 32, 0, 32)
    minBtn.Position = UDim2.new(1, -75, 0, 6)
    minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    minBtn.Text = "─"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 20
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = titleBar
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn
    
    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            self.MainFrame:TweenSize(UDim2.new(0, 550, 0, 45), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        else
            self.MainFrame:TweenSize(UDim2.new(0, 550, 0, 450), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        end
    end)
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(0, 130, 1, -45)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 45)
    self.TabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    self.TabContainer.Parent = self.MainFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 0)
    tabCorner.Parent = self.TabContainer
    
    -- Tab Scrolling Frame
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, 0, 1, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.ScrollBarThickness = 3
    tabScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
    tabScroll.Parent = self.TabContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabScroll
    
    self.TabList = tabScroll
    self.TabLayout = tabLayout
    
    -- Content Container
    self.ContentContainer = Instance.new("ScrollingFrame")
    self.ContentContainer.Size = UDim2.new(1, -130, 1, -45)
    self.ContentContainer.Position = UDim2.new(0, 130, 0, 45)
    self.ContentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    self.ContentContainer.BorderSizePixel = 0
    self.ContentContainer.Parent = self.MainFrame
    self.ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentContainer.ScrollBarThickness = 4
    self.ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 0)
    contentCorner.Parent = self.ContentContainer
    
    -- Draggable
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            self.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Auto-update canvas
    self.ContentContainer.ChildAdded:Connect(function()
        self:UpdateCanvas()
    end)
    
    self.ContentContainer.ChildRemoved:Connect(function()
        self:UpdateCanvas()
    end)
    
    return self
end

-- Update Canvas
function CustomUI:UpdateCanvas()
    task.wait(0.1)
    local totalHeight = 0
    for _, child in ipairs(self.ContentContainer:GetChildren()) do
        if child:IsA("Frame") and child.Visible then
            local size = child.AbsoluteSize.Y
            if size > 0 then
                totalHeight = totalHeight + size + 10
            end
        end
    end
    self.ContentContainer.CanvasSize = UDim2.new(0, 0, 0, math.max(totalHeight, self.ContentContainer.AbsoluteSize.Y + 10))
end

-- Add Tab
function CustomUI:AddTab(name)
    local tabData = {
        Name = name,
        Sections = {},
        Content = nil,
        Button = nil
    }
    
    -- Create tab button
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabBtn.Position = UDim2.new(0.05, 0, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabBtn.BackgroundTransparency = 0.3
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabBtn.TextSize = 13
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.Parent = self.TabList
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn
    
    -- Tab Content Frame
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -10, 1, 0)
    content.Position = UDim2.new(0, 5, 0, 0)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Parent = self.ContentContainer
    
    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 8)
    contentList.Parent = content
    
    tabData.Content = content
    tabData.Button = tabBtn
    
    -- Tab switching
    tabBtn.MouseButton1Click:Connect(function()
        self:SelectTab(tabData)
    end)
    
    table.insert(self.Tabs, tabData)
    
    -- Update tab list size
    self.TabList.CanvasSize = UDim2.new(0, 0, 0, #self.Tabs * 45 + 10)
    
    -- Select first tab
    if #self.Tabs == 1 then
        self:SelectTab(tabData)
    end
    
    return tabData
end

-- Select Tab
function CustomUI:SelectTab(tabData)
    for _, tab in ipairs(self.Tabs) do
        if tab.Content then
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            tab.Button.TextColor3 = Color3.fromRGB(180, 180, 200)
        end
    end
    
    tabData.Content.Visible = true
    tabData.Button.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    tabData.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CurrentTab = tabData
    
    self:UpdateCanvas()
end

-- ============================================================
-- MAIN METHODS (AddSection, AddToggle, AddButton, AddSlider)
-- ============================================================

-- Add Section to Tab
function CustomUI:AddSection(tab, name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    section.BackgroundTransparency = 0.2
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.Parent = tab.Content
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    -- Section Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(180, 180, 210)
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.PaddingLeft = UDim.new(0, 10)
    title.Parent = section
    
    local sectionData = {
        Frame = section,
        Name = name,
        Elements = {}
    }
    
    table.insert(tab.Sections, sectionData)
    
    return sectionData
end

-- Add Toggle
function CustomUI:AddToggle(section, name, desc, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.Position = UDim2.new(0, 5, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    frame.BackgroundTransparency = 0.3
    frame.AutomaticSize = Enum.AutomaticSize.None
    frame.Parent = section.Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(210, 210, 220)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 44, 0, 24)
    toggleBtn.Position = UDim2.new(1, -50, 0, 5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleBtn
    
    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    toggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleIndicator.Parent = toggleBtn
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 10)
    indicatorCorner.Parent = toggleIndicator
    
    local toggled = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
            toggleIndicator.Position = UDim2.new(0, 22, 0, 2)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
            toggleIndicator.Position = UDim2.new(0, 2, 0, 2)
        end
        callback(toggled)
    end)
    
    return toggleBtn
end

-- Add Button
function CustomUI:AddButton(section, name, desc, callback)
    local frame = Instance.new("TextButton")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.Position = UDim2.new(0, 5, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    frame.BackgroundTransparency = 0.3
    frame.Text = name
    frame.TextColor3 = Color3.fromRGB(210, 210, 220)
    frame.TextSize = 13
    frame.Font = Enum.Font.GothamSemibold
    frame.Parent = section.Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    frame.MouseButton1Click:Connect(callback)
    
    frame.MouseEnter:Connect(function()
        frame.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    end)
    frame.MouseLeave:Connect(function()
        frame.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    end)
    
    return frame
end

-- Add Slider
function CustomUI:AddSlider(section, name, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.Position = UDim2.new(0, 5, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    frame.BackgroundTransparency = 0.3
    frame.Parent = section.Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(210, 210, 220)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.2, 0, 0, 20)
    valueLabel.Position = UDim2.new(0.8, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    valueLabel.TextSize = 13
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.9, 0, 0, 4)
    slider.Position = UDim2.new(0.05, 0, 0, 34)
    slider.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    slider.Parent = frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 2)
    sliderCorner.Parent = slider
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
    sliderFill.Parent = slider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = sliderFill
    
    local currentValue = default
    local dragging = false
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
        currentValue = math.round(min + (max - min) * pos)
        valueLabel.Text = tostring(currentValue)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        callback(currentValue)
    end
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return slider
end

-- ============================================================
-- COMPATIBILITY METHODS (NewToggle, NewButton, NewSlider, NewSection)
-- These just call the Add methods so your main script works!
-- ============================================================

function CustomUI:NewSection(tab, name)
    return self:AddSection(tab, name)
end

function CustomUI:NewToggle(section, name, desc, callback)
    return self:AddToggle(section, name, desc, callback)
end

function CustomUI:NewButton(section, name, desc, callback)
    return self:AddButton(section, name, desc, callback)
end

function CustomUI:NewSlider(section, name, min, max, default, callback)
    return self:AddSlider(section, name, min, max, default, callback)
end

-- Toggle UI function
function CustomUI:ToggleUI()
    self.Gui.Enabled = not self.Gui.Enabled
end

return CustomUI
