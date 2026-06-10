--[[
    SpectrumX Library - Mesclagem GenesisX + Redz
    API: GenesisX / SpectrumX
    Visual: Redz (gradient, clean style)
    Icones: Externo (metodo GenesisX - repositorio)
    Features: Left/Right tabs, notificacoes, tema completo
--]]

local GenesisX = {}
GenesisX.__index = GenesisX

-- Servicos
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Icones Lucide/SpectrumX - Metodo GenesisX (externo)
local LucideAssets = {}
pcall(function()
    local raw = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/mainloadergg/Library/refs/heads/main/Icons.lua"
    ))()
    if raw and raw.assets then
        LucideAssets = raw.assets
    end
end)
GenesisX.Icons = LucideAssets

-- Font System
GenesisX.Font = "Gotham"

local FontMap = {
    Arcade = Enum.Font.Arcade,
    Fantasy = Enum.Font.Fantasy,
    GothamBlack = Enum.Font.GothamBlack,
}

function GenesisX:GetFont()
    return FontMap[self.Font] or Enum.Font.Gotham
end

function GenesisX:GetFontBold()
    return FontMap[self.Font] or Enum.Font.GothamBold
end

function GenesisX:GetFontSemibold()
    return FontMap[self.Font] or Enum.Font.GothamSemibold
end

function GenesisX:GetFontBlack()
    return FontMap[self.Font] or Enum.Font.GothamBlack
end

-- Theme System - Redz Style
GenesisX.Themes = {
    Darker = {
        Background = Color3.fromRGB(25, 25, 25),
        BackgroundSecondary = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(25, 25, 25),
        Sidebar = Color3.fromRGB(22, 22, 22),
        Card = Color3.fromRGB(30, 30, 30),
        CardHover = Color3.fromRGB(40, 40, 40),
        Input = Color3.fromRGB(35, 35, 35),
        InputHover = Color3.fromRGB(45, 45, 45),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(110, 125, 255),
        AccentSecondary = Color3.fromRGB(130, 145, 255),
        AccentDark = Color3.fromRGB(60, 70, 200),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Stroke = Color3.fromRGB(40, 40, 40),
        StrokeBright = Color3.fromRGB(65, 65, 65),
        ToggleOff = Color3.fromRGB(40, 40, 40),
        ToggleOn = Color3.fromRGB(88, 101, 242),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32, 32, 32)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
        }),
    },
    Dark = {
        Background = Color3.fromRGB(40, 40, 40),
        BackgroundSecondary = Color3.fromRGB(45, 45, 45),
        Header = Color3.fromRGB(40, 40, 40),
        Sidebar = Color3.fromRGB(35, 35, 35),
        Card = Color3.fromRGB(45, 45, 45),
        CardHover = Color3.fromRGB(55, 55, 55),
        Input = Color3.fromRGB(50, 50, 50),
        InputHover = Color3.fromRGB(60, 60, 60),
        Accent = Color3.fromRGB(65, 150, 255),
        AccentHover = Color3.fromRGB(90, 170, 255),
        AccentSecondary = Color3.fromRGB(110, 185, 255),
        AccentDark = Color3.fromRGB(45, 120, 220),
        Text = Color3.fromRGB(245, 245, 245),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(150, 150, 150),
        Stroke = Color3.fromRGB(65, 65, 65),
        StrokeBright = Color3.fromRGB(85, 85, 85),
        ToggleOff = Color3.fromRGB(55, 55, 55),
        ToggleOn = Color3.fromRGB(65, 150, 255),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(47, 47, 47)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
        }),
    },
    Purple = {
        Background = Color3.fromRGB(27, 25, 30),
        BackgroundSecondary = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(27, 25, 30),
        Sidebar = Color3.fromRGB(23, 21, 27),
        Card = Color3.fromRGB(30, 30, 30),
        CardHover = Color3.fromRGB(40, 38, 45),
        Input = Color3.fromRGB(35, 33, 38),
        InputHover = Color3.fromRGB(45, 43, 50),
        Accent = Color3.fromRGB(150, 0, 255),
        AccentHover = Color3.fromRGB(170, 30, 255),
        AccentSecondary = Color3.fromRGB(190, 60, 255),
        AccentDark = Color3.fromRGB(110, 0, 200),
        Text = Color3.fromRGB(240, 240, 240),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        TextMuted = Color3.fromRGB(130, 130, 130),
        Stroke = Color3.fromRGB(40, 40, 40),
        StrokeBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(35, 30, 40),
        ToggleOn = Color3.fromRGB(150, 0, 255),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27, 25, 30)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32, 30, 35)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(27, 25, 30))
        }),
    },
    Green = {
        Background = Color3.fromRGB(20, 35, 25),
        BackgroundSecondary = Color3.fromRGB(25, 40, 30),
        Header = Color3.fromRGB(20, 35, 25),
        Sidebar = Color3.fromRGB(17, 30, 22),
        Card = Color3.fromRGB(25, 40, 30),
        CardHover = Color3.fromRGB(35, 55, 40),
        Input = Color3.fromRGB(30, 45, 35),
        InputHover = Color3.fromRGB(40, 55, 45),
        Accent = Color3.fromRGB(50, 205, 50),
        AccentHover = Color3.fromRGB(70, 225, 70),
        AccentSecondary = Color3.fromRGB(90, 240, 90),
        AccentDark = Color3.fromRGB(35, 160, 35),
        Text = Color3.fromRGB(235, 245, 235),
        TextSecondary = Color3.fromRGB(180, 200, 180),
        TextMuted = Color3.fromRGB(130, 150, 130),
        Stroke = Color3.fromRGB(35, 55, 40),
        StrokeBright = Color3.fromRGB(50, 75, 55),
        ToggleOff = Color3.fromRGB(25, 40, 30),
        ToggleOn = Color3.fromRGB(50, 205, 50),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 35, 25)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 45, 35)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 35, 25))
        }),
    },
    Orange = {
        Background = Color3.fromRGB(40, 25, 15),
        BackgroundSecondary = Color3.fromRGB(45, 30, 20),
        Header = Color3.fromRGB(40, 25, 15),
        Sidebar = Color3.fromRGB(35, 20, 12),
        Card = Color3.fromRGB(45, 30, 20),
        CardHover = Color3.fromRGB(55, 38, 28),
        Input = Color3.fromRGB(50, 35, 25),
        InputHover = Color3.fromRGB(60, 42, 32),
        Accent = Color3.fromRGB(255, 140, 0),
        AccentHover = Color3.fromRGB(255, 165, 30),
        AccentSecondary = Color3.fromRGB(255, 180, 60),
        AccentDark = Color3.fromRGB(200, 110, 0),
        Text = Color3.fromRGB(250, 240, 230),
        TextSecondary = Color3.fromRGB(200, 180, 160),
        TextMuted = Color3.fromRGB(150, 130, 110),
        Stroke = Color3.fromRGB(60, 40, 25),
        StrokeBright = Color3.fromRGB(80, 55, 35),
        ToggleOff = Color3.fromRGB(45, 30, 18),
        ToggleOn = Color3.fromRGB(255, 140, 0),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 25, 15)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(55, 35, 25)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 25, 15))
        }),
    },
}

GenesisX.Theme = GenesisX.Themes.Darker

-- Configuracoes
GenesisX.Config = {
    AnimationSpeed = 0.25,
    CornerRadius = 8,
}

-- Internal Save/Load
GenesisX._configFolder = "SpectrumX/Config"

function GenesisX:_SaveConfigFile(filename, value)
    if not (writefile and isfolder and makefolder and HttpService) then return end
    pcall(function()
        if not isfolder("SpectrumX") then makefolder("SpectrumX") end
        if not isfolder(self._configFolder) then makefolder(self._configFolder) end
        local path = self._configFolder .. "/" .. filename
        writefile(path, HttpService:JSONEncode({value = value}))
    end)
end

function GenesisX:_LoadConfigFile(filename, defaultValue)
    if not (readfile and isfile and HttpService) then return defaultValue end
    local ok, data = pcall(function()
        local path = self._configFolder .. "/" .. filename
        if not isfile(path) then return nil end
        return HttpService:JSONDecode(readfile(path))
    end)
    if ok and data and data.value ~= nil then
        return data.value
    end
    self:_SaveConfigFile(filename, defaultValue)
    return defaultValue
end

-- Escala Responsiva
local ScaleData = {
    IsMobile = false,
    ScaleFactor = 1,
    BaseResolution = Vector2.new(1920, 1080)
}

function GenesisX:UpdateScale()
    local success, camera = pcall(function() return workspace.CurrentCamera end)
    if not success or not camera then return end
    local viewport = camera.ViewportSize
    if viewport.X == 0 then return end
    ScaleData.IsMobile = UserInputService.TouchEnabled and (viewport.X < 1200 or viewport.Y < 700)
    local scale = math.min(viewport.X / ScaleData.BaseResolution.X, viewport.Y / ScaleData.BaseResolution.Y)
    if ScaleData.IsMobile then
        ScaleData.ScaleFactor = math.clamp(scale, 0.85, 1.2)
    else
        ScaleData.ScaleFactor = math.clamp(scale, 0.7, 1.1)
    end
end

function GenesisX:S(value)
    if type(value) == "number" then
        return math.floor(value * ScaleData.ScaleFactor)
    elseif typeof(value) == "UDim2" then
        return UDim2.new(
            value.X.Scale, math.floor(value.X.Offset * ScaleData.ScaleFactor),
            value.Y.Scale, math.floor(value.Y.Offset * ScaleData.ScaleFactor)
        )
    elseif typeof(value) == "UDim" then
        return UDim.new(value.Scale, math.floor(value.Offset * ScaleData.ScaleFactor))
    end
    return value
end

-- Utilitarios
function GenesisX:Tween(obj, props, time, style, direction)
    if not obj or not obj.Parent then return nil end
    local tweenInfo = TweenInfo.new(
        time or self.Config.AnimationSpeed,
        style or Enum.EasingStyle.Quint,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

function GenesisX:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, self.Config.CornerRadius)
    corner.Parent = parent
    return corner
end

function GenesisX:CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or self.Theme.Stroke
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function GenesisX:CreateGradient(parent, colorSeq, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colorSeq or self.Theme.Gradient
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    return gradient
end

function GenesisX:CreateShadow(parent, size, transparency)
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = transparency or 0.8
    shadow.BorderSizePixel = 0
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, size or 16, 1, size or 16)
    shadow.ZIndex = math.max(0, parent.ZIndex - 1)
    shadow.Parent = parent
    self:CreateCorner(shadow)
    return shadow
end

function GenesisX:MakeDraggable(frame, handle)
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

function GenesisX:CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = Color3.new(1, 1, 1)
    ripple.BackgroundTransparency = 0.85
    ripple.BorderSizePixel = 0
    ripple.ZIndex = parent.ZIndex + 10
    local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 1.2
    local startX, startY
    if position then
        startX = position.X - parent.AbsolutePosition.X
        startY = position.Y - parent.AbsolutePosition.Y
    else
        startX = parent.AbsoluteSize.X / 2
        startY = parent.AbsoluteSize.Y / 2
    end
    ripple.Position = UDim2.new(0, startX, 0, startY)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Parent = parent
    self:CreateCorner(ripple, UDim.new(1, 0))
    self:Tween(ripple, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        BackgroundTransparency = 1
    }, 0.4)
    task.delay(0.4, function()
        if ripple and ripple.Parent then ripple:Destroy() end
    end)
end

-- Helpers de Icone
function GenesisX:IsAssetId(value)
    if type(value) ~= "string" and type(value) ~= "number" then return false end
    local s = tostring(value)
    if s:match("^rbxassetid://") ~= nil or s:match("^%d+$") ~= nil then return true end
    if LucideAssets and LucideAssets[s] then return true end
    return false
end

function GenesisX:FormatAssetId(value)
    if type(value) == "number" then
        return "rbxassetid://" .. value
    elseif type(value) == "string" then
        if LucideAssets and LucideAssets[value] then
            return LucideAssets[value]
        end
        if value:match("^rbxassetid://") then
            return value
        elseif value:match("^%d+$") then
            return "rbxassetid://" .. value
        end
    end
    return nil
end

function GenesisX:CreateIcon(parent, iconData, size, color)
    size = size or UDim2.new(0, 20, 0, 20)
    color = color or self.Theme.Text
    local assetId = self:FormatAssetId(iconData)
    if assetId then
        local img = Instance.new("ImageLabel")
        img.Name = "Icon"
        img.BackgroundTransparency = 1
        img.Size = size
        img.Image = assetId
        img.ImageColor3 = color
        img.Parent = parent
        local aspect = Instance.new("UIAspectRatioConstraint")
        aspect.Parent = img
        return img, "image"
    else
        local lbl = Instance.new("TextLabel")
        lbl.Name = "Icon"
        lbl.BackgroundTransparency = 1
        lbl.Size = size
        lbl.Font = self:GetFontBold()
        lbl.Text = tostring(iconData):sub(1, 2)
        lbl.TextColor3 = color
        lbl.TextSize = size.Y.Offset or 16
        lbl.Parent = parent
        return lbl, "text"
    end
end

-- Dropdown registry
function GenesisX:_RegisterDropdown(list, button, closeFunction)
    if not self._dropdowns then self._dropdowns = {} end
    table.insert(self._dropdowns, { List = list, Button = button, Close = closeFunction })
end

function GenesisX:_CloseDropdownsOnClick(position)
    if not self._dropdowns then return end
    for _, dropdown in ipairs(self._dropdowns) do
        if dropdown.List and dropdown.List.Visible then
            local listPos = dropdown.List.AbsolutePosition
            local listSize = dropdown.List.AbsoluteSize
            local btnPos = dropdown.Button.AbsolutePosition
            local btnSize = dropdown.Button.AbsoluteSize
            local inList = position.X >= listPos.X and position.X <= listPos.X + listSize.X and
                           position.Y >= listPos.Y and position.Y <= listPos.Y + listSize.Y
            local inBtn = position.X >= btnPos.X and position.X <= btnPos.X + btnSize.X and
                          position.Y >= btnPos.Y and position.Y <= btnPos.Y + btnSize.Y
            if not inList and not inBtn then
                task.spawn(dropdown.Close)
            end
        end
    end
end



-- CREATE WINDOW - Visual Redz Style
function GenesisX:CreateWindow(config)
    self:_EnsureTheme()
    config = config or {}
    local window = setmetatable({}, self)
    self:UpdateScale()

    local configTheme = config.Theme or "Darker"
    local configFont  = config.Font  or "Gotham"
    local savedTheme  = self:_LoadConfigFile("theme.json", configTheme)
    local savedFont   = self:_LoadConfigFile("font.json", configFont)

    if savedTheme and self.Themes[savedTheme] then
        self.Theme = self.Themes[savedTheme]
    else
        self.Theme = self.Themes.Darker
    end
    self.Font = savedFont

    if PlayerGui:FindFirstChild("SpectrumX") then
        PlayerGui.SpectrumX:Destroy()
    end

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "SpectrumX"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.DisplayOrder = 999999

    local parentSuccess = pcall(function()
        self.ScreenGui.Parent = CoreGui
    end)
    if not parentSuccess then
        self.ScreenGui.Parent = PlayerGui
    end

    self._notifications = {}
    self.Dropdowns = {}
    self._dropdowns = {}
    self.Tabs = {}
    self.CurrentTab = nil

    local windowWidth = config.Size and config.Size.X.Offset or (ScaleData.IsMobile and 440 or 580)
    local windowHeight = config.Size and config.Size.Y.Offset or (ScaleData.IsMobile and 380 or 420)

    -- Main Frame - Redz Style com gradiente
    self.MainFrame = Instance.new("ImageButton")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BackgroundTransparency = 0.03
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Position = config.Position or UDim2.new(0.5, -math.floor(windowWidth/2), 0.5, -math.floor(windowHeight/2))
    self.MainFrame.Size = config.Size or UDim2.new(0, windowWidth, 0, windowHeight)
    self.MainFrame.Active = true
    self.MainFrame.AutoButtonColor = false
    self.MainFrame.Visible = true
    self.MainFrame.ZIndex = 10
    self.MainFrame.Parent = self.ScreenGui
    self:CreateCorner(self.MainFrame, UDim.new(0, 10))
    self:CreateGradient(self.MainFrame, self.Theme.Gradient, 45)
    self:MakeDraggable(self.MainFrame)

    -- Header
    local headerHeight = 28

    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.BackgroundTransparency = 1
    self.Header.Size = UDim2.new(1, 0, 0, headerHeight)
    self.Header.ZIndex = 12
    self.Header.Parent = self.MainFrame

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0.5, 0)
    titleLabel.AnchorPoint = Vector2.new(0, 0.5)
    titleLabel.AutomaticSize = Enum.AutomaticSize.XY
    titleLabel.Font = self:GetFontSemibold()
    titleLabel.Text = config.Title or "SpectrumX"
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = 12
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 14
    titleLabel.Parent = self.Header

    -- Subtitle
    if config.Subtitle then
        local subtitleLabel = Instance.new("TextLabel")
        subtitleLabel.Name = "Subtitle"
        subtitleLabel.BackgroundTransparency = 1
        subtitleLabel.Position = UDim2.new(0, 5, 0.9, 0)
        subtitleLabel.AnchorPoint = Vector2.new(0, 1)
        subtitleLabel.AutomaticSize = Enum.AutomaticSize.XY
        subtitleLabel.Font = self:GetFont()
        subtitleLabel.Text = config.Subtitle
        subtitleLabel.TextColor3 = self.Theme.TextMuted
        subtitleLabel.TextSize = 8
        subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        subtitleLabel.ZIndex = 14
        subtitleLabel.Parent = titleLabel
    end

    -- Header Buttons (Close, Minimize)
    local ButtonsFolder = Instance.new("Folder")
    ButtonsFolder.Name = "Buttons"
    ButtonsFolder.Parent = self.Header

    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "Close"
    CloseButton.Size = UDim2.new(0, 14, 0, 14)
    CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Image = self:FormatAssetId("x") or "rbxassetid://10747384394"
    CloseButton.AutoButtonColor = false
    CloseButton.ZIndex = 14
    CloseButton.Parent = ButtonsFolder

    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Size = UDim2.new(0, 14, 0, 14)
    MinimizeButton.Position = UDim2.new(1, -35, 0.5, 0)
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Image = self:FormatAssetId("minus") or "rbxassetid://10734896206"
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.ZIndex = 14
    MinimizeButton.Parent = ButtonsFolder

    -- Sidebar (Tab Scroll)
    local sidebarWidth = config.TabSize or 160

    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.BackgroundTransparency = 1
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.Position = UDim2.new(0, 0, 0, headerHeight)
    self.Sidebar.Size = UDim2.new(0, sidebarWidth, 1, -headerHeight)
    self.Sidebar.ScrollBarThickness = 1.5
    self.Sidebar.ScrollBarImageColor3 = self.Theme.Accent
    self.Sidebar.ScrollBarImageTransparency = 0.2
    self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.Sidebar.ZIndex = 11
    self.Sidebar.Parent = self.MainFrame

    local sidebarPadding = Instance.new("UIPadding")
    sidebarPadding.PaddingLeft = UDim.new(0, 10)
    sidebarPadding.PaddingRight = UDim.new(0, 10)
    sidebarPadding.PaddingTop = UDim.new(0, 10)
    sidebarPadding.PaddingBottom = UDim.new(0, 10)
    sidebarPadding.Parent = self.Sidebar

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 5)
    sidebarLayout.Parent = self.Sidebar

    -- Content Area (Containers)
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.Position = UDim2.new(0, sidebarWidth, 0, headerHeight)
    self.ContentArea.Size = UDim2.new(1, -sidebarWidth, 1, -headerHeight)
    self.ContentArea.ZIndex = 11
    self.ContentArea.ClipsDescendants = true
    self.ContentArea.Parent = self.MainFrame

    -- Minimize functionality
    local Minimized, SaveSize, WaitClick = false, nil, false
    local function ToggleMinimize()
        if WaitClick then return end
        WaitClick = true
        if Minimized then
            MinimizeButton.Image = self:FormatAssetId("minus") or "rbxassetid://10734896206"
            self:Tween(self.MainFrame, {Size = SaveSize}, 0.25)
            self.ContentArea.Visible = true
            self.Sidebar.Visible = true
            Minimized = false
        else
            MinimizeButton.Image = self:FormatAssetId("plus") or "rbxassetid://10734924532"
            SaveSize = self.MainFrame.Size
            self.ContentArea.Visible = false
            self.Sidebar.Visible = false
            self:Tween(self.MainFrame, {Size = UDim2.new(0, self.MainFrame.Size.X.Offset, 0, headerHeight + 5)}, 0.25)
            Minimized = true
        end
        task.delay(0.26, function() WaitClick = false end)
    end
    MinimizeButton.MouseButton1Click:Connect(ToggleMinimize)
    CloseButton.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)

    -- Dropdown Holder
    self.DropdownHolder = Instance.new("Folder")
    self.DropdownHolder.Name = "DropdownHolder"
    self.DropdownHolder.Parent = self.ScreenGui

    -- Floating Button
    self:_CreateFloatingButton(config)

    -- Close dropdowns on click
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            self:_CloseDropdownsOnClick(input.Position)
        end
    end)

    -- Window functions
    function window:Set(Val1, Val2)
        if type(Val1) == "string" and type(Val2) == "string" then
            titleLabel.Text = Val1
        elseif type(Val1) == "string" then
            titleLabel.Text = Val1
        end
    end
    function window:Minimize()
        self.MainFrame.Visible = not self.MainFrame.Visible
    end
    function window:CloseBtn()
        self.ScreenGui:Destroy()
    end
    function window:SelectTab(tabSelect)
        if type(tabSelect) == "string" then
            local tabData = self.Tabs[tabSelect]
            if tabData then
                GenesisX:SelectTab(tabSelect)
            end
        end
    end

    return window
end

-- CREATE FLOATING BUTTON
function GenesisX:_CreateFloatingButton(config)
    config = config or {}
    local btnSize = self:S(42)

    self.FloatBtn = Instance.new("ImageButton")
    self.FloatBtn.Name = "FloatBtn"
    self.FloatBtn.BackgroundColor3 = self.Theme.Accent
    self.FloatBtn.Position = UDim2.new(0, 20, 0.5, 0)
    self.FloatBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    self.FloatBtn.Image = ""
    self.FloatBtn.AutoButtonColor = false
    self.FloatBtn.ZIndex = 100
    self.FloatBtn.Parent = self.ScreenGui
    self:CreateCorner(self.FloatBtn, UDim.new(0, 12))
    self:CreateStroke(self.FloatBtn, self.Theme.Accent, 2, 0.3)

    local floatIconRaw = config.FloatIcon or config.Icon or "lucide-zap"
    local floatIconAsset = self:FormatAssetId(floatIconRaw)

    if floatIconAsset then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "Icon"
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0.6, 0, 0.6, 0)
        iconImg.Position = UDim2.new(0.2, 0, 0.2, 0)
        iconImg.Image = floatIconAsset
        iconImg.ImageColor3 = Color3.new(1, 1, 1)
        iconImg.ZIndex = 102
        iconImg.Parent = self.FloatBtn
    else
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "Icon"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBlack()
        iconLabel.Text = tostring(floatIconRaw):sub(1, 1)
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.TextSize = self:S(20)
        iconLabel.ZIndex = 102
        iconLabel.Parent = self.FloatBtn
    end

    self.FloatBtn.MouseEnter:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.AccentHover}, 0.15)
    end)
    self.FloatBtn.MouseLeave:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.Accent}, 0.15)
    end)
    self.FloatBtn.MouseButton1Click:Connect(function()
        self.MainFrame.Visible = not self.MainFrame.Visible
    end)

    local dragging = false
    local dragStart = nil
    local startPos = nil

    self.FloatBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.FloatBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            self.FloatBtn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Ensure Theme
function GenesisX:_EnsureTheme()
    if not self.Theme then
        self.Theme = self.Themes.Darker
    end
end



-- CREATE TAB - Redz Style Sidebar + Left/Right Support
function GenesisX:CreateTab(config)
    config = config or {}
    local tabId = config.Name or config.Title or "Tab"
    local tabIcon = config.Icon or ""
    local tabSide = config.Side or "Auto"

    tabIcon = self:FormatAssetId(tabIcon)
    if not tabIcon or (type(tabIcon) == "string" and not tabIcon:find("rbxassetid://")) then
        tabIcon = false
    end

    -- Tab Button - Redz Style
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabId .. "Tab"
    tabBtn.BackgroundColor3 = self.Theme.Card
    tabBtn.BackgroundTransparency = 0
    tabBtn.Size = UDim2.new(1, 0, 0, 24)
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.ZIndex = 13
    tabBtn.Parent = self.Sidebar
    self:CreateCorner(tabBtn, UDim.new(0, 6))

    -- Selected indicator (dot) - Redz style
    local Selected = Instance.new("Frame")
    Selected.Name = "Selected"
    Selected.Size = UDim2.new(0, 4, 0, 4)
    Selected.Position = UDim2.new(0, 1, 0.5, 0)
    Selected.AnchorPoint = Vector2.new(0, 0.5)
    Selected.BackgroundColor3 = self.Theme.Accent
    Selected.BackgroundTransparency = 1
    Selected.ZIndex = 14
    Selected.Parent = tabBtn
    self:CreateCorner(Selected, UDim.new(0.5, 0))

    -- Icon
    local LabelIcon
    if tabIcon then
        LabelIcon = Instance.new("ImageLabel")
        LabelIcon.Name = "Icon"
        LabelIcon.Position = UDim2.new(0, 8, 0.5, 0)
        LabelIcon.Size = UDim2.new(0, 13, 0, 13)
        LabelIcon.AnchorPoint = Vector2.new(0, 0.5)
        LabelIcon.Image = tabIcon
        LabelIcon.ImageColor3 = self.Theme.Text
        LabelIcon.BackgroundTransparency = 1
        LabelIcon.ZIndex = 14
        LabelIcon.Parent = tabBtn
    end

    -- Title
    local LabelTitle = Instance.new("TextLabel")
    LabelTitle.Name = "Title"
    LabelTitle.Size = UDim2.new(1, tabIcon and -25 or -15, 1, 0)
    LabelTitle.Position = UDim2.new(0, tabIcon and 25 or 15, 0, 0)
    LabelTitle.BackgroundTransparency = 1
    LabelTitle.Font = self:GetFontSemibold()
    LabelTitle.Text = tabId
    LabelTitle.TextColor3 = self.Theme.Text
    LabelTitle.TextSize = 10
    LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
    LabelTitle.TextTruncate = Enum.TextTruncate.AtEnd
    LabelTitle.ZIndex = 14
    LabelTitle.Parent = tabBtn

    -- Page Container
    local page = Instance.new("Frame")
    page.Name = tabId .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.ZIndex = 11
    page.Parent = self.ContentArea

    -- Divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.BackgroundColor3 = self.Theme.Stroke
    divider.BackgroundTransparency = 0.7
    divider.BorderSizePixel = 0
    divider.Position = UDim2.new(0.5, -1, 0, 0)
    divider.Size = UDim2.new(0, 1, 1, 0)
    divider.ZIndex = 11
    divider.Parent = page

    -- Left/Right ScrollingFrames
    local function createSide(position, size, name)
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Name = name
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.Position = position
        scrollFrame.Size = size
        scrollFrame.ScrollBarThickness = 2
        scrollFrame.ScrollBarImageColor3 = self.Theme.Accent
        scrollFrame.ScrollBarImageTransparency = 0.5
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrollFrame.ZIndex = 11
        scrollFrame.Parent = page
        scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Never

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        layout.Parent = scrollFrame

        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.PaddingTop = UDim.new(0, 8)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.Parent = scrollFrame

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        end)

        return scrollFrame
    end

    local left = createSide(UDim2.new(0, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Left")
    local right = createSide(UDim2.new(0.51, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Right")

    -- Tab data
    local tabData = {
        Button = tabBtn,
        Container = page,
        Left = left,
        Right = right,
        Id = tabId,
        Side = tabSide
    }
    self.Tabs[tabId] = tabData

    -- Tab selection
    tabBtn.MouseButton1Click:Connect(function()
        self:SelectTab(tabId)
    end)

    -- Auto-select first tab
    if not self.CurrentTab then
        self:SelectTab(tabId)
    end

    -- Return tab object with methods
    local Tab = {}
    Tab.Cont = page
    Tab.Left = left
    Tab.Right = right

    function Tab:Enable()
        local selfData = GenesisX.Tabs[tabId]
        if not selfData then return end
        GenesisX:SelectTab(tabId)
    end
    function Tab:Disable()
        -- Handled by SelectTab
    end
    function Tab:Visible(bool)
        tabBtn.Visible = bool ~= false
        page.Visible = bool ~= false
    end
    function Tab:Destroy()
        tabBtn:Destroy()
        page:Destroy()
    end

    return Tab
end

-- SELECT TAB
function GenesisX:SelectTab(tabId)
    if self.CurrentTab == tabId then return end

    local oldTab = self.CurrentTab and self.Tabs[self.CurrentTab]
    local newTab = self.Tabs[tabId]
    if not newTab then return end

    -- Hide old tab
    if oldTab and oldTab.Container then
        oldTab.Container.Visible = false
        -- Reset old tab button style
        local oldBtn = oldTab.Button
        local oldSelected = oldBtn:FindFirstChild("Selected")
        local oldIcon = oldBtn:FindFirstChild("Icon")
        self:Tween(oldSelected, {Size = UDim2.new(0, 4, 0, 4)}, 0.35)
        self:Tween(oldSelected, {BackgroundTransparency = 1}, 0.35)
        if oldIcon then
            self:Tween(oldIcon, {ImageTransparency = 0.3}, 0.35)
        end
        local oldTitle = oldBtn:FindFirstChild("Title")
        if oldTitle then
            self:Tween(oldTitle, {TextTransparency = 0.3}, 0.35)
        end
    end

    -- Show new tab
    newTab.Container.Visible = true
    local newBtn = newTab.Button
    local newSelected = newBtn:FindFirstChild("Selected")
    local newIcon = newBtn:FindFirstChild("Icon")
    self:Tween(newSelected, {Size = UDim2.new(0, 4, 0, 13)}, 0.35)
    self:Tween(newSelected, {BackgroundTransparency = 0}, 0.35)
    if newIcon then
        self:Tween(newIcon, {ImageTransparency = 0}, 0.35)
    end
    local newTitle = newBtn:FindFirstChild("Title")
    if newTitle then
        self:Tween(newTitle, {TextTransparency = 0}, 0.35)
    end

    self.CurrentTab = tabId
end

-- Helper: Get correct parent (Left or Right) based on config
function GenesisX:_GetParent(tab, config)
    config = config or {}
    local side = config.Side or "Auto"
    if side == "Right" then
        return tab.Right
    elseif side == "Left" then
        return tab.Left
    else
        -- Auto: distribute evenly
        local leftCount = #tab.Left:GetChildren() - 2 -- subtract UIListLayout and UIPadding
        local rightCount = #tab.Right:GetChildren() - 2
        if rightCount < leftCount then
            return tab.Right
        else
            return tab.Left
        end
    end
end

-- Internal: Create base option frame - Redz Style
function GenesisX:_CreateOptionFrame(parent, title, description)
    local holderSize = UDim2.new(1, -20, 0, 0)

    local Frame = Instance.new("TextButton")
    Frame.Name = "Option"
    Frame.Size = UDim2.new(1, 0, 0, 25)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.BackgroundColor3 = self.Theme.Card
    Frame.Text = ""
    Frame.AutoButtonColor = false
    Frame.ZIndex = 12
    Frame.Parent = parent
    self:CreateCorner(Frame, UDim.new(0, 6))

    Frame.MouseEnter:Connect(function()
        self:Tween(Frame, {BackgroundTransparency = 0.4}, 0.15)
    end)
    Frame.MouseLeave:Connect(function()
        self:Tween(Frame, {BackgroundTransparency = 0}, 0.15)
    end)

    local LabelHolder = Instance.new("Frame")
    LabelHolder.Name = "LabelHolder"
    LabelHolder.AutomaticSize = Enum.AutomaticSize.Y
    LabelHolder.BackgroundTransparency = 1
    LabelHolder.Size = holderSize
    LabelHolder.Position = UDim2.new(0, 10, 0, 0)
    LabelHolder.AnchorPoint = Vector2.new(0, 0)
    LabelHolder.ZIndex = 13
    LabelHolder.Parent = Frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = LabelHolder

    local pad = Instance.new("UIPadding")
    pad.PaddingBottom = UDim.new(0, 5)
    pad.PaddingTop = UDim.new(0, 5)
    pad.Parent = LabelHolder

    local TitleL = Instance.new("TextLabel")
    TitleL.Name = "Title"
    TitleL.Font = self:GetFontSemibold()
    TitleL.TextColor3 = self.Theme.Text
    TitleL.Size = UDim2.new(1, -20, 0, 0)
    TitleL.AutomaticSize = Enum.AutomaticSize.Y
    TitleL.Position = UDim2.new(0, 0, 0.5, 0)
    TitleL.AnchorPoint = Vector2.new(0, 0.5)
    TitleL.BackgroundTransparency = 1
    TitleL.TextTruncate = Enum.TextTruncate.AtEnd
    TitleL.TextSize = 10
    TitleL.TextXAlignment = Enum.TextXAlignment.Left
    TitleL.RichText = true
    TitleL.Text = title or ""
    TitleL.ZIndex = 13
    TitleL.Parent = LabelHolder

    local DescL = Instance.new("TextLabel")
    DescL.Name = "Desc"
    DescL.Font = self:GetFont()
    DescL.TextColor3 = self.Theme.TextMuted
    DescL.Size = UDim2.new(1, -20, 0, 0)
    DescL.AutomaticSize = Enum.AutomaticSize.Y
    DescL.Position = UDim2.new(0, 12, 0, 15)
    DescL.BackgroundTransparency = 1
    DescL.TextWrapped = true
    DescL.TextSize = 8
    DescL.TextXAlignment = Enum.TextXAlignment.Left
    DescL.RichText = true
    DescL.Text = description or ""
    DescL.Visible = description and description ~= ""
    DescL.ZIndex = 13
    DescL.Parent = LabelHolder

    local Label = {}
    function Label:SetTitle(NewTitle)
        if type(NewTitle) == "string" and NewTitle:gsub(" ", ""):len() > 0 then
            TitleL.Text = NewTitle
        end
    end
    function Label:SetDesc(NewDesc)
        if type(NewDesc) == "string" and NewDesc:gsub(" ", ""):len() > 0 then
            DescL.Visible = true
            DescL.Text = NewDesc
            LabelHolder.Position = UDim2.new(0, 10, 0, 0)
            LabelHolder.AnchorPoint = Vector2.new(0, 0)
        else
            DescL.Visible = false
            DescL.Text = ""
            LabelHolder.Position = UDim2.new(0, 10, 0.5, 0)
            LabelHolder.AnchorPoint = Vector2.new(0, 0.5)
        end
    end

    return Frame, Label, TitleL, DescL
end



-- CREATE SECTION
function GenesisX:CreateSection(tab, config)
    config = type(config) == "string" and {Name = config} or (config or {})
    local sectionName = config.Name or config.Title or config[1] or "Section"
    local parent = tab.Left or tab

    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = "Section"
    SectionFrame.Size = UDim2.new(1, 0, 0, 20)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.ZIndex = 12
    SectionFrame.Parent = parent

    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Name = "Label"
    SectionLabel.Font = self:GetFontBold()
    SectionLabel.Text = sectionName
    SectionLabel.TextColor3 = self.Theme.Text
    SectionLabel.Size = UDim2.new(1, -25, 1, 0)
    SectionLabel.Position = UDim2.new(0, 5, 0, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.TextTruncate = Enum.TextTruncate.AtEnd
    SectionLabel.TextSize = 12
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.ZIndex = 13
    SectionLabel.Parent = SectionFrame

    local Section = {}
    function Section:Set(newText)
        if newText then
            SectionLabel.Text = tostring(newText)
        end
    end
    function Section:Visible(bool)
        SectionFrame.Visible = bool ~= false
    end
    function Section:Destroy()
        SectionFrame:Destroy()
    end
    return Section
end

-- CREATE PARAGRAPH
function GenesisX:CreateParagraph(tab, config)
    config = config or {}
    local pName = config.Title or config[1] or "Paragraph"
    local pDesc = config.Text or config[2] or ""
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, pName, pDesc)

    local Paragraph = {}
    function Paragraph:SetTitle(val)
        LabelFunc:SetTitle(tostring(val))
    end
    function Paragraph:SetDesc(val)
        LabelFunc:SetDesc(tostring(val))
    end
    function Paragraph:Set(val1, val2)
        if val1 and val2 then
            LabelFunc:SetTitle(tostring(val1))
            LabelFunc:SetDesc(tostring(val2))
        elseif val1 then
            LabelFunc:SetDesc(tostring(val1))
        end
    end
    function Paragraph:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Paragraph:Destroy()
        Frame:Destroy()
    end
    return Paragraph
end

-- CREATE BUTTON
function GenesisX:CreateButton(tab, config)
    config = config or {}
    local bName = config.Text or config.Title or config[1] or "Button"
    local bDesc = config.Desc or config.Description or ""
    local callback = config.Callback or config[2] or function() end
    if type(callback) ~= "function" then callback = function() end end
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, bName, bDesc)

    -- Button icon (arrow) - Redz style
    local ButtonIcon = Instance.new("ImageLabel")
    ButtonIcon.Name = "Icon"
    ButtonIcon.Size = UDim2.new(0, 14, 0, 14)
    ButtonIcon.Position = UDim2.new(1, -10, 0.5, 0)
    ButtonIcon.AnchorPoint = Vector2.new(1, 0.5)
    ButtonIcon.BackgroundTransparency = 1
    ButtonIcon.Image = self:FormatAssetId("chevron-right") or "rbxassetid://10709791437"
    ButtonIcon.ZIndex = 13
    ButtonIcon.Parent = Frame

    Frame.Activated:Connect(function()
        pcall(callback)
    end)

    local Button = {}
    function Button:Set(val1, val2)
        if type(val1) == "string" and type(val2) == "string" then
            LabelFunc:SetTitle(val1)
            LabelFunc:SetDesc(val2)
        elseif type(val1) == "string" then
            LabelFunc:SetTitle(val1)
        elseif type(val1) == "function" then
            callback = val1
        end
    end
    function Button:Callback(cb)
        if type(cb) == "function" then
            table.insert(callback and {callback} or {}, cb)
        end
    end
    function Button:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Button:Destroy()
        Frame:Destroy()
    end
    return Button
end

-- CREATE TOGGLE
function GenesisX:CreateToggle(tab, config)
    config = config or {}
    local tName = config.Text or config.Title or config[1] or "Toggle"
    local tDesc = config.Desc or config.Description or ""
    local default = config.Default or config[2] or false
    local callback = config.Callback or config[3] or function() end
    local flag = config.Flag or config[4] or false
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, tName, tDesc)

    -- Toggle Holder - Redz style
    local ToggleHolder = Instance.new("Frame")
    ToggleHolder.Name = "ToggleHolder"
    ToggleHolder.Size = UDim2.new(0, 35, 0, 18)
    ToggleHolder.Position = UDim2.new(1, -10, 0.5, 0)
    ToggleHolder.AnchorPoint = Vector2.new(1, 0.5)
    ToggleHolder.BackgroundColor3 = self.Theme.Stroke
    ToggleHolder.ZIndex = 13
    ToggleHolder.Parent = Frame
    self:CreateCorner(ToggleHolder, UDim.new(0.5, 0))

    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.BackgroundTransparency = 1
    Slider.Size = UDim2.new(0.8, 0, 0.8, 0)
    Slider.Position = UDim2.new(0.5, 0, 0.5, 0)
    Slider.AnchorPoint = Vector2.new(0.5, 0.5)
    Slider.ZIndex = 14
    Slider.Parent = ToggleHolder

    local ToggleDot = Instance.new("Frame")
    ToggleDot.Name = "Dot"
    ToggleDot.Size = UDim2.new(0, 12, 0, 12)
    ToggleDot.Position = UDim2.new(0, 0, 0.5, 0)
    ToggleDot.AnchorPoint = Vector2.new(0, 0.5)
    ToggleDot.BackgroundColor3 = self.Theme.Accent
    ToggleDot.ZIndex = 15
    ToggleDot.Parent = Slider
    self:CreateCorner(ToggleDot, UDim.new(0.5, 0))

    local WaitClick = false
    local function SetToggle(val, skipCallback)
        if WaitClick then return end
        WaitClick = true
        default = val

        if not skipCallback then
            pcall(callback, default)
        end

        if default then
            self:Tween(ToggleDot, {Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5)}, 0.25)
            self:Tween(ToggleDot, {BackgroundTransparency = 0}, 0.25)
        else
            self:Tween(ToggleDot, {Position = UDim2.new(0, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5)}, 0.25)
            self:Tween(ToggleDot, {BackgroundTransparency = 0.8}, 0.25)
        end

        task.delay(0.26, function()
            WaitClick = false
        end)
    end

    -- Initialize
    if default then
        ToggleDot.Position = UDim2.new(1, 0, 0.5, 0)
        ToggleDot.AnchorPoint = Vector2.new(1, 0.5)
        ToggleDot.BackgroundTransparency = 0
    else
        ToggleDot.Position = UDim2.new(0, 0, 0.5, 0)
        ToggleDot.AnchorPoint = Vector2.new(0, 0.5)
        ToggleDot.BackgroundTransparency = 0.8
    end

    Frame.Activated:Connect(function()
        SetToggle(not default)
    end)

    local Toggle = {}
    function Toggle:Set(val1, val2)
        if type(val1) == "string" and type(val2) == "string" then
            LabelFunc:SetTitle(val1)
            LabelFunc:SetDesc(val2)
        elseif type(val1) == "string" then
            LabelFunc:SetTitle(val1)
        elseif type(val1) == "boolean" then
            SetToggle(val1, not val2)
        elseif type(val1) == "function" then
            callback = val1
        end
    end
    function Toggle:GetState()
        return default
    end
    function Toggle:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Toggle:Destroy()
        Frame:Destroy()
    end
    return Toggle
end

-- CREATE SLIDER
function GenesisX:CreateSlider(tab, config)
    config = config or {}
    local sName = config.Text or config.Title or config[1] or "Slider"
    local sDesc = config.Desc or config.Description or ""
    local min = config.Min or config.MinValue or config[2] or 10
    local max = config.Max or config.MaxValue or config[3] or 100
    local increment = config.Increment or config[4] or 1
    local default = config.Default or config[5] or min
    local callback = config.Callback or config[6] or function() end
    local parent = self:_GetParent(tab, config)

    local realMin = min
    local realMax = max
    min, max = min / increment, max / increment

    local currentValue = default
    local isDragging = false

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, sName, sDesc)

    -- Slider Holder
    local SliderHolder = Instance.new("TextButton")
    SliderHolder.Name = "SliderHolder"
    SliderHolder.Size = UDim2.new(0.45, 0, 1, 0)
    SliderHolder.Position = UDim2.new(1, 0, 0, 0)
    SliderHolder.AnchorPoint = Vector2.new(1, 0)
    SliderHolder.AutoButtonColor = false
    SliderHolder.Text = ""
    SliderHolder.BackgroundTransparency = 1
    SliderHolder.ZIndex = 13
    SliderHolder.Parent = Frame

    -- Slider Bar
    local SliderBar = Instance.new("Frame")
    SliderBar.Name = "Bar"
    SliderBar.BackgroundColor3 = self.Theme.Stroke
    SliderBar.Size = UDim2.new(1, -20, 0, 6)
    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 0)
    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
    SliderBar.ZIndex = 13
    SliderBar.Parent = SliderHolder
    self:CreateCorner(SliderBar, UDim.new(0.5, 0))

    -- Indicator
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.BackgroundColor3 = self.Theme.Accent
    Indicator.Size = UDim2.new(0.3, 0, 1, 0)
    Indicator.BorderSizePixel = 0
    Indicator.ZIndex = 14
    Indicator.Parent = SliderBar
    self:CreateCorner(Indicator, UDim.new(0.5, 0))

    -- Slider Icon (Knob)
    local SliderIcon = Instance.new("Frame")
    SliderIcon.Name = "Knob"
    SliderIcon.Size = UDim2.new(0, 6, 0, 12)
    SliderIcon.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    SliderIcon.Position = UDim2.new(0.3, 0, 0.5, 0)
    SliderIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    SliderIcon.BackgroundTransparency = 0.2
    SliderIcon.ZIndex = 15
    SliderIcon.Parent = SliderBar
    self:CreateCorner(SliderIcon, UDim.new(0.5, 0))

    -- Value Label
    local LabelVal = Instance.new("TextLabel")
    LabelVal.Name = "Value"
    LabelVal.Size = UDim2.new(0, 20, 0, 14)
    LabelVal.AnchorPoint = Vector2.new(1, 0.5)
    LabelVal.Position = UDim2.new(0, 0, 0.5, 0)
    LabelVal.BackgroundTransparency = 1
    LabelVal.TextColor3 = self.Theme.Text
    LabelVal.Font = self:GetFontBold()
    LabelVal.TextSize = 10
    LabelVal.ZIndex = 13
    LabelVal.Parent = SliderHolder

    local BaseMousePos = Instance.new("Frame")
    BaseMousePos.Position = UDim2.new(0, 0, 0.5, 0)
    BaseMousePos.Visible = false
    BaseMousePos.Parent = SliderBar

    local isProgrammaticallySetting = false

    local function GetSteppedValue(value)
        local stepped = math.floor(value / increment + 0.5) * increment
        return math.clamp(stepped, realMin, realMax)
    end

    local function UpdateLabel(value)
        local num = tonumber(value)
        currentValue = num
        if num % 1 == 0 then
            LabelVal.Text = tostring(math.floor(num))
        else
            LabelVal.Text = string.format("%.1f", num)
        end
    end

    local function ControlPos()
        local mousePos = LocalPlayer:GetMouse()
        local aPos = mousePos.X - BaseMousePos.AbsolutePosition.X
        local scale = math.clamp(aPos / SliderBar.AbsoluteSize.X, 0, 1)
        SliderIcon.Position = UDim2.new(scale, 0, 0.5, 0)
    end

    local function UpdateValues()
        if isProgrammaticallySetting then return end
        Indicator.Size = UDim2.new(SliderIcon.Position.X.Scale, 0, 1, 0)
        local rawValue = SliderIcon.Position.X.Scale * (realMax - realMin) + realMin
        if not isDragging then
            local steppedValue = GetSteppedValue(rawValue)
            UpdateLabel(steppedValue)
            currentValue = steppedValue
        else
            currentValue = rawValue
        end
    end

    local function SetSlider(newValue)
        if type(newValue) ~= "number" or isProgrammaticallySetting then return end
        isProgrammaticallySetting = true
        newValue = math.clamp(newValue, realMin, realMax)
        local steppedValue = GetSteppedValue(newValue)
        local sliderPos = (steppedValue - realMin) / (realMax - realMin)
        SliderIcon.Position = UDim2.new(math.clamp(sliderPos, 0, 1), 0, 0.5, 0)
        currentValue = steppedValue
        pcall(callback, currentValue)
        UpdateLabel(steppedValue)
        Indicator.Size = UDim2.new(sliderPos, 0, 1, 0)
        isProgrammaticallySetting = false
    end

    local function InitializeSlider()
        default = math.clamp(default, realMin, realMax)
        local steppedValue = GetSteppedValue(default)
        local sliderPos = (steppedValue - realMin) / (realMax - realMin)
        currentValue = steppedValue
        SliderIcon.Position = UDim2.new(math.clamp(sliderPos, 0, 1), 0, 0.5, 0)
        UpdateLabel(steppedValue)
    end

    SliderHolder.MouseButton1Down:Connect(function()
        isDragging = true
        self:Tween(SliderIcon, {BackgroundTransparency = 0}, 0.3)
        while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
            task.wait()
            ControlPos()
        end
        self:Tween(SliderIcon, {BackgroundTransparency = 0.2}, 0.3)
        local finalValue = GetSteppedValue(currentValue)
        UpdateLabel(finalValue)
        currentValue = finalValue
        pcall(callback, currentValue)
        isDragging = false
    end)

    SliderIcon:GetPropertyChangedSignal("Position"):Connect(UpdateValues)
    UpdateValues()
    InitializeSlider()

    local Slider = {}
    function Slider:Set(val1, val2)
        if val1 and val2 then
            LabelFunc:SetTitle(tostring(val1))
            LabelFunc:SetDesc(tostring(val2))
        elseif type(val1) == "string" then
            LabelFunc:SetTitle(val1)
        elseif type(val1) == "function" then
            callback = val1
        elseif type(val1) == "number" then
            SetSlider(val1)
        end
    end
    function Slider:GetValue()
        return currentValue
    end
    function Slider:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Slider:Destroy()
        Frame:Destroy()
    end
    return Slider
end



-- CREATE DROPDOWN
function GenesisX:CreateDropdown(tab, config)
    config = config or {}
    local dName = config.Title or config[1] or "Dropdown"
    local dDesc = config.Desc or config.Description or ""
    local options = config.Options or config[2] or {}
    local default = config.Default or config[3] or nil
    local multiSelect = config.MultiSelect or false
    local callback = config.Callback or config[4] or function() end
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, dName, dDesc)

    -- Selected Frame
    local SelectedFrame = Instance.new("Frame")
    SelectedFrame.Name = "SelectedFrame"
    SelectedFrame.Size = UDim2.new(0, 150, 0, 18)
    SelectedFrame.Position = UDim2.new(1, -10, 0.5, 0)
    SelectedFrame.AnchorPoint = Vector2.new(1, 0.5)
    SelectedFrame.BackgroundColor3 = self.Theme.Stroke
    SelectedFrame.ZIndex = 13
    SelectedFrame.Parent = Frame
    self:CreateCorner(SelectedFrame, UDim.new(0, 4))

    local ActiveLabel = Instance.new("TextLabel")
    ActiveLabel.Name = "ActiveLabel"
    ActiveLabel.Size = UDim2.new(0.85, 0, 0.85, 0)
    ActiveLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ActiveLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ActiveLabel.BackgroundTransparency = 1
    ActiveLabel.Font = self:GetFontBold()
    ActiveLabel.TextScaled = true
    ActiveLabel.TextColor3 = self.Theme.Text
    ActiveLabel.Text = default or "..."
    ActiveLabel.ZIndex = 14
    ActiveLabel.Parent = SelectedFrame

    local Arrow = Instance.new("ImageLabel")
    Arrow.Name = "Arrow"
    Arrow.Size = UDim2.new(0, 15, 0, 15)
    Arrow.Position = UDim2.new(0, -5, 0.5, 0)
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.Image = self:FormatAssetId("chevron-up") or "rbxassetid://10709791523"
    Arrow.BackgroundTransparency = 1
    Arrow.ZIndex = 14
    Arrow.Parent = SelectedFrame

    -- Dropdown Overlay
    local NoClickFrame = Instance.new("TextButton")
    NoClickFrame.Name = "AntiClick"
    NoClickFrame.Size = UDim2.new(1, 0, 1, 0)
    NoClickFrame.BackgroundTransparency = 1
    NoClickFrame.Visible = false
    NoClickFrame.Text = ""
    NoClickFrame.ZIndex = 100
    NoClickFrame.Parent = self.DropdownHolder

    local DropFrame = Instance.new("Frame")
    DropFrame.Name = "DropFrame"
    DropFrame.Size = UDim2.new(0, 152, 0, 0)
    DropFrame.BackgroundTransparency = 0.1
    DropFrame.BackgroundColor3 = self.Theme.Background
    DropFrame.AnchorPoint = Vector2.new(0, 1)
    DropFrame.ClipsDescendants = true
    DropFrame.Active = true
    DropFrame.ZIndex = 101
    DropFrame.Parent = NoClickFrame
    self:CreateCorner(DropFrame)
    self:CreateStroke(DropFrame)
    self:CreateGradient(DropFrame, self.Theme.Gradient, 60)

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "Scroll"
    ScrollFrame.ScrollBarImageColor3 = self.Theme.Accent
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.ScrollBarThickness = 1.5
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.Active = true
    ScrollFrame.ZIndex = 102
    ScrollFrame.Parent = DropFrame

    local sfPad = Instance.new("UIPadding")
    sfPad.PaddingLeft = UDim.new(0, 8)
    sfPad.PaddingRight = UDim.new(0, 8)
    sfPad.PaddingTop = UDim.new(0, 5)
    sfPad.PaddingBottom = UDim.new(0, 5)
    sfPad.Parent = ScrollFrame

    local sfLayout = Instance.new("UIListLayout")
    sfLayout.Padding = UDim.new(0, 4)
    sfLayout.Parent = ScrollFrame

    local ScrollSize = 5
    local WaitClick = false

    local function Disable()
        WaitClick = true
        self:Tween(Arrow, {Rotation = 0}, 0.2)
        self:Tween(DropFrame, {Size = UDim2.new(0, 152, 0, 0)}, 0.2)
        NoClickFrame.Visible = false
        WaitClick = false
    end

    local function GetFrameSize()
        return UDim2.fromOffset(152, math.clamp(ScrollSize, 0, 250))
    end

    local function CalculateSize()
        local count = 0
        for _, child in pairs(ScrollFrame:GetChildren()) do
            if child:IsA("Frame") or child.Name == "Option" then
                count = count + 1
            end
        end
        ScrollSize = (math.clamp(count, 0, 10) * 25) + 10
        if NoClickFrame.Visible then
            self:Tween(DropFrame, {Size = GetFrameSize()}, 0.2)
        end
    end

    local function CalculatePos()
        local framePos = SelectedFrame.AbsolutePosition
        local screenSize = self.ScreenGui.AbsoluteSize
        local clampX = math.clamp(framePos.X, 0, screenSize.X - DropFrame.Size.X.Offset)
        local clampY = math.clamp(framePos.Y, 0, screenSize.Y)
        local anchorPoint = framePos.Y > screenSize.Y / 1.4 and 1 or (ScrollSize > 80 and 0.5 or 0)
        DropFrame.AnchorPoint = Vector2.new(0, anchorPoint)
        DropFrame.Position = UDim2.fromOffset(clampX, clampY)
    end

    -- Options Management
    local selected = multiSelect and {} or (default or nil)
    if multiSelect and type(default) == "table" then
        for _, v in ipairs(default) do
            selected[v] = true
        end
    end

    local Options = {}

    local function UpdateLabel()
        if multiSelect then
            local list = {}
            for name, val in pairs(selected) do
                if val then
                    table.insert(list, name)
                end
            end
            ActiveLabel.Text = #list > 0 and table.concat(list, ", ") or "..."
        else
            ActiveLabel.Text = tostring(selected or "...")
        end
    end

    local function UpdateSelected()
        if multiSelect then
            for _, v in pairs(Options) do
                local nodes = v.nodes
                self:Tween(nodes[2], {BackgroundTransparency = v.Stats and 0 or 0.8}, 0.35)
                self:Tween(nodes[2], {Size = v.Stats and UDim2.fromOffset(4, 12) or UDim2.fromOffset(4, 4)}, 0.35)
                self:Tween(nodes[3], {TextTransparency = v.Stats and 0 or 0.4}, 0.35)
            end
        else
            for _, v in pairs(Options) do
                local isSel = v.Value == selected
                local nodes = v.nodes
                self:Tween(nodes[2], {BackgroundTransparency = isSel and 0 or 1}, 0.35)
                self:Tween(nodes[2], {Size = isSel and UDim2.fromOffset(4, 14) or UDim2.fromOffset(4, 4)}, 0.35)
                self:Tween(nodes[3], {TextTransparency = isSel and 0 or 0.4}, 0.35)
            end
        end
        UpdateLabel()
    end

    local function Select(option)
        if multiSelect then
            option.Stats = not option.Stats
            selected[option.Name] = option.Stats
            pcall(callback, selected)
        else
            selected = option.Value
            pcall(callback, selected)
        end
        UpdateSelected()
    end

    local function AddOption(index, value)
        local name = tostring(type(index) == "string" and index or value)
        if Options[name] then return end

        Options[name] = {
            index = index,
            Value = value,
            Name = name,
            Stats = false,
        }

        if multiSelect then
            local stats = selected[name]
            selected[name] = stats or false
            Options[name].Stats = stats
        end

        local Button = Instance.new("TextButton")
        Button.Name = "Option"
        Button.Size = UDim2.new(1, 0, 0, 21)
        Button.BackgroundColor3 = self.Theme.Card
        Button.BackgroundTransparency = 1
        Button.Text = ""
        Button.AutoButtonColor = false
        Button.ZIndex = 103
        Button.Parent = ScrollFrame
        self:CreateCorner(Button, UDim.new(0, 4))

        local IsSelected = Instance.new("Frame")
        IsSelected.Position = UDim2.new(0, 1, 0.5, 0)
        IsSelected.Size = UDim2.new(0, 4, 0, 4)
        IsSelected.AnchorPoint = Vector2.new(0, 0.5)
        IsSelected.BackgroundColor3 = self.Theme.Accent
        IsSelected.BackgroundTransparency = 1
        IsSelected.ZIndex = 104
        IsSelected.Parent = Button
        self:CreateCorner(IsSelected, UDim.new(0.5, 0))

        local OptionName = Instance.new("TextLabel")
        OptionName.Size = UDim2.new(1, 0, 1, 0)
        OptionName.Position = UDim2.new(0, 10, 0, 0)
        OptionName.Text = name
        OptionName.TextColor3 = self.Theme.Text
        OptionName.Font = self:GetFontBold()
        OptionName.TextXAlignment = Enum.TextXAlignment.Left
        OptionName.BackgroundTransparency = 1
        OptionName.TextTransparency = 0.4
        OptionName.ZIndex = 104
        OptionName.Parent = Button

        Button.MouseEnter:Connect(function()
            self:Tween(Button, {BackgroundTransparency = 0.8}, 0.1)
        end)
        Button.MouseLeave:Connect(function()
            self:Tween(Button, {BackgroundTransparency = 1}, 0.1)
        end)
        Button.Activated:Connect(function()
            Select(Options[name])
        end)

        Options[name].nodes = {Button, IsSelected, OptionName}
    end

    local function RemoveOption(index, value)
        local name = tostring(type(index) == "string" and index or value)
        if Options[name] then
            Options[name].nodes[1]:Destroy()
            Options[name] = nil
        end
    end

    local function AddNewOptions(list, clear)
        if clear then
            for name, _ in pairs(Options) do
                RemoveOption(name, name)
            end
        end
        for i, v in ipairs(list) do
            AddOption(i, v)
        end
        UpdateSelected()
        CalculateSize()
    end

    AddNewOptions(options)
    UpdateLabel()

    local function Minimize()
        if WaitClick then return end
        WaitClick = true
        CalculatePos()
        if NoClickFrame.Visible then
            self:Tween(DropFrame, {Size = UDim2.new(0, 152, 0, 0)}, 0.2)
            NoClickFrame.Visible = false
        else
            NoClickFrame.Visible = true
            self:Tween(DropFrame, {Size = GetFrameSize()}, 0.2)
        end
        WaitClick = false
    end

    Frame.Activated:Connect(Minimize)
    NoClickFrame.MouseButton1Down:Connect(Disable)
    NoClickFrame.MouseButton1Click:Connect(Disable)

    local Dropdown = {}
    function Dropdown:Add(...)
        local newOptions = {...}
        if type(newOptions[1]) == "table" then
            for _, name in ipairs(newOptions[1]) do
                AddOption(name, name)
            end
        else
            for _, name in ipairs(newOptions) do
                AddOption(name, name)
            end
        end
        CalculateSize()
    end
    function Dropdown:Remove(option)
        for name, val in pairs(Options) do
            if name == option then
                RemoveOption(name, val.Value)
            end
        end
        CalculateSize()
    end
    function Dropdown:Select(option)
        for name, val in pairs(Options) do
            if name == option then
                Select(val)
                return
            end
        end
    end
    function Dropdown:Set(val1, clear)
        if type(val1) == "table" then
            AddNewOptions(val1, not clear)
        elseif type(val1) == "function" then
            callback = val1
        end
    end
    function Dropdown:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Dropdown:Destroy()
        Frame:Destroy()
    end
    return Dropdown
end

-- CREATE INPUT (TextBox)
function GenesisX:CreateInput(tab, config)
    config = config or {}
    local tName = config.Label or config.Title or config[1] or "Input"
    local tDesc = config.Desc or config.Description or ""
    local default = config.Default or config[2] or ""
    local placeholder = config.Placeholder or config.PlaceholderText or "Input"
    local clearOnFocus = config.ClearText or false
    local callback = config.Callback or config[3] or function() end
    local numeric = config.Numeric or false
    local min = config.Min or -math.huge
    local max = config.Max or math.huge
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, tName, tDesc)

    -- Input Frame
    local InputFrame = Instance.new("Frame")
    InputFrame.Name = "InputFrame"
    InputFrame.Size = UDim2.new(0, 150, 0, 18)
    InputFrame.Position = UDim2.new(1, -10, 0.5, 0)
    InputFrame.AnchorPoint = Vector2.new(1, 0.5)
    InputFrame.BackgroundColor3 = self.Theme.Stroke
    InputFrame.ZIndex = 13
    InputFrame.Parent = Frame
    self:CreateCorner(InputFrame, UDim.new(0, 4))

    local TextBox = Instance.new("TextBox")
    TextBox.Name = "TextBox"
    TextBox.Size = UDim2.new(0.85, 0, 0.85, 0)
    TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
    TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextBox.BackgroundTransparency = 1
    TextBox.Font = self:GetFontBold()
    TextBox.TextScaled = true
    TextBox.TextColor3 = self.Theme.Text
    TextBox.ClearTextOnFocus = clearOnFocus
    TextBox.PlaceholderText = placeholder
    TextBox.PlaceholderColor3 = self.Theme.TextMuted
    TextBox.Text = tostring(default)
    TextBox.ZIndex = 14
    TextBox.Parent = InputFrame

    local Pencil = Instance.new("ImageLabel")
    Pencil.Name = "Pencil"
    Pencil.Size = UDim2.new(0, 12, 0, 12)
    Pencil.Position = UDim2.new(0, -5, 0.5, 0)
    Pencil.AnchorPoint = Vector2.new(1, 0.5)
    Pencil.Image = self:FormatAssetId("pencil") or "rbxassetid://15637081879"
    Pencil.BackgroundTransparency = 1
    Pencil.ZIndex = 14
    Pencil.Parent = InputFrame

    local function Input()
        local text = TextBox.Text
        if text:gsub(" ", ""):len() > 0 then
            if numeric then
                local value = tonumber(text)
                if value then
                    value = math.clamp(value, min, max)
                    TextBox.Text = tostring(value)
                    pcall(callback, value)
                end
            else
                pcall(callback, text)
            end
        end
    end

    TextBox.FocusLost:Connect(Input)
    TextBox.FocusLost:Connect(function()
        self:Tween(Pencil, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
    end)
    TextBox.Focused:Connect(function()
        self:Tween(Pencil, {ImageColor3 = self.Theme.Accent}, 0.2)
    end)

    -- Fire callback with default
    task.delay(0.1, function()
        pcall(callback, default)
    end)

    local InputObj = {}
    function InputObj:Set(text)
        TextBox.Text = tostring(text)
        Input()
    end
    function InputObj:GetText()
        return TextBox.Text
    end
    function InputObj:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function InputObj:Destroy()
        Frame:Destroy()
    end
    return InputObj
end

-- CREATE LABEL
function GenesisX:CreateLabel(tab, config)
    config = type(config) == "string" and {Text = config} or (config or {})
    local text = config.Text or config[1] or "Label"
    local color = config.Color or self.Theme.Text
    local parent = self:_GetParent(tab, config)

    local Frame = Instance.new("Frame")
    Frame.Name = "Label"
    Frame.BackgroundColor3 = self.Theme.Card
    Frame.Size = UDim2.new(1, 0, 0, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.ZIndex = 12
    Frame.Parent = parent
    self:CreateCorner(Frame, UDim.new(0, 6))

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 0)
    Label.AutomaticSize = Enum.AutomaticSize.Y
    Label.Font = self:GetFontSemibold()
    Label.Text = text
    Label.TextColor3 = color
    Label.TextSize = 10
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.ZIndex = 13
    Label.Parent = Frame

    local LabelObj = {}
    function LabelObj:Set(newText)
        Label.Text = tostring(newText)
    end
    function LabelObj:SetColor(newColor)
        Label.TextColor3 = newColor
    end
    function LabelObj:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function LabelObj:Destroy()
        Frame:Destroy()
    end
    return LabelObj
end

-- CREATE SEPARATOR
function GenesisX:CreateSeparator(tab, config)
    local parent = tab.Left or tab
    local Frame = Instance.new("Frame")
    Frame.Name = "Separator"
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 8)
    Frame.ZIndex = 12
    Frame.Parent = parent
    return Frame
end

-- CREATE KEYBIND
function GenesisX:CreateKeybind(tab, config)
    config = config or {}
    local kName = config.Title or config[1] or "Keybind"
    local kDesc = config.Desc or config.Description or ""
    local default = config.Default or config[2] or "None"
    local callback = config.Callback or config[3] or function() end
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, kName, kDesc)

    -- Keybind Frame
    local KeyFrame = Instance.new("TextButton")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 60, 0, 18)
    KeyFrame.Position = UDim2.new(1, -10, 0.5, 0)
    KeyFrame.AnchorPoint = Vector2.new(1, 0.5)
    KeyFrame.BackgroundColor3 = self.Theme.Stroke
    KeyFrame.Text = ""
    KeyFrame.AutoButtonColor = false
    KeyFrame.ZIndex = 13
    KeyFrame.Parent = Frame
    self:CreateCorner(KeyFrame, UDim.new(0, 4))

    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Name = "Label"
    KeyLabel.Size = UDim2.new(1, 0, 1, 0)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Font = self:GetFontBold()
    KeyLabel.Text = tostring(default)
    KeyLabel.TextColor3 = self.Theme.Text
    KeyLabel.TextSize = 9
    KeyLabel.ZIndex = 14
    KeyLabel.Parent = KeyFrame

    local Listening = false
    local CurrentKey = default

    KeyFrame.Activated:Connect(function()
        if Listening then return end
        Listening = true
        KeyLabel.Text = "..."
        self:Tween(KeyFrame, {BackgroundColor3 = self.Theme.Accent}, 0.2)

        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                CurrentKey = input.KeyCode.Name
                KeyLabel.Text = CurrentKey
                self:Tween(KeyFrame, {BackgroundColor3 = self.Theme.Stroke}, 0.2)
                Listening = false
                pcall(callback, CurrentKey)
                if connection then connection:Disconnect() end
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.MouseButton2 then
                CurrentKey = input.UserInputType.Name
                KeyLabel.Text = CurrentKey
                self:Tween(KeyFrame, {BackgroundColor3 = self.Theme.Stroke}, 0.2)
                Listening = false
                pcall(callback, CurrentKey)
                if connection then connection:Disconnect() end
            end
        end)

        task.delay(5, function()
            if Listening then
                Listening = false
                KeyLabel.Text = tostring(CurrentKey)
                self:Tween(KeyFrame, {BackgroundColor3 = self.Theme.Stroke}, 0.2)
                if connection then connection:Disconnect() end
            end
        end)
    end)

    -- Listen for keybind press
    UserInputService.InputBegan:Connect(function(input)
        if Listening then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode.Name == CurrentKey then
                pcall(callback, CurrentKey)
            end
        end
    end)

    local Keybind = {}
    function Keybind:Set(key)
        CurrentKey = tostring(key)
        KeyLabel.Text = CurrentKey
    end
    function Keybind:GetKey()
        return CurrentKey
    end
    function Keybind:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function Keybind:Destroy()
        Frame:Destroy()
    end
    return Keybind
end

-- CREATE COLOR PICKER
function GenesisX:CreateColorPicker(tab, config)
    config = config or {}
    local cName = config.Title or config[1] or "Color"
    local cDesc = config.Desc or config.Description or ""
    local default = config.Default or config[2] or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or config[3] or function() end
    local parent = self:_GetParent(tab, config)

    local Frame, LabelFunc = self:_CreateOptionFrame(parent, cName, cDesc)

    -- Color Frame
    local ColorFrame = Instance.new("TextButton")
    ColorFrame.Name = "ColorFrame"
    ColorFrame.Size = UDim2.new(0, 40, 0, 18)
    ColorFrame.Position = UDim2.new(1, -10, 0.5, 0)
    ColorFrame.AnchorPoint = Vector2.new(1, 0.5)
    ColorFrame.BackgroundColor3 = default
    ColorFrame.Text = ""
    ColorFrame.AutoButtonColor = false
    ColorFrame.ZIndex = 13
    ColorFrame.Parent = Frame
    self:CreateCorner(ColorFrame, UDim.new(0, 4))
    self:CreateStroke(ColorFrame, self.Theme.Stroke, 1, 0.3)

    local CurrentColor = default

    ColorFrame.Activated:Connect(function()
        -- Simple RGB input dialog
        local R = math.floor(CurrentColor.R * 255)
        local G = math.floor(CurrentColor.G * 255)
        local B = math.floor(CurrentColor.B * 255)

        -- Toggle through preset colors for simplicity
        local presets = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(0, 0, 0),
        }
        local currentIndex = 1
        for i, preset in ipairs(presets) do
            if preset == CurrentColor then
                currentIndex = i
                break
            end
        end
        CurrentColor = presets[(currentIndex % #presets) + 1]
        self:Tween(ColorFrame, {BackgroundColor3 = CurrentColor}, 0.2)
        pcall(callback, CurrentColor)
    end)

    local ColorPicker = {}
    function ColorPicker:Set(color)
        CurrentColor = color
        self:Tween(ColorFrame, {BackgroundColor3 = CurrentColor}, 0.2)
        pcall(callback, CurrentColor)
    end
    function ColorPicker:GetColor()
        return CurrentColor
    end
    function ColorPicker:Visible(bool)
        Frame.Visible = bool ~= false
    end
    function ColorPicker:Destroy()
        Frame:Destroy()
    end
    return ColorPicker
end



-- NOTIFICATIONS
function GenesisX:Notify(config)
    config = config or {}
    local message   = config.Text or config[1] or "Notification"
    local title     = config.Title or nil
    local subtitle  = config.Subtitle or nil
    local subtitles = config.Subtitles or nil
    local ntype     = config.Type or "info"
    local duration  = config.Duration or 4

    self:UpdateScale()

    local W  = self:S(ScaleData.IsMobile and 300 or 340)
    local PAD_RIGHT  = self:S(14)
    local PAD_BOTTOM = self:S(14)
    local GAP        = self:S(8)

    local typeColors = {
        success = Color3.fromRGB(80, 200, 80),
        warning = Color3.fromRGB(255, 180, 50),
        error   = Color3.fromRGB(230, 70, 70),
        info    = self.Theme.Accent,
    }
    local typeIcons = {
        success = "check-circle",
        warning = "alert-triangle",
        error   = "x-circle",
        info    = "info",
    }
    local accentColor = typeColors[ntype] or self.Theme.Accent
    local iconName    = typeIcons[ntype] or "info"

    local function viewport()
        local ok, cam = pcall(function() return workspace.CurrentCamera end)
        return (ok and cam) and cam.ViewportSize or Vector2.new(1366, 768)
    end

    -- Calculate height
    local totalH = self:S(60)
    if subtitles and #subtitles > 0 then
        totalH = totalH + (#subtitles * self:S(16))
    elseif subtitle then
        totalH = totalH + self:S(16)
    end

    -- Notification Frame
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.BackgroundColor3 = self.Theme.Background
    notif.BorderSizePixel = 0
    notif.Size = UDim2.fromOffset(W, totalH)
    notif.ClipsDescendants = true
    notif.ZIndex = 5000
    notif.Parent = self.ScreenGui
    self:CreateCorner(notif, UDim.new(0, 10))
    self:CreateStroke(notif, accentColor, 1.5, 0.3)

    -- Accent bar
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.BackgroundColor3 = accentColor
    accentBar.BorderSizePixel = 0
    accentBar.Size = UDim2.new(0, self:S(3), 1, 0)
    accentBar.Position = UDim2.new(0, 0, 0, 0)
    accentBar.ZIndex = 5001
    accentBar.Parent = notif
    self:CreateCorner(accentBar, UDim.new(0, 10))

    -- Icon
    local iconSize = self:S(20)
    local iconImg = Instance.new("ImageLabel")
    iconImg.Name = "Icon"
    iconImg.BackgroundTransparency = 1
    iconImg.Size = UDim2.fromOffset(iconSize, iconSize)
    iconImg.Position = UDim2.new(0, self:S(14), 0.5, 0)
    iconImg.AnchorPoint = Vector2.new(0, 0.5)
    iconImg.Image = self:FormatAssetId(iconName) or ""
    iconImg.ImageColor3 = accentColor
    iconImg.ZIndex = 5002
    iconImg.Parent = notif

    -- Content
    local contentX = self:S(42)
    local contentW = W - contentX - self:S(30)

    local contentArea = Instance.new("Frame")
    contentArea.Name = "Content"
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, contentX, 0, self:S(8))
    contentArea.Size = UDim2.new(0, contentW, 1, -self:S(12))
    contentArea.ZIndex = 5001
    contentArea.Parent = notif

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, self:S(18))
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = title or message
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = self:S(11)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 5002
    titleLabel.Parent = contentArea

    -- Subtitle(s)
    if subtitles and #subtitles > 0 then
        for i, subText in ipairs(subtitles) do
            local subLabel = Instance.new("TextLabel")
            subLabel.Name = "Subtitle" .. i
            subLabel.BackgroundTransparency = 1
            subLabel.Position = UDim2.new(0, 0, 0, self:S(18) + ((i-1) * self:S(15)))
            subLabel.Size = UDim2.new(1, 0, 0, self:S(14))
            subLabel.Font = self:GetFont()
            subLabel.Text = subText
            subLabel.TextColor3 = self.Theme.TextMuted
            subLabel.TextSize = self:S(10)
            subLabel.TextXAlignment = Enum.TextXAlignment.Left
            subLabel.ZIndex = 5002
            subLabel.Parent = contentArea
        end
    elseif subtitle then
        local subLabel = Instance.new("TextLabel")
        subLabel.Name = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position = UDim2.new(0, 0, 0, self:S(18))
        subLabel.Size = UDim2.new(1, 0, 0, self:S(14))
        subLabel.Font = self:GetFont()
        subLabel.Text = subtitle
        subLabel.TextColor3 = self.Theme.TextMuted
        subLabel.TextSize = self:S(10)
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        subLabel.ZIndex = 5002
        subLabel.Parent = contentArea
    elseif not title then
        -- Use message as subtitle
    else
        -- Title + message
        local subLabel = Instance.new("TextLabel")
        subLabel.Name = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position = UDim2.new(0, 0, 0, self:S(18))
        subLabel.Size = UDim2.new(1, 0, 0, self:S(14))
        subLabel.Font = self:GetFont()
        subLabel.Text = message
        subLabel.TextColor3 = self.Theme.TextMuted
        subLabel.TextSize = self:S(10)
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        subLabel.ZIndex = 5002
        subLabel.Parent = contentArea
    end

    -- Close button
    local closeSize = self:S(16)
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name = "Close"
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position = UDim2.new(1, -self:S(22), 0, self:S(8))
    closeBtn.Size = UDim2.fromOffset(closeSize, closeSize)
    closeBtn.Image = self:FormatAssetId("x") or "rbxassetid://10747384394"
    closeBtn.ImageColor3 = self.Theme.TextMuted
    closeBtn.ZIndex = 5003
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = notif

    closeBtn.MouseEnter:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = Color3.new(1, 1, 1)}, 0.1)
    end)
    closeBtn.MouseLeave:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = self.Theme.TextMuted}, 0.1)
    end)

    -- Register and position
    table.insert(self._notifications, notif)
    local myIndex = #self._notifications

    local function targetX()
        return viewport().X - W - PAD_RIGHT
    end
    local function offscreenX()
        return viewport().X + W + 60
    end
    local function bottomY(index)
        return viewport().Y - (totalH + PAD_BOTTOM) * index - GAP * (index - 1)
    end

    local function restack(animated)
        local count = 0
        for i = 1, #self._notifications do
            if self._notifications[i] and self._notifications[i].Parent then
                count = count + 1
                local idx = count
                local yPos = bottomY(idx)
                local xPos = targetX()
                if animated then
                    self:Tween(self._notifications[i], {Position = UDim2.fromOffset(xPos, yPos)}, 0.25)
                else
                    self._notifications[i].Position = UDim2.fromOffset(xPos, yPos)
                end
            end
        end
    end

    -- Initial position
    local yPos = bottomY(#self._notifications)
    notif.Position = UDim2.fromOffset(offscreenX(), yPos)

    -- Animate in
    self:Tween(notif, {Position = UDim2.fromOffset(targetX(), yPos)}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    restack(true)

    -- Dismiss
    local dismissed = false
    local function dismiss()
        if dismissed then return end
        dismissed = true
        for i = #self._notifications, 1, -1 do
            if self._notifications[i] == notif then
                table.remove(self._notifications, i)
                break
            end
        end
        self:Tween(notif, {Position = UDim2.fromOffset(offscreenX(), notif.AbsolutePosition.Y)}, 0.28)
        task.delay(0.05, function() restack(true) end)
        task.delay(0.32, function()
            if notif and notif.Parent then notif:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)
    notif.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            if not dismissed then dismiss() end
        end
    end)
    task.delay(duration, function() if not dismissed then dismiss() end end)

    return {
        Destroy = dismiss,
        SetTitle = function(t) titleLabel.Text = t end,
    }
end

-- DIALOG
function GenesisX:Dialog(config)
    config = config or {}
    local dTitle = config.Title or config[1] or "Dialog"
    local dText = config.Text or config[2] or "Are you sure?"
    local dOptions = config.Options or config[3] or {}

    if self.MainFrame:FindFirstChild("DialogOverlay") then return end

    local overlay = Instance.new("Frame")
    overlay.Name = "DialogOverlay"
    overlay.BackgroundColor3 = self.Theme.Background
    overlay.BackgroundTransparency = 0.6
    overlay.Active = true
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 2000
    overlay.Parent = self.MainFrame
    self:CreateCorner(overlay)

    local dialogFrame = Instance.new("Frame")
    dialogFrame.Name = "DialogFrame"
    dialogFrame.Size = UDim2.fromOffset(260, 140)
    dialogFrame.Position = UDim2.fromScale(0.5, 0.5)
    dialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    dialogFrame.BackgroundColor3 = self.Theme.Card
    dialogFrame.ZIndex = 2001
    dialogFrame.Parent = overlay
    self:CreateCorner(dialogFrame, UDim.new(0, 10))
    self:CreateGradient(dialogFrame, self.Theme.Gradient, 270)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.Position = UDim2.new(0, 0, 0, 8)
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = dTitle
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = 14
    titleLabel.ZIndex = 2002
    titleLabel.Parent = dialogFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -20, 0, 40)
    textLabel.Position = UDim2.new(0, 10, 0, 32)
    textLabel.Font = self:GetFont()
    textLabel.Text = dText
    textLabel.TextColor3 = self.Theme.TextMuted
    textLabel.TextSize = 11
    textLabel.TextWrapped = true
    textLabel.ZIndex = 2002
    textLabel.Parent = dialogFrame

    local buttonsHolder = Instance.new("Frame")
    buttonsHolder.Name = "Buttons"
    buttonsHolder.Size = UDim2.new(1, 0, 0, 32)
    buttonsHolder.Position = UDim2.new(0, 0, 1, -10)
    buttonsHolder.AnchorPoint = Vector2.new(0, 1)
    buttonsHolder.BackgroundTransparency = 1
    buttonsHolder.ZIndex = 2002
    buttonsHolder.Parent = dialogFrame

    local blayout = Instance.new("UIListLayout")
    blayout.Padding = UDim.new(0, 8)
    blayout.VerticalAlignment = Enum.VerticalAlignment.Center
    blayout.FillDirection = Enum.FillDirection.Horizontal
    blayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    blayout.Parent = buttonsHolder

    local btnCount = 0
    local function AddButton(btnConfig)
        local name = btnConfig.Name or btnConfig[1] or "OK"
        local cb = btnConfig.Callback or btnConfig[2] or function() end
        btnCount = btnCount + 1

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1 / #dOptions, -(((#dOptions - 1) * 12) / #dOptions), 0, 28)
        btn.BackgroundColor3 = self.Theme.Card
        btn.Text = name
        btn.Font = self:GetFontBold()
        btn.TextColor3 = self.Theme.Text
        btn.TextSize = 11
        btn.AutoButtonColor = false
        btn.ZIndex = 2003
        btn.Parent = buttonsHolder
        self:CreateCorner(btn, UDim.new(0, 6))

        btn.MouseEnter:Connect(function()
            self:Tween(btn, {BackgroundColor3 = self.Theme.CardHover}, 0.15)
        end)
        btn.MouseLeave:Connect(function()
            self:Tween(btn, {BackgroundColor3 = self.Theme.Card}, 0.15)
        end)
        btn.Activated:Connect(function()
            self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
            self:Tween(dialogFrame, {Size = UDim2.fromOffset(260 * 1.08, 140 * 1.08)}, 0.2)
            task.delay(0.2, function()
                overlay:Destroy()
            end)
            pcall(cb)
        end)
    end

    for _, btnData in ipairs(dOptions) do
        AddButton(btnData)
    end

    return {
        Close = function()
            overlay:Destroy()
        end
    }
end

-- SET THEME
function GenesisX:SetTheme(newTheme)
    if type(newTheme) == "string" and self.Themes[newTheme] then
        self.Theme = self.Themes[newTheme]
        self:_SaveConfigFile("theme.json", newTheme)
    elseif type(newTheme) == "table" then
        self.Theme = newTheme
    end

    -- Update all UI elements
    if self.ScreenGui then
        for _, obj in ipairs(self.ScreenGui:GetDescendants()) do
            if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
                -- Update strokes
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("UIStroke") then
                        child.Color = self.Theme.Stroke
                    end
                    if child:IsA("UIGradient") then
                        child.Color = self.Theme.Gradient
                    end
                end
            end
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                if obj.TextColor3 ~= Color3.new(1, 1, 1) and obj.TextColor3 ~= self.Theme.TextMuted then
                    obj.TextColor3 = self.Theme.Text
                end
            end
            if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                if obj.ImageColor3 ~= Color3.new(1, 1, 1) then
                    obj.ImageColor3 = self.Theme.Text
                end
            end
        end
    end
end

-- DESTROY / UTILITIES
function GenesisX:Destroy()
    if self.ScreenGui then self.ScreenGui:Destroy() end
end

function GenesisX:GetWindow()
    return self.MainFrame
end

function GenesisX:SetVisible(visible)
    if self.MainFrame then self.MainFrame.Visible = visible end
end

function GenesisX:Toggle()
    if self.MainFrame then self:SetVisible(not self.MainFrame.Visible) end
end

function GenesisX:SetPosition(position)
    if self.MainFrame then self.MainFrame.Position = position end
end

function GenesisX:SetSize(size)
    if self.MainFrame then self.MainFrame.Size = size end
end

-- Aliases / Compatibilidade
local env = (getgenv and getgenv()) or _G or {}
env.GenesisX = GenesisX
env.SpectrumX = GenesisX

return GenesisX
