-- Aurora GUI - Modern Glassmorphic Design
-- Full compatibility with both Add and New methods

local Aurora = {}
Aurora.__index = Aurora

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Color Schemes
local ColorSchemes = {
    Ocean = {
        Primary = Color3.fromRGB(0, 180, 255),
        Secondary = Color3.fromRGB(0, 100, 200),
        Accent = Color3.fromRGB(0, 220, 255),
        Background = Color3.fromRGB(10, 15, 25),
        Card = Color3.fromRGB(20, 30, 45),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 195, 215),
        Glow = Color3.fromRGB(0, 150, 255)
    },
    Lava = {
        Primary = Color3.fromRGB(255, 80, 0),
        Secondary = Color3.fromRGB(200, 40, 0),
        Accent = Color3.fromRGB(255, 150, 0),
        Background = Color3.fromRGB(20, 10, 10),
        Card = Color3.fromRGB(40, 20, 20),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(215, 180, 170),
        Glow = Color3.fromRGB(255, 100, 0)
    },
    Midnight = {
        Primary = Color3.fromRGB(150, 80, 255),
        Secondary = Color3.fromRGB(100, 40, 200),
        Accent = Color3.fromRGB(200, 100, 255),
        Background = Color3.fromRGB(10, 8, 18),
        Card = Color3.fromRGB(25, 20, 40),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(190, 180, 210),
        Glow = Color3.fromRGB(130, 60, 255)
    },
    Forest = {
        Primary = Color3.fromRGB(0, 220, 100),
        Secondary = Color3.fromRGB(0, 160, 60),
        Accent = Color3.fromRGB(80, 255, 150),
        Background = Color3.fromRGB(8, 20, 12),
        Card = Color3.fromRGB(18, 35, 25),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 215, 195),
        Glow = Color3.fromRGB(0, 200, 80)
    },
    Sakura = {
        Primary = Color3.fromRGB(255, 100, 180),
        Secondary = Color3.fromRGB(220, 50, 140),
        Accent = Color3.fromRGB(255, 150, 210),
        Background = Color3.fromRGB(20, 10, 18),
        Card = Color3.fromRGB(40, 20, 35),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(215, 180, 200),
        Glow = Color3.fromRGB(255, 80, 170)
    },
    Crystal = {
        Primary = Color3.fromRGB(100, 220, 255),
        Secondary = Color3.fromRGB(60, 180, 220),
        Accent = Color3.fromRGB(180, 240, 255),
        Background = Color3.fromRGB(8, 12, 22),
        Card = Color3.fromRGB(18, 28, 45),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 210, 230),
        Glow = Color3.fromRGB(80, 200, 255)
    }
}

-- Utility Functions
local function Tween(obj, props, duration)
    local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- Main Library
function Aurora:CreateLib(title, schemeName)
    local self = setmetatable({}, Aurora)
    self.Scheme = ColorSchemes[schemeName] or ColorSchemes.Ocean
    self.Tabs = {}
    self.CurrentTab = nil
    self.TabsData = {}
    
    -- Main ScreenGui
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "AuroraGUI"
    self.Gui.Parent = lp:WaitForChild("PlayerGui")
    self.Gui.ResetOnSpawn = false
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    self.Main = Instance.new("Frame")
    self.Main.Name = "Main"
    self.Main.Parent = self.Gui
    self.Main.Size = UDim2.new(0, 520, 0, 400)
    self.Main.Position = UDim2.new(0.5, -260, 0.5, -200)
    self.Main.BackgroundColor3 = self.Scheme.Background
    self.Main.BackgroundTransparency = 0.15
    self.Main.ClipsDescendants = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = self.Main
    
    -- Glass border
    local border = Instance.new("Frame")
    border.Name = "Border"
    border.Parent = self.Main
    border.Size = UDim2.new(1, 0, 1, 0)
    border.BackgroundTransparency = 1
    border.BorderSizePixel = 2
    border.BorderColor3 = self.Scheme.Primary
    border.BorderTransparency = 0.5
    border.ZIndex = 1
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 16)
    borderCorner.Parent = border
    
    -- Title Bar
    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.Parent = self.Main
    self.Header.Size = UDim2.new(1, 0, 0, 45)
    self.Header.BackgroundTransparency = 0.2
    self.Header.ClipsDescendants = true
    
    -- Title Bar Gradient
    local headerGrad = Instance.new("Frame")
    headerGrad.Name = "Gradient"
    headerGrad.Parent = self.Header
    headerGrad.Size = UDim2.new(1, 0, 1, 0)
    headerGrad.BackgroundColor3 = self.Scheme.Primary
    headerGrad.BackgroundTransparency = 0.85
    
    local headerGradCorner = Instance.new("UICorner")
    headerGradCorner.CornerRadius = UDim.new(0, 16)
    headerGradCorner.Parent = headerGrad
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = self.Header
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 18, 0, 0)
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "✦ " .. title
    titleLabel.TextColor3 = self.Scheme.Text
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Status dot
    local dot = Instance.new("Frame")
    dot.Parent = self.Header
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 8, 0.5, -4)
    dot.BackgroundColor3 = self.Scheme.Accent
    dot.BackgroundTransparency = 0.2
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Parent = self.Header
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -38, 0.5, -15)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 3
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, {BackgroundTransparency = 0.1}, 0.1)
    end)
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, {BackgroundTransparency = 0.3}, 0.1)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(self.Main, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, -0, 0.5, -0)}, 0.3)
        task.wait(0.3)
        self.Gui:Destroy()
    end)
    
    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Name = "Minimize"
    minBtn.Parent = self.Header
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -72, 0.5, -15)
    minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    minBtn.BackgroundTransparency = 0.3
    minBtn.Text = "─"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 18
    minBtn.Font = Enum.Font.GothamBold
    minBtn.ZIndex = 3
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn
    
    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(self.Main, {Size = UDim2.new(0, 520, 0, 45)}, 0.3)
            Tween(self.Main, {Position = UDim2.new(0.5, -260, 0.95, -22)}, 0.3)
        else
            Tween(self.Main, {Position = UDim2.new(0.5, -260, 0.5, -200)}, 0.3)
            Tween(self.Main, {Size = UDim2.new(0, 520, 0, 400)}, 0.3)
        end
    end)
    
    -- Draggable
    local dragData = {dragging = false, dragInput = nil, dragStart = nil, startPos = nil}
    
    self.Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragData.dragging = true
            dragData.dragStart = input.Position
            dragData.startPos = self.Main.Position
        end
    end)
    
    self.Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragData.dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragData.dragging and input == dragData.dragInput then
            local delta = input.Position - dragData.dragStart
            self.Main.Position = UDim2.new(
                dragData.startPos.X.Scale,
                dragData.startPos.X.Offset + delta.X,
                dragData.startPos.Y.Scale,
                dragData.startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragData.dragging = false
        end
    end)
    
    -- Tab Container (Left Side)
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Parent = self.Main
    self.TabContainer.Size = UDim2.new(0, 130, 1, -45)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 45)
    self.TabContainer.BackgroundTransparency = 0.1
    
    -- Tab Scroll
    self.TabList = Instance.new("ScrollingFrame")
    self.TabList.Name = "TabScroll"
    self.TabList.Parent = self.TabContainer
    self.TabList.Size = UDim2.new(1, 0, 1, 0)
    self.TabList.BackgroundTransparency = 1
    self.TabList.BorderSizePixel = 0
    self.TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.TabList.ScrollBarThickness = 2
    self.TabList.ScrollBarImageColor3 = self.Scheme.Primary
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.TabList
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Content Container (Right Side)
    self.Content = Instance.new("Frame")
    self.Content.Name = "Content"
    self.Content.Parent = self.Main
    self.Content.Size = UDim2.new(1, -140, 1, -55)
    self.Content.Position = UDim2.new(0, 135, 0, 50)
    self.Content.BackgroundTransparency = 1
    
    -- Content Scroll
    self.ContentScroll = Instance.new("ScrollingFrame")
    self.ContentScroll.Name = "ContentScroll"
    self.ContentScroll.Parent = self.Content
    self.ContentScroll.Size = UDim2.new(1, 0, 1, 0)
    self.ContentScroll.BackgroundTransparency = 1
    self.ContentScroll.BorderSizePixel = 0
    self.ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentScroll.ScrollBarThickness = 3
    self.ContentScroll.ScrollBarImageColor3 = self.Scheme.Primary
    self.ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = self.ContentScroll
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Auto-update canvas
    self.ContentScroll.ChildAdded:Connect(function()
        self:UpdateCanvas()
    end)
    self.ContentScroll.ChildRemoved:Connect(function()
        self:UpdateCanvas()
    end)
    
    -- Compatibility: store methods for New* support
    self._sectionCache = {}
    
    return self
end

function Aurora:UpdateCanvas()
    task.wait(0.1)
    local total = 0
    for _, child in ipairs(self.ContentScroll:GetChildren()) do
        if child:IsA("Frame") and child.Visible then
            local size = child.AbsoluteSize.Y
            if size > 0 then total = total + size + 8 end
        end
    end
    self.ContentScroll.CanvasSize = UDim2.new(0, 0, 0, math.max(total, self.ContentScroll.AbsoluteSize.Y + 10))
end

function Aurora:SelectTab(tabData)
    for _, tab in ipairs(self.TabsData) do
        if tab.Content then
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = self.Scheme.Card
            tab.Button.BackgroundTransparency = 0.5
            tab.Button.TextColor3 = self.Scheme.SubText
        end
    end
    
    tabData.Content.Visible = true
    tabData.Button.BackgroundColor3 = self.Scheme.Primary
    tabData.Button.BackgroundTransparency = 0.3
    tabData.Button.TextColor3 = self.Scheme.Text
    self.CurrentTab = tabData
    
    self:UpdateCanvas()
end

function Aurora:AddTab(name)
    local tabData = {
        Name = name,
        Sections = {},
        Content = nil,
        Button = nil
    }
    
    -- Tab Button
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = self.TabList
    btn.Size = UDim2.new(0.9, 0, 0, 36)
    btn.Position = UDim2.new(0.05, 0, 0, 0)
    btn.BackgroundColor3 = self.Scheme.Card
    btn.BackgroundTransparency = 0.5
    btn.Text = name
    btn.TextColor3 = self.Scheme.SubText
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.ZIndex = 2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Tab Content
    local content = Instance.new("Frame")
    content.Name = name .. "_Content"
    content.Parent = self.ContentScroll
    content.Size = UDim2.new(1, -5, 0, 0)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.AutomaticSize = Enum.AutomaticSize.Y
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = content
    contentLayout.Padding = UDim.new(0, 6)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    tabData.Content = content
    tabData.Button = btn
    
    -- Switch tab
    btn.MouseButton1Click:Connect(function()
        self:SelectTab(tabData)
    end)
    
    table.insert(self.TabsData, tabData)
    
    -- Update tab list size
    self.TabList.CanvasSize = UDim2.new(0, 0, 0, #self.TabsData * 42 + 10)
    
    -- Select first tab
    if #self.TabsData == 1 then
        self:SelectTab(tabData)
    end
    
    local methods = {}
    
    function methods:AddSection(name)
        local section = Instance.new("Frame")
        section.Name = name .. "_Section"
        section.Parent = content
        section.Size = UDim2.new(1, 0, 0, 0)
        section.BackgroundColor3 = self.Scheme.Card
        section.BackgroundTransparency = 0.15
        section.AutomaticSize = Enum.AutomaticSize.Y
        section.ClipsDescendants = true
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 10)
        sectionCorner.Parent = section
        
        -- Glow line at top
        local line = Instance.new("Frame")
        line.Name = "Line"
        line.Parent = section
        line.Size = UDim2.new(1, 0, 0, 2)
        line.BackgroundColor3 = self.Scheme.Primary
        line.BackgroundTransparency = 0.5
        
        local lineCorner = Instance.new("UICorner")
        lineCorner.CornerRadius = UDim.new(0, 2)
        lineCorner.Parent = line
        
        -- Section Title
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Parent = section
        titleLabel.Size = UDim2.new(1, -20, 0, 32)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = name
        titleLabel.TextColor3 = self.Scheme.Text
        titleLabel.TextSize = 15
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Section Content
        local sectionContent = Instance.new("Frame")
        sectionContent.Name = "Content"
        sectionContent.Parent = section
        sectionContent.Size = UDim2.new(1, 0, 0, 0)
        sectionContent.Position = UDim2.new(0, 0, 0, 35)
        sectionContent.BackgroundTransparency = 1
        sectionContent.AutomaticSize = Enum.AutomaticSize.Y
        
        local sectionList = Instance.new("UIListLayout")
        sectionList.Parent = sectionContent
        sectionList.Padding = UDim.new(0, 4)
        sectionList.SortOrder = Enum.SortOrder.LayoutOrder
        
        local sectionMethods = {}
        
        -- Add Toggle
        function sectionMethods:AddToggle(name, description, callback)
            local frame = Instance.new("Frame")
            frame.Name = name .. "_Toggle"
            frame.Parent = sectionContent
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundTransparency = 1
            
            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Position = UDim2.new(0, 8, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = name
            label.TextColor3 = self.Scheme.Text
            label.TextSize = 13
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                frame.Size = UDim2.new(1, 0, 0, 50)
                local desc = Instance.new("TextLabel")
                desc.Parent = frame
                desc.Size = UDim2.new(0.7, 0, 0, 14)
                desc.Position = UDim2.new(0, 8, 0, 24)
                desc.BackgroundTransparency = 1
                desc.Text = description
                desc.TextColor3 = self.Scheme.SubText
                desc.TextSize = 10
                desc.Font = Enum.Font.Gotham
                desc.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            local toggle = Instance.new("Frame")
            toggle.Parent = frame
            toggle.Size = UDim2.new(0, 44, 0, 24)
            toggle.Position = UDim2.new(1, -52, 0.5, -12)
            toggle.BackgroundColor3 = self.Scheme.Card
            toggle.BackgroundTransparency = 0.3
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 12)
            toggleCorner.Parent = toggle
            
            local dot = Instance.new("Frame")
            dot.Parent = toggle
            dot.Size = UDim2.new(0, 20, 0, 20)
            dot.Position = UDim2.new(0, 2, 0, 2)
            dot.BackgroundColor3 = self.Scheme.SubText
            
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(0, 10)
            dotCorner.Parent = dot
            
            local state = false
            
            local function updateToggle()
                if state then
                    Tween(toggle, {BackgroundColor3 = self.Scheme.Primary, BackgroundTransparency = 0.2}, 0.15)
                    Tween(dot, {Position = UDim2.new(0, 22, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                else
                    Tween(toggle, {BackgroundColor3 = self.Scheme.Card, BackgroundTransparency = 0.3}, 0.15)
                    Tween(dot, {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = self.Scheme.SubText}, 0.15)
                end
            end
            
            toggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    state = not state
                    updateToggle()
                    if callback then callback(state) end
                end
            end)
            
            return toggle
        end
        
        -- Add Button
        function sectionMethods:AddButton(name, description, callback)
            local btn = Instance.new("TextButton")
            btn.Name = name
            btn.Parent = sectionContent
            btn.Size = UDim2.new(1, -10, 0, 36)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.BackgroundColor3 = self.Scheme.Card
            btn.BackgroundTransparency = 0.2
            btn.Text = name
            btn.TextColor3 = self.Scheme.Text
            btn.TextSize = 13
            btn.Font = Enum.Font.GothamSemibold
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = btn
            
            btn.MouseEnter:Connect(function()
                Tween(btn, {BackgroundTransparency = 0.05}, 0.1)
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, {BackgroundTransparency = 0.2}, 0.1)
            end)
            
            btn.MouseButton1Click:Connect(callback)
            return btn
        end
        
        -- Add Slider
        function sectionMethods:AddSlider(name, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Name = name .. "_Slider"
            frame.Parent = sectionContent
            frame.Size = UDim2.new(1, 0, 0, 48)
            frame.BackgroundTransparency = 1
            
            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.Size = UDim2.new(0.7, 0, 0, 20)
            label.Position = UDim2.new(0, 8, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = name
            label.TextColor3 = self.Scheme.Text
            label.TextSize = 13
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Parent = frame
            valueLabel.Size = UDim2.new(0.2, 0, 0, 20)
            valueLabel.Position = UDim2.new(0.8, 0, 0, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(default)
            valueLabel.TextColor3 = self.Scheme.Accent
            valueLabel.TextSize = 13
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            local bar = Instance.new("Frame")
            bar.Parent = frame
            bar.Size = UDim2.new(0.9, 0, 0, 4)
            bar.Position = UDim2.new(0.05, 0, 0, 32)
            bar.BackgroundColor3 = self.Scheme.Card
            
            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(0, 2)
            barCorner.Parent = bar
            
            local fill = Instance.new("Frame")
            fill.Parent = bar
            fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            fill.BackgroundColor3 = self.Scheme.Primary
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 2)
            fillCorner.Parent = fill
            
            local current = default
            local dragging = false
            
            local function updateSlider(posX)
                local percent = math.clamp((posX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                current = math.round(min + (max - min) * percent)
                valueLabel.Text = tostring(current)
                fill.Size = UDim2.new(percent, 0, 1, 0)
                if callback then callback(current) end
            end
            
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateSlider(input.Position.X)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position.X)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            return frame
        end
        
        -- Add Dropdown (simplified)
        function sectionMethods:AddDropdown(name, options, defaultOption, callback)
            local selected = defaultOption or (options and options[1]) or "Select"
            local open = false
            
            local frame = Instance.new("Frame")
            frame.Name = name .. "_Dropdown"
            frame.Parent = sectionContent
            frame.Size = UDim2.new(1, 0, 0, 36)
            frame.BackgroundTransparency = 1
            frame.ClipsDescendants = true
            
            local btn = Instance.new("TextButton")
            btn.Parent = frame
            btn.Size = UDim2.new(1, -10, 0, 36)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.BackgroundColor3 = self.Scheme.Card
            btn.BackgroundTransparency = 0.2
            btn.Text = name .. ": " .. tostring(selected)
            btn.TextColor3 = self.Scheme.Text
            btn.TextSize = 13
            btn.Font = Enum.Font.Gotham
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.PaddingLeft = UDim.new(0, 10)
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = btn
            
            local arrow = Instance.new("TextLabel")
            arrow.Parent = btn
            arrow.Size = UDim2.new(0, 20, 0, 20)
            arrow.Position = UDim2.new(1, -28, 0.5, -10)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▾"
            arrow.TextColor3 = self.Scheme.SubText
            arrow.Font = Enum.Font.Gotham
            arrow.TextSize = 12
            
            local optionsFrame = Instance.new("Frame")
            optionsFrame.Parent = frame
            optionsFrame.Size = UDim2.new(1, -10, 0, 0)
            optionsFrame.Position = UDim2.new(0, 5, 0, 40)
            optionsFrame.BackgroundColor3 = self.Scheme.Card
            optionsFrame.BackgroundTransparency = 0.3
            optionsFrame.Visible = false
            optionsFrame.AutomaticSize = Enum.AutomaticSize.Y
            optionsFrame.ClipsDescendants = true
            
            local optionsCorner = Instance.new("UICorner")
            optionsCorner.CornerRadius = UDim.new(0, 8)
            optionsCorner.Parent = optionsFrame
            
            local optionsList = Instance.new("UIListLayout")
            optionsList.Parent = optionsFrame
            optionsList.Padding = UDim.new(0, 2)
            optionsList.SortOrder = Enum.SortOrder.LayoutOrder
            
            local function updateOptions()
                for _, child in ipairs(optionsFrame:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                
                for _, opt in ipairs(options) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Parent = optionsFrame
                    optBtn.Size = UDim2.new(1, 0, 0, 28)
                    optBtn.BackgroundTransparency = 0.8
                    optBtn.Text = tostring(opt)
                    optBtn.TextColor3 = self.Scheme.Text
                    optBtn.TextSize = 12
                    optBtn.Font = Enum.Font.Gotham
                    
                    optBtn.MouseButton1Click:Connect(function()
                        selected = opt
                        btn.Text = name .. ": " .. tostring(selected)
                        open = false
                        optionsFrame.Visible = false
                        Tween(frame, {Size = UDim2.new(1, 0, 0, 36)}, 0.2)
                        if callback then callback(opt) end
                    end)
                    
                    optBtn.MouseEnter:Connect(function()
                        Tween(optBtn, {BackgroundTransparency = 0.5}, 0.1)
                    end)
                    optBtn.MouseLeave:Connect(function()
                        Tween(optBtn, {BackgroundTransparency = 0.8}, 0.1)
                    end)
                end
            end
            
            updateOptions()
            
            btn.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    optionsFrame.Visible = true
                    Tween(frame, {Size = UDim2.new(1, 0, 0, 36 + optionsList.AbsoluteContentSize.Y + 10)}, 0.2)
                else
                    Tween(frame, {Size = UDim2.new(1, 0, 0, 36)}, 0.2)
                    task.wait(0.2)
                    optionsFrame.Visible = false
                end
            end)
            
            return frame
        end
        
        -- ============================================================
        -- COMPATIBILITY METHODS (NewToggle, NewButton, NewSlider, NewSection)
        -- These just call the Add methods so your main script works!
        -- ============================================================
        
        function sectionMethods:NewSection(name)
            return self:AddSection(name)
        end
        
        function sectionMethods:NewToggle(name, description, callback)
            return self:AddToggle(name, description, callback)
        end
        
        function sectionMethods:NewButton(name, description, callback)
            return self:AddButton(name, description, callback)
        end
        
        function sectionMethods:NewSlider(name, min, max, default, callback)
            return self:AddSlider(name, min, max, default, callback)
        end
        
        function sectionMethods:NewDropdown(name, options, defaultOption, callback)
            return self:AddDropdown(name, options, defaultOption, callback)
        end
        
        return sectionMethods
    end
    
    -- Also add compatibility methods at tab level
    function methods:NewSection(name)
        return self:AddSection(name)
    end
    
    return methods
end

-- Global compatibility for the main script
function Aurora:NewTab(name)
    return self:AddTab(name)
end

function Aurora:ToggleUI()
    self.Gui.Enabled = not self.Gui.Enabled
end

return Aurora
