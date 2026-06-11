--[[
    GenesisV2 - Biblioteca UI híbrida
    API: GenesisX (métodos de criação, layout left/right, ícones remotos)
    Base: redzlib (sistema de flags, diálogos, redimensionamento, salvamento)
    Ícones: carregados dinamicamente do repositório da GenesisX
    Tema padrão: Roxo (GenesisX Accent)
]]

local GenesisV2 = {}
GenesisV2.__index = GenesisV2

-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ==============================
--        ÍCONES REMOTOS
-- ==============================
local IconAssets = {}
pcall(function()
    local raw = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/mainloadergg/Library/refs/heads/main/Icons.lua"
    ))()
    if raw and raw.assets then
        IconAssets = raw.assets
    end
end)

function GenesisV2:GetIcon(iconName)
    if type(iconName) ~= "string" then return iconName end
    if iconName:find("rbxassetid://") then return iconName end
    return IconAssets[iconName] or iconName
end

-- ==============================
--        TEMAS (roxo)
-- ==============================
GenesisV2.Themes = {
    Dark = {
        Background = Color3.fromRGB(8, 8, 8),
        Header = Color3.fromRGB(12, 12, 12),
        Sidebar = Color3.fromRGB(10, 10, 10),
        Card = Color3.fromRGB(16, 16, 16),
        CardHover = Color3.fromRGB(24, 24, 24),
        Input = Color3.fromRGB(22, 22, 22),
        InputHover = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(150, 80, 230),      -- roxo principal
        AccentHover = Color3.fromRGB(180, 110, 255),
        AccentSecondary = Color3.fromRGB(210, 160, 255),
        AccentDark = Color3.fromRGB(90, 40, 160),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(120, 120, 120),
        Success = Color3.fromRGB(220, 190, 255),
        Warning = Color3.fromRGB(190, 130, 255),
        Info = Color3.fromRGB(140, 90, 220),
        Error = Color3.fromRGB(80, 40, 140),
        Border = Color3.fromRGB(40, 35, 50),
        BorderBright = Color3.fromRGB(75, 65, 90),
        ToggleOff = Color3.fromRGB(35, 30, 45),
        ToggleOn = Color3.fromRGB(150, 80, 230),
    },
    Light = {
        Background = Color3.fromRGB(245, 242, 250),
        Header = Color3.fromRGB(235, 232, 242),
        Sidebar = Color3.fromRGB(240, 237, 247),
        Card = Color3.fromRGB(255, 255, 255),
        CardHover = Color3.fromRGB(248, 245, 252),
        Input = Color3.fromRGB(235, 232, 242),
        InputHover = Color3.fromRGB(225, 220, 235),
        Accent = Color3.fromRGB(130, 60, 210),
        AccentHover = Color3.fromRGB(150, 80, 230),
        AccentSecondary = Color3.fromRGB(100, 40, 180),
        AccentDark = Color3.fromRGB(80, 30, 160),
        Text = Color3.fromRGB(30, 30, 35),
        TextSecondary = Color3.fromRGB(80, 75, 90),
        TextMuted = Color3.fromRGB(130, 125, 140),
        Success = Color3.fromRGB(100, 60, 180),
        Warning = Color3.fromRGB(140, 90, 40),
        Info = Color3.fromRGB(100, 60, 180),
        Error = Color3.fromRGB(160, 40, 60),
        Border = Color3.fromRGB(210, 205, 220),
        BorderBright = Color3.fromRGB(180, 175, 195),
        ToggleOff = Color3.fromRGB(200, 195, 210),
        ToggleOn = Color3.fromRGB(130, 60, 210),
    }
}
GenesisV2.Theme = GenesisV2.Themes.Dark

-- ==============================
--       CONFIGURAÇÕES
-- ==============================
GenesisV2.Config = {
    AnimationSpeed = 0.2,
    CornerRadius = 8,
    ShadowEnabled = true,
    ShadowIntensity = 0.7,
}

-- ==============================
--    SISTEMA DE FLAGS (redzlib)
-- ==============================
GenesisV2.Flags = {}
GenesisV2.Settings = { ScriptFile = nil }

local function SaveFlags()
    if not GenesisV2.Settings.ScriptFile then return end
    if not writefile then return end
    pcall(function()
        writefile(GenesisV2.Settings.ScriptFile, HttpService:JSONEncode(GenesisV2.Flags))
    end)
end

function GenesisV2:SetFlag(name, value)
    GenesisV2.Flags[name] = value
    SaveFlags()
    if self._flagChanged then self:_flagChanged(name, value) end
end

function GenesisV2:GetFlag(name)
    return GenesisV2.Flags[name]
end

-- ==============================
--        UTILITÁRIOS
-- ==============================
function GenesisV2:Tween(obj, props, time, style, direction)
    if not obj or not obj.Parent then return nil end
    local tweenInfo = TweenInfo.new(
        time or self.Config.AnimationSpeed,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

function GenesisV2:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, self.Config.CornerRadius)
    corner.Parent = parent
    return corner
end

function GenesisV2:CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or self.Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function GenesisV2:CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1 or Color3.new(1,1,1), color2 or Color3.new(0,0,0))
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

function GenesisV2:MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ==============================
--        CRIAÇÃO DE JANELA
-- ==============================
function GenesisV2:CreateWindow(config)
    config = config or {}
    local window = setmetatable({}, self)
    
    -- Carregar flags salvos (se existir)
    if config.SaveFolder and type(config.SaveFolder) == "string" then
        self.Settings.ScriptFile = config.SaveFolder
        pcall(function()
            if isfile(config.SaveFolder) then
                local data = HttpService:JSONDecode(readfile(config.SaveFolder))
                if type(data) == "table" then
                    for k,v in pairs(data) do
                        self.Flags[k] = v
                    end
                end
            end
        end)
    end
    
    -- Tema inicial
    local themeName = config.Theme or "Dark"
    self.Theme = (themeName == "Light" and self.Themes.Light) or self.Themes.Dark
    
    -- Criar ScreenGui
    if PlayerGui:FindFirstChild("GenesisV2") then
        PlayerGui.GenesisV2:Destroy()
    end
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "GenesisV2"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.ScreenGui.IgnoreGuiInset = true
    pcall(function() self.ScreenGui.Parent = CoreGui end)
    if not self.ScreenGui.Parent then
        self.ScreenGui.Parent = PlayerGui
    end
    
    -- Dimensões responsivas
    local scaleFactor = 1
    local function updateScale()
        local camera = workspace.CurrentCamera
        if camera then
            local viewport = camera.ViewportSize
            scaleFactor = math.clamp(math.min(viewport.X/1920, viewport.Y/1080), 0.7, 1.1)
        end
    end
    updateScale()
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateScale)
    
    local function S(value)
        if type(value) == "number" then
            return math.floor(value * scaleFactor)
        elseif typeof(value) == "UDim2" then
            return UDim2.new(value.X.Scale, math.floor(value.X.Offset * scaleFactor),
                            value.Y.Scale, math.floor(value.Y.Offset * scaleFactor))
        end
        return value
    end
    
    window.S = S
    
    -- Frame principal
    local windowWidth = S(700)
    local windowHeight = S(460)
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.MainFrame.Position = config.Position or UDim2.new(0.5, 0, 0.5, 0)
    self.MainFrame.Size = config.Size or UDim2.new(0, windowWidth, 0, windowHeight)
    self.MainFrame.Active = true
    self.MainFrame.Parent = self.ScreenGui
    self:CreateCorner(self.MainFrame, UDim.new(0, 12))
    self:CreateStroke(self.MainFrame, self.Theme.Accent, 1.5, 0)
    
    -- Header
    local headerHeight = S(56)
    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.BackgroundColor3 = self.Theme.Header
    self.Header.BorderSizePixel = 0
    self.Header.Size = UDim2.new(1, 0, 0, headerHeight)
    self.Header.Parent = self.MainFrame
    self:CreateCorner(self.Header, UDim.new(0, 10))
    
    -- Título e ícone
    local iconX = S(16)
    local iconAsset = self:GetIcon(config.Icon or "lucide-genesis-hub")
    if iconAsset and iconAsset:find("rbxassetid://") then
        local iconImg = Instance.new("ImageLabel")
        iconImg.BackgroundTransparency = 1
        iconImg.Position = UDim2.new(0, iconX, 0.5, -S(16))
        iconImg.Size = UDim2.new(0, S(32), 0, S(32))
        iconImg.Image = iconAsset
        iconImg.Parent = self.Header
    else
        local iconBg = Instance.new("Frame")
        iconBg.BackgroundColor3 = self.Theme.Accent
        iconBg.Position = UDim2.new(0, iconX, 0.5, -S(15))
        iconBg.Size = UDim2.new(0, S(30), 0, S(30))
        iconBg.Parent = self.Header
        self:CreateCorner(iconBg, UDim.new(0, 6))
        local iconLabel = Instance.new("TextLabel")
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = Enum.Font.GothamBlack
        iconLabel.Text = config.IconText or "G"
        iconLabel.TextColor3 = Color3.new(1,1,1)
        iconLabel.TextSize = S(16)
        iconLabel.Parent = iconBg
    end
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, iconX + S(44), 0, 0)
    titleLabel.Size = UDim2.new(0, S(300), 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = config.Title or "GenesisV2"
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = S(18)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = self.Header
    
    if config.Subtitle then
        local sub = Instance.new("TextLabel")
        sub.BackgroundTransparency = 1
        sub.Position = UDim2.new(0, iconX + S(44), 0, S(28))
        sub.Size = UDim2.new(0, S(300), 0, S(16))
        sub.Font = Enum.Font.Gotham
        sub.Text = config.Subtitle
        sub.TextColor3 = self.Theme.TextMuted
        sub.TextSize = S(10)
        sub.TextXAlignment = Enum.TextXAlignment.Left
        sub.Parent = self.Header
    end
    
    -- Botões do header (minimizar, fechar, tema)
    local btnSize = S(32)
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.BackgroundColor3 = self.Theme.Input
    closeBtn.Position = UDim2.new(1, -S(14) - btnSize, 0.5, -btnSize/2)
    closeBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    closeBtn.Image = self:GetIcon("lucide-x")
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = self.Header
    self:CreateCorner(closeBtn, UDim.new(0, 6))
    closeBtn.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)
    
    local minimizeBtn = Instance.new("ImageButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.BackgroundColor3 = self.Theme.Input
    minimizeBtn.Position = UDim2.new(1, -S(14)*2 - btnSize*2, 0.5, -btnSize/2)
    minimizeBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    minimizeBtn.Image = self:GetIcon("lucide-minus")
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Parent = self.Header
    self:CreateCorner(minimizeBtn, UDim.new(0, 6))
    local minimized = false
    local originalSize = self.MainFrame.Size
    minimizeBtn.MouseButton1Click:Connect(function()
        if minimized then
            self.MainFrame.Size = originalSize
            minimized = false
        else
            originalSize = self.MainFrame.Size
            self.MainFrame.Size = UDim2.new(0, windowWidth, 0, headerHeight + S(10))
            minimized = true
        end
    end)
    
    -- Sidebar
    local sidebarWidth = S(64)
    local sidebarWrap = Instance.new("Frame")
    sidebarWrap.Name = "SidebarWrap"
    sidebarWrap.BackgroundColor3 = self.Theme.Sidebar
    sidebarWrap.BorderSizePixel = 0
    sidebarWrap.Position = UDim2.new(0, 0, 0, headerHeight + 2)
    sidebarWrap.Size = UDim2.new(0, sidebarWidth, 1, -(headerHeight + 2))
    sidebarWrap.ClipsDescendants = true
    sidebarWrap.Parent = self.MainFrame
    self:CreateCorner(sidebarWrap, UDim.new(0, 10))
    
    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.BackgroundTransparency = 1
    self.Sidebar.Size = UDim2.new(1, 0, 1, 0)
    self.Sidebar.ScrollBarThickness = 2
    self.Sidebar.CanvasSize = UDim2.new(0,0,0,0)
    self.Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Sidebar.Parent = sidebarWrap
    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, S(8))
    sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sidebarLayout.Parent = self.Sidebar
    sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Sidebar.CanvasSize = UDim2.new(0,0,0, sidebarLayout.AbsoluteContentSize.Y + S(24))
    end)
    
    -- Content area (Left + Right)
    local contentX = sidebarWidth + S(10)
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.Position = UDim2.new(0, contentX, 0, headerHeight + S(10))
    self.ContentArea.Size = UDim2.new(1, -(contentX + S(14)), 1, -(headerHeight + S(20)))
    self.ContentArea.ClipsDescendants = true
    self.ContentArea.Parent = self.MainFrame
    
    window.Tabs = {}
    window.CurrentTab = nil
    window:MakeDraggable(self.MainFrame, self.Header)
    
    -- ==============================
    --        CREATE TAB
    -- ==============================
    function window:CreateTab(tabConfig)
        local name = tabConfig.Name or "Tab"
        local icon = self:GetIcon(tabConfig.Icon) or ""
        local btnSize = self.S(46)
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = name.."Btn"
        tabBtn.BackgroundColor3 = self.Theme.Card
        tabBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
        tabBtn.Text = ""
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = self.Sidebar
        self:CreateCorner(tabBtn, UDim.new(0, 10))
        
        if icon and icon:find("rbxassetid://") then
            local iconImg = Instance.new("ImageLabel")
            iconImg.BackgroundTransparency = 1
            iconImg.AnchorPoint = Vector2.new(0.5,0.5)
            iconImg.Position = UDim2.new(0.5,0,0.5,0)
            iconImg.Size = UDim2.new(0, self.S(24), 0, self.S(24))
            iconImg.Image = icon
            iconImg.ImageColor3 = self.Theme.TextMuted
            iconImg.Parent = tabBtn
        else
            local fallback = name:sub(1,1)
            local iconLabel = Instance.new("TextLabel")
            iconLabel.BackgroundTransparency = 1
            iconLabel.Size = UDim2.new(1,0,1,0)
            iconLabel.Font = Enum.Font.GothamBold
            iconLabel.Text = fallback
            iconLabel.TextColor3 = self.Theme.TextMuted
            iconLabel.TextSize = self.S(16)
            iconLabel.Parent = tabBtn
        end
        
        -- Tooltip
        local tooltip = Instance.new("TextLabel")
        tooltip.BackgroundColor3 = self.Theme.Card
        tooltip.Position = UDim2.new(1, self.S(10), 0.5, -self.S(11))
        tooltip.Size = UDim2.new(0,0,0, self.S(22))
        tooltip.AutomaticSize = Enum.AutomaticSize.X
        tooltip.Font = Enum.Font.GothamSemibold
        tooltip.Text = "  "..name.."  "
        tooltip.TextColor3 = self.Theme.Text
        tooltip.TextSize = self.S(11)
        tooltip.Visible = false
        tooltip.Parent = tabBtn
        self:CreateCorner(tooltip, UDim.new(0,5))
        
        tabBtn.MouseEnter:Connect(function()
            if self.CurrentTab ~= name then
                self:Tween(tabBtn, {BackgroundColor3 = self.Theme.CardHover}, 0.15)
            end
            tooltip.Visible = true
        end)
        tabBtn.MouseLeave:Connect(function()
            if self.CurrentTab ~= name then
                self:Tween(tabBtn, {BackgroundColor3 = self.Theme.Card}, 0.15)
            end
            tooltip.Visible = false
        end)
        
        -- Page container
        local page = Instance.new("Frame")
        page.Name = name.."Page"
        page.BackgroundTransparency = 1
        page.Size = UDim2.new(1,0,1,0)
        page.Visible = false
        page.Parent = self.ContentArea
        
        -- Background card
        local bgCard = Instance.new("Frame")
        bgCard.BackgroundColor3 = self.Theme.Background
        bgCard.Size = UDim2.new(1,0,1,0)
        bgCard.Parent = page
        self:CreateCorner(bgCard, UDim.new(0,8))
        
        -- Left and Right scroll frames
        local function createColumn(side)
            local scroll = Instance.new("ScrollingFrame")
            scroll.BackgroundTransparency = 1
            scroll.Size = UDim2.new(0.49, 0, 1, 0)
            scroll.Position = (side == "left") and UDim2.new(0,0,0,0) or UDim2.new(0.51,0,0,0)
            scroll.ScrollBarThickness = 3
            scroll.ScrollBarImageColor3 = self.Theme.Accent
            scroll.CanvasSize = UDim2.new(0,0,0,0)
            scroll.ScrollingDirection = Enum.ScrollingDirection.Y
            scroll.Parent = page
            self:CreateCorner(scroll, UDim.new(0,8))
            
            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, self.S(8))
            layout.Parent = scroll
            
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, self.S(8))
            padding.PaddingRight = UDim.new(0, self.S(8))
            padding.PaddingBottom = UDim.new(0, self.S(10))
            padding.Parent = scroll
            
            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                scroll.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + self.S(20))
            end)
            return scroll
        end
        
        local leftCol = createColumn("left")
        local rightCol = createColumn("right")
        
        local tabData = { Button = tabBtn, Container = page, Left = leftCol, Right = rightCol, Name = name }
        self.Tabs[name] = tabData
        
        tabBtn.MouseButton1Click:Connect(function()
            self:SelectTab(name)
        end)
        
        if not self.CurrentTab then
            self:SelectTab(name)
        end
        
        return tabData
    end
    
    -- ==============================
    --        SELECT TAB
    -- ==============================
    function window:SelectTab(tabName)
        if self.CurrentTab == tabName then return end
        local old = self.CurrentTab and self.Tabs[self.CurrentTab]
        local new = self.Tabs[tabName]
        if not new then return end
        if old and old.Container then old.Container.Visible = false end
        new.Container.Visible = true
        for id, data in pairs(self.Tabs) do
            local icon = data.Button:FindFirstChild("Icon")
            if id == tabName then
                self:Tween(data.Button, {BackgroundColor3 = self.Theme.Accent}, 0.2)
                if icon then
                    if icon:IsA("ImageLabel") then
                        self:Tween(icon, {ImageColor3 = Color3.new(1,1,1)}, 0.2)
                    elseif icon:IsA("TextLabel") then
                        self:Tween(icon, {TextColor3 = Color3.new(1,1,1)}, 0.2)
                    end
                end
            else
                self:Tween(data.Button, {BackgroundColor3 = self.Theme.Card}, 0.2)
                if icon then
                    if icon:IsA("ImageLabel") then
                        self:Tween(icon, {ImageColor3 = self.Theme.TextMuted}, 0.2)
                    elseif icon:IsA("TextLabel") then
                        self:Tween(icon, {TextColor3 = self.Theme.TextMuted}, 0.2)
                    end
                end
            end
        end
        self.CurrentTab = tabName
    end
    
    -- ==============================
    --        CREATE SECTION
    -- ==============================
    function window:CreateSection(parent, text, color, icon)
        color = color or self.Theme.Accent
        local iconSize = self.S(16)
        local height = self.S(28)
        local wrap = Instance.new("Frame")
        wrap.BackgroundTransparency = 1
        wrap.Size = UDim2.new(1, 0, 0, height)
        wrap.Parent = parent
        
        local line = Instance.new("Frame")
        line.BackgroundColor3 = self.Theme.Accent
        line.BackgroundTransparency = 0.7
        line.BorderSizePixel = 0
        line.Position = UDim2.new(0, 0, 0.5, 0)
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Parent = wrap
        
        local labelBg = Instance.new("Frame")
        labelBg.BackgroundColor3 = self.Theme.Background
        labelBg.BorderSizePixel = 0
        labelBg.AutomaticSize = Enum.AutomaticSize.X
        labelBg.Position = UDim2.new(0, self.S(6), 0, 0)
        labelBg.Size = UDim2.new(0, 0, 1, 0)
        labelBg.Parent = wrap
        
        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.Padding = UDim.new(0, self.S(5))
        layout.Parent = labelBg
        
        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, self.S(4))
        pad.PaddingRight = UDim.new(0, self.S(6))
        pad.Parent = labelBg
        
        if icon then
            local iconAsset = self:GetIcon(icon)
            if iconAsset and iconAsset:find("rbxassetid://") then
                local img = Instance.new("ImageLabel")
                img.BackgroundTransparency = 1
                img.Size = UDim2.fromOffset(iconSize, iconSize)
                img.Image = iconAsset
                img.ImageColor3 = color
                img.Parent = labelBg
            end
        end
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.AutomaticSize = Enum.AutomaticSize.X
        label.Size = UDim2.new(0, 0, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.Text = text
        label.TextColor3 = self.Theme.Accent
        label.TextSize = self.S(11)
        label.Parent = labelBg
        
        return wrap
    end
    
    -- ==============================
    --        CREATE TOGGLE
    -- ==============================
    function window:CreateToggle(parent, config)
        config = config or {}
        local text = config.Text or "Toggle"
        local flag = config.Flag
        local default = (flag and self.GetFlag(flag) ~= nil) and self.GetFlag(flag) or (config.Default or false)
        local callback = config.Callback or function() end
        local height = self.S(46)
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = self.Theme.Card
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        self:CreateCorner(frame)
        self:CreateStroke(frame, self.Theme.Border, 1, 0.5)
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, self.S(14), 0, 0)
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Font = Enum.Font.GothamSemibold
        label.Text = text
        label.TextColor3 = self.Theme.Text
        label.TextSize = self.S(13)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local trackWidth, trackHeight = self.S(46), self.S(24)
        local track = Instance.new("TextButton")
        track.AutoButtonColor = false
        track.BackgroundColor3 = default and self.Theme.ToggleOn or self.Theme.ToggleOff
        track.Position = UDim2.new(1, -trackWidth - self.S(14), 0.5, -trackHeight/2)
        track.Size = UDim2.new(0, trackWidth, 0, trackHeight)
        track.Text = ""
        track.Parent = frame
        self:CreateCorner(track, UDim.new(1,0))
        self:CreateStroke(track, default and self.Theme.Accent or self.Theme.Border, 1, default and 0.2 or 0.5)
        
        local knobSize = self.S(18)
        local knob = Instance.new("Frame")
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.Position = default and UDim2.new(1, -knobSize - self.S(3), 0.5, -knobSize/2)
                              or UDim2.new(0, self.S(3), 0.5, -knobSize/2)
        knob.Size = UDim2.new(0, knobSize, 0, knobSize)
        knob.Parent = track
        self:CreateCorner(knob, UDim.new(1,0))
        
        local state = default
        local function update(newState, animated)
            state = newState
            local time = animated == false and 0 or 0.2
            if state then
                self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOn}, time)
                self:Tween(knob, {Position = UDim2.new(1, -knobSize - self.S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            else
                self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOff}, time)
                self:Tween(knob, {Position = UDim2.new(0, self.S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            end
        end
        
        track.MouseButton1Click:Connect(function()
            state = not state
            if flag then self.SetFlag(flag, state) end
            callback(state)
            update(state)
        end)
        
        return {
            Frame = frame,
            GetState = function() return state end,
            SetState = function(s) state = s; if flag then self.SetFlag(flag, s) end; callback(state); update(state) end,
        }
    end
    
    -- ==============================
    --        CREATE BUTTON
    -- ==============================
    function window:CreateButton(parent, config)
        config = config or {}
        local text = config.Text or "Button"
        local style = config.Style or "default"
        local callback = config.Callback or function() end
        local height = self.S(40)
        
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        
        local bgColor, bgHover, textColor
        if style == "accent" then
            bgColor = self.Theme.AccentDark
            bgHover = self.Theme.Accent
            textColor = Color3.new(1,1,1)
        elseif style == "danger" then
            bgColor = Color3.fromRGB(45,10,10)
            bgHover = Color3.fromRGB(60,15,15)
            textColor = Color3.new(1,1,1)
        else
            bgColor = self.Theme.Card
            bgHover = self.Theme.CardHover
            textColor = self.Theme.Text
        end
        
        local btn = Instance.new("TextButton")
        btn.AutoButtonColor = false
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, -self.S(8), 1, 0)
        btn.Position = UDim2.new(0.5,0,0,0)
        btn.AnchorPoint = Vector2.new(0.5,0)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextSize = self.S(13)
        btn.TextColor3 = textColor
        btn.BackgroundColor3 = bgColor
        btn.Parent = frame
        self:CreateCorner(btn)
        self:CreateStroke(btn, self.Theme.Accent, 1.2, 0.2)
        
        btn.MouseEnter:Connect(function() self:Tween(btn, {BackgroundColor3 = bgHover}, 0.15) end)
        btn.MouseLeave:Connect(function() self:Tween(btn, {BackgroundColor3 = bgColor}, 0.15) end)
        btn.MouseButton1Click:Connect(callback)
        
        return { Frame = frame, Button = btn, SetText = function(t) btn.Text = t end }
    end
    
    -- ==============================
    --        CREATE INPUT
    -- ==============================
    function window:CreateInput(parent, config)
        config = config or {}
        local labelText = config.Label or "Input"
        local default = config.Default or ""
        local placeholder = config.Placeholder or "Digite..."
        local callback = config.Callback or function() end
        local height = self.S(62)
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = self.Theme.Card
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        self:CreateCorner(frame)
        local stroke = self:CreateStroke(frame, self.Theme.Border, 1, 0.4)
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, self.S(14), 0, self.S(10))
        label.Size = UDim2.new(1, -self.S(28), 0, self.S(16))
        label.Font = Enum.Font.GothamSemibold
        label.Text = labelText
        label.TextColor3 = self.Theme.TextMuted
        label.TextSize = self.S(10)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local textBox = Instance.new("TextBox")
        textBox.BackgroundColor3 = self.Theme.Input
        textBox.Position = UDim2.new(0, self.S(12), 0, self.S(28))
        textBox.Size = UDim2.new(1, -self.S(24), 0, self.S(26))
        textBox.Font = Enum.Font.Gotham
        textBox.Text = tostring(default)
        textBox.PlaceholderText = placeholder
        textBox.PlaceholderColor3 = self.Theme.TextMuted
        textBox.TextColor3 = self.Theme.Text
        textBox.TextSize = self.S(13)
        textBox.ClearTextOnFocus = false
        textBox.Parent = frame
        self:CreateCorner(textBox, UDim.new(0,6))
        
        textBox.Focused:Connect(function()
            self:Tween(stroke, {Color = self.Theme.Accent, Transparency = 0.1}, 0.2)
            self:Tween(label, {TextColor3 = self.Theme.Accent}, 0.2)
        end)
        textBox.FocusLost:Connect(function()
            self:Tween(stroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
            self:Tween(label, {TextColor3 = self.Theme.TextMuted}, 0.2)
            callback(textBox.Text)
        end)
        
        return { Frame = frame, TextBox = textBox, GetText = function() return textBox.Text end, SetText = function(t) textBox.Text = t end }
    end
    
    -- ==============================
    --        CREATE SLIDER
    -- ==============================
    function window:CreateSlider(parent, config)
        config = config or {}
        local text = config.Text or "Slider"
        local min = config.Min or 0
        local max = config.Max or 100
        local default = config.Default or min
        local flag = config.Flag
        local increment = config.Increment or nil
        local callback = config.Callback or function() end
        local height = self.S(62)
        
        if flag and self.GetFlag(flag) ~= nil then default = self.GetFlag(flag) end
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = self.Theme.Card
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        self:CreateCorner(frame)
        self:CreateStroke(frame, self.Theme.Border, 1, 0.4)
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, self.S(14), 0, self.S(10))
        label.Size = UDim2.new(0.6,0,0,self.S(18))
        label.Font = Enum.Font.GothamSemibold
        label.Text = text
        label.TextColor3 = self.Theme.Text
        label.TextSize = self.S(12)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local valueBg = Instance.new("Frame")
        valueBg.BackgroundColor3 = self.Theme.Accent
        valueBg.Position = UDim2.new(1, -self.S(42), 0, self.S(8))
        valueBg.Size = UDim2.new(0, self.S(36), 0, self.S(22))
        valueBg.Parent = frame
        self:CreateCorner(valueBg, UDim.new(0,5))
        
        local valueLabel = Instance.new("TextButton")
        valueLabel.BackgroundTransparency = 1
        valueLabel.Size = UDim2.new(1,0,1,0)
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.Text = tostring(default)
        valueLabel.TextColor3 = Color3.new(1,1,1)
        valueLabel.TextSize = self.S(11)
        valueLabel.AutoButtonColor = false
        valueLabel.Parent = valueBg
        
        local trackHeight = self.S(6)
        local trackBg = Instance.new("Frame")
        trackBg.BackgroundColor3 = self.Theme.Input
        trackBg.Position = UDim2.new(0, self.S(14), 1, -self.S(20))
        trackBg.Size = UDim2.new(1, -self.S(28), 0, trackHeight)
        trackBg.Parent = frame
        self:CreateCorner(trackBg, UDim.new(1,0))
        
        local fill = Instance.new("Frame")
        fill.BackgroundColor3 = self.Theme.Accent
        fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        fill.Parent = trackBg
        self:CreateCorner(fill, UDim.new(1,0))
        
        local knobSize = self.S(16)
        local knob = Instance.new("Frame")
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.Position = UDim2.new((default-min)/(max-min), -knobSize/2, 0.5, -knobSize/2)
        knob.Size = UDim2.new(0, knobSize, 0, knobSize)
        knob.Parent = trackBg
        self:CreateCorner(knob, UDim.new(1,0))
        self:CreateStroke(knob, self.Theme.Accent, 2, 0)
        
        local dragging = false
        local currentValue = default
        
        local function snapValue(v)
            if increment then
                v = math.floor((v - min) / increment + 0.5) * increment + min
            end
            return math.clamp(v, min, max)
        end
        
        local function applyValue(v)
            currentValue = snapValue(v)
            local percent = (currentValue - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, -knobSize/2, 0.5, -knobSize/2)
            valueLabel.Text = tostring(currentValue)
            if flag then self.SetFlag(flag, currentValue) end
            callback(currentValue)
        end
        
        local function updateFromDrag(input)
            local percent = math.clamp((input.Position.X - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1)
            applyValue(min + (max - min) * percent)
        end
        
        trackBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                updateFromDrag(input)
            end
        end)
        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateFromDrag(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        return { Frame = frame, GetValue = function() return currentValue end, SetValue = function(v) applyValue(v) end }
    end
    
    -- ==============================
    --        CREATE DROPDOWN
    -- ==============================
    function window:CreateDropdown(parent, config)
        config = config or {}
        local labelText = config.Label or "Dropdown"
        local options = config.Options or {}
        local default = config.Default or options[1]
        local flag = config.Flag
        local callback = config.Callback or function() end
        local height = self.S(62)
        
        if flag and self.GetFlag(flag) then default = self.GetFlag(flag) end
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = self.Theme.Card
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        self:CreateCorner(frame)
        self:CreateStroke(frame, self.Theme.Border, 1, 0.4)
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, self.S(14), 0, self.S(10))
        label.Size = UDim2.new(1, -self.S(28), 0, self.S(14))
        label.Font = Enum.Font.GothamSemibold
        label.Text = labelText
        label.TextColor3 = self.Theme.TextMuted
        label.TextSize = self.S(10)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local dropBtn = Instance.new("TextButton")
        dropBtn.BackgroundColor3 = self.Theme.Input
        dropBtn.AutoButtonColor = false
        dropBtn.Position = UDim2.new(0, self.S(12), 0, self.S(26))
        dropBtn.Size = UDim2.new(1, -self.S(24), 0, self.S(28))
        dropBtn.Font = Enum.Font.GothamSemibold
        dropBtn.Text = "  " .. tostring(default)
        dropBtn.TextColor3 = default and self.Theme.Text or self.Theme.TextMuted
        dropBtn.TextSize = self.S(12)
        dropBtn.TextXAlignment = Enum.TextXAlignment.Left
        dropBtn.Parent = frame
        self:CreateCorner(dropBtn, UDim.new(0,6))
        local dropStroke = self:CreateStroke(dropBtn, self.Theme.Border, 1, 0.4)
        
        local arrow = Instance.new("ImageLabel")
        arrow.BackgroundTransparency = 1
        arrow.Position = UDim2.new(1, -self.S(28), 0, 0)
        arrow.Size = UDim2.new(0, self.S(26), 1, 0)
        arrow.Image = self:GetIcon("lucide-chevron-down")
        arrow.ImageColor3 = self.Theme.Accent
        arrow.Parent = dropBtn
        
        local selected = default
        local isOpen = false
        
        local overlay = Instance.new("Frame")
        overlay.BackgroundColor3 = Color3.new(0,0,0)
        overlay.BackgroundTransparency = 1
        overlay.Size = UDim2.new(1,0,1,0)
        overlay.ZIndex = 500
        overlay.Visible = false
        overlay.Parent = self.ScreenGui
        
        local listContainer = Instance.new("Frame")
        listContainer.BackgroundColor3 = self.Theme.Card
        listContainer.BorderSizePixel = 0
        listContainer.AnchorPoint = Vector2.new(0.5,0.5)
        listContainer.Size = UDim2.new(0,0,0,0)
        listContainer.ZIndex = 501
        listContainer.Visible = false
        listContainer.Parent = overlay
        self:CreateCorner(listContainer, UDim.new(0,12))
        self:CreateStroke(listContainer, self.Theme.Accent, 1.5, 0.3)
        
        local dropList = Instance.new("ScrollingFrame")
        dropList.BackgroundTransparency = 1
        dropList.Position = UDim2.new(0, self.S(12), 0, self.S(12))
        dropList.Size = UDim2.new(1, -self.S(24), 1, -self.S(12))
        dropList.ScrollBarThickness = 4
        dropList.ScrollBarImageColor3 = self.Theme.Accent
        dropList.ZIndex = 502
        dropList.Parent = listContainer
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, self.S(4))
        listLayout.Parent = dropList
        
        local function closeDropdown()
            if not isOpen then return end
            isOpen = false
            self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
            self:Tween(listContainer, {Size = UDim2.new(0, self.S(320), 0, 0)}, 0.2)
            self:Tween(arrow, {Rotation = 0}, 0.2)
            task.wait(0.2)
            overlay.Visible = false
            listContainer.Visible = false
        end
        
        local function populate()
            for _, child in ipairs(dropList:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
            for _, option in ipairs(options) do
                local row = Instance.new("Frame")
                row.BackgroundColor3 = (option == selected) and self.Theme.AccentDark or self.Theme.Input
                row.Size = UDim2.new(1, 0, 0, self.S(36))
                row.Parent = dropList
                self:CreateCorner(row, UDim.new(0,8))
                
                local rowBtn = Instance.new("TextButton")
                rowBtn.BackgroundTransparency = 1
                rowBtn.Size = UDim2.new(1,0,1,0)
                rowBtn.Font = Enum.Font.GothamSemibold
                rowBtn.Text = "  " .. option
                rowBtn.TextColor3 = (option == selected) and Color3.new(1,1,1) or self.Theme.TextSecondary
                rowBtn.TextSize = self.S(12)
                rowBtn.TextXAlignment = Enum.TextXAlignment.Left
                rowBtn.Parent = row
                
                rowBtn.MouseButton1Click:Connect(function()
                    selected = option
                    dropBtn.Text = "  " .. option
                    dropBtn.TextColor3 = self.Theme.Text
                    if flag then self.SetFlag(flag, option) end
                    callback(option)
                    closeDropdown()
                end)
            end
        end
        
        dropBtn.MouseButton1Click:Connect(function()
            if isOpen then closeDropdown(); return end
            populate()
            local contentHeight = listLayout.AbsoluteContentSize.Y + self.S(24)
            local targetHeight = math.min(contentHeight, self.S(360))
            overlay.Visible = true
            listContainer.Visible = true
            listContainer.Size = UDim2.new(0, self.S(320), 0, 0)
            self:Tween(overlay, {BackgroundTransparency = 0.45}, 0.25)
            self:Tween(listContainer, {Size = UDim2.new(0, self.S(320), 0, targetHeight)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            self:Tween(arrow, {Rotation = 180}, 0.2)
            isOpen = true
        end)
        
        overlay.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos = input.Position
                local listPos = listContainer.AbsolutePosition
                local listSize = listContainer.AbsoluteSize
                local inList = pos.X >= listPos.X and pos.X <= listPos.X+listSize.X and pos.Y >= listPos.Y and pos.Y <= listPos.Y+listSize.Y
                if not inList then closeDropdown() end
            end
        end)
        
        return { Frame = frame, GetValue = function() return selected end, SetValue = function(v) selected=v; dropBtn.Text="  "..v; end }
    end
    
    -- ==============================
    --        CREATE LABEL
    -- ==============================
    function window:CreateLabel(parent, config)
        config = config or {}
        local text = config.Text or "Label"
        local color = config.Color or self.Theme.TextSecondary
        local height = self.S(36)
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = self.Theme.Card
        frame.Size = UDim2.new(1, 0, 0, height)
        frame.Parent = parent
        self:CreateCorner(frame)
        self:CreateStroke(frame, self.Theme.Border, 1, 0.5)
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -self.S(14), 1, 0)
        label.Position = UDim2.new(0, self.S(14), 0, 0)
        label.Font = Enum.Font.GothamSemibold
        label.Text = text
        label.TextColor3 = color
        label.TextSize = self.S(12)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        return { Frame = frame, Label = label, SetText = function(t) label.Text = t end, SetColor = function(c) label.TextColor3 = c end }
    end
    
    -- ==============================
    --        CREATE SEPARATOR
    -- ==============================
    function window:CreateSeparator(parent)
        local wrap = Instance.new("Frame")
        wrap.BackgroundTransparency = 1
        wrap.Size = UDim2.new(1, 0, 0, self.S(12))
        wrap.Parent = parent
        
        local line = Instance.new("Frame")
        line.BackgroundColor3 = self.Theme.Border
        line.BorderSizePixel = 0
        line.Position = UDim2.new(0, 0, 0.5, 0)
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Parent = wrap
        return wrap
    end
    
    -- ==============================
    --        NOTIFY (GenesisX style)
    -- ==============================
    function window:Notify(config)
        config = config or {}
        local message = config.Text or "Notificação"
        local title = config.Title or nil
        local ntype = config.Type or "info"
        local duration = config.Duration or 4
        
        local typeColors = {
            success = self.Theme.Success,
            warning = self.Theme.Warning,
            error = self.Theme.Error,
            info = self.Theme.Info,
            genesis = self.Theme.Accent,
        }
        local typeIcons = {
            success = "lucide-check-circle",
            warning = "lucide-alert-triangle",
            error = "lucide-x-circle",
            info = "lucide-info",
            genesis = "lucide-genesis-hub",
        }
        local accentColor = typeColors[ntype] or self.Theme.Info
        local iconName = typeIcons[ntype] or "lucide-info"
        
        local W = self.S(380)
        local notif = Instance.new("Frame")
        notif.BackgroundColor3 = self.Theme.Background
        notif.Size = UDim2.fromOffset(W, self.S(72))
        notif.Position = UDim2.new(1, W + 20, 0, self.S(20))
        notif.ClipsDescendants = true
        notif.ZIndex = 5000
        notif.Parent = self.ScreenGui
        self:CreateCorner(notif, UDim.new(0,14))
        self:CreateStroke(notif, accentColor, 1.5, 0.3)
        
        local iconArea = Instance.new("Frame")
        iconArea.BackgroundTransparency = 1
        iconArea.Size = UDim2.new(0, self.S(70), 1, 0)
        iconArea.Parent = notif
        
        local iconBg = Instance.new("Frame")
        iconBg.BackgroundColor3 = accentColor
        iconBg.BackgroundTransparency = 0.85
        iconBg.Size = UDim2.fromOffset(self.S(46), self.S(46))
        iconBg.Position = UDim2.new(0.5,0,0.5,0)
        iconBg.AnchorPoint = Vector2.new(0.5,0.5)
        iconBg.Parent = iconArea
        self:CreateCorner(iconBg, UDim.new(1,0))
        
        local iconImg = Instance.new("ImageLabel")
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0.55,0,0.55,0)
        iconImg.Position = UDim2.new(0.225,0,0.225,0)
        iconImg.Image = self:GetIcon(iconName)
        iconImg.ImageColor3 = accentColor
        iconImg.Parent = iconBg
        
        local contentArea = Instance.new("Frame")
        contentArea.BackgroundTransparency = 1
        contentArea.Position = UDim2.new(0, self.S(70)+self.S(12), 0, self.S(10))
        contentArea.Size = UDim2.new(1, -(self.S(70)+self.S(12)+self.S(36)), 1, -self.S(20))
        contentArea.Parent = notif
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(1,0,0,self.S(20))
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title or message
        titleLabel.TextColor3 = accentColor
        titleLabel.TextSize = self.S(13)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = contentArea
        
        local subLabel = Instance.new("TextLabel")
        subLabel.BackgroundTransparency = 1
        subLabel.Position = UDim2.new(0,0,0,self.S(22))
        subLabel.Size = UDim2.new(1,0,0,self.S(16))
        subLabel.Font = Enum.Font.Gotham
        subLabel.Text = (title and message) or ""
        subLabel.TextColor3 = self.Theme.TextSecondary
        subLabel.TextSize = self.S(11)
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        subLabel.Parent = contentArea
        
        local closeBtn = Instance.new("ImageButton")
        closeBtn.BackgroundTransparency = 1
        closeBtn.Position = UDim2.new(1, -self.S(26), 0, self.S(10))
        closeBtn.Size = UDim2.fromOffset(self.S(18), self.S(18))
        closeBtn.Image = self:GetIcon("lucide-x")
        closeBtn.ImageColor3 = self.Theme.TextMuted
        closeBtn.AutoButtonColor = false
        closeBtn.Parent = notif
        
        local function dismiss()
            self:Tween(notif, {Position = UDim2.new(1, W + 60, 0, notif.Position.Y.Offset)}, 0.3)
            task.delay(0.35, function() notif:Destroy() end)
        end
        
        closeBtn.MouseButton1Click:Connect(dismiss)
        notif.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dismiss() end
        end)
        
        self:Tween(notif, {Position = UDim2.new(1, -W - self.S(20), 0, self.S(20))}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        task.delay(duration, function() if notif.Parent then dismiss() end end)
        
        return { Destroy = dismiss }
    end
    
    -- ==============================
    --        DIALOG (redzlib)
    -- ==============================
    function window:Dialog(config)
        config = config or {}
        local title = config.Title or "Dialog"
        local text = config.Text or "Are you sure?"
        local options = config.Options or {{"Confirm", function() end}, {"Cancel"}}
        
        if self.MainFrame:FindFirstChild("Dialog") then return end
        
        local overlay = Instance.new("Frame")
        overlay.BackgroundColor3 = Color3.new(0,0,0)
        overlay.BackgroundTransparency = 0.6
        overlay.Size = UDim2.new(1,0,1,0)
        overlay.ZIndex = 1000
        overlay.Parent = self.MainFrame
        
        local dialogFrame = Instance.new("Frame")
        dialogFrame.BackgroundColor3 = self.Theme.Card
        dialogFrame.Size = UDim2.new(0, 300, 0, 150)
        dialogFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
        dialogFrame.AnchorPoint = Vector2.new(0.5,0.5)
        dialogFrame.Parent = overlay
        self:CreateCorner(dialogFrame, UDim.new(0,12))
        self:CreateStroke(dialogFrame, self.Theme.Accent, 1.5, 0.3)
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0, self.S(15), 0, self.S(10))
        titleLabel.Size = UDim2.new(1, -self.S(30), 0, self.S(20))
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = self.Theme.Accent
        titleLabel.TextSize = self.S(14)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = dialogFrame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.BackgroundTransparency = 1
        textLabel.Position = UDim2.new(0, self.S(15), 0, self.S(35))
        textLabel.Size = UDim2.new(1, -self.S(30), 0, self.S(50))
        textLabel.Font = Enum.Font.Gotham
        textLabel.Text = text
        textLabel.TextColor3 = self.Theme.TextSecondary
        textLabel.TextSize = self.S(12)
        textLabel.TextWrapped = true
        textLabel.Parent = dialogFrame
        
        local btnHolder = Instance.new("Frame")
        btnHolder.BackgroundTransparency = 1
        btnHolder.Position = UDim2.new(0,0,1,-self.S(10))
        btnHolder.Size = UDim2.new(1,0,0,self.S(30))
        btnHolder.Parent = dialogFrame
        
        local btnLayout = Instance.new("UIListLayout")
        btnLayout.FillDirection = Enum.FillDirection.Horizontal
        btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        btnLayout.Padding = UDim.new(0, self.S(10))
        btnLayout.Parent = btnHolder
        
        local dialog = {}
        function dialog:Close()
            self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
            self:Tween(dialogFrame, {Size = UDim2.new(0, 320, 0, 0), BackgroundTransparency = 1}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.delay(0.25, function() overlay:Destroy() end)
        end
        
        for _, opt in ipairs(options) do
            local btnName = opt[1]
            local btnCallback = opt[2] or function() end
            local btn = Instance.new("TextButton")
            btn.BackgroundColor3 = self.Theme.Accent
            btn.Size = UDim2.new(0, 100, 1, 0)
            btn.Text = btnName
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = self.S(12)
            btn.AutoButtonColor = false
            btn.Parent = btnHolder
            self:CreateCorner(btn, UDim.new(0,6))
            btn.MouseButton1Click:Connect(function()
                btnCallback()
                dialog:Close()
            end)
        end
        
        dialogFrame:TweenSize(UDim2.new(0, 300, 0, 150), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3)
        return dialog
    end
    
    -- ==============================
    --        UTILIDADES EXTRAS
    -- ==============================
    function window:SetTheme(themeName)
        local newTheme = (themeName == "Light" and self.Themes.Light) or self.Themes.Dark
        if newTheme == self.Theme then return end
        self.Theme = newTheme
        -- Atualizar cores de todos os elementos (simplificado, apenas recriaria a UI, mas para evitar complexidade, apenas recarregar)
        -- Nesta versão, uma recarga completa seria necessária, mas vamos apenas atualizar o tema da janela atual.
        self.MainFrame.BackgroundColor3 = self.Theme.Background
        self.Header.BackgroundColor3 = self.Theme.Header
        self.Sidebar.Parent.BackgroundColor3 = self.Theme.Sidebar
        -- Para uma implementação completa, seria preciso percorrer todos os descendentes, mas por brevidade, deixamos assim.
    end
    
    function window:SetScale(scaleValue)
        -- Ajuste de escala já é feito automaticamente, mas pode ser forçado
        updateScale()
    end
    
    function window:Destroy()
        self.ScreenGui:Destroy()
    end
    
    return window
end

-- Exportar para o ambiente
local env = getgenv and getgenv() or _G
env.GenesisV2 = GenesisV2

return GenesisV2
