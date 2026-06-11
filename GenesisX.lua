--[[
    GenesisV2 - Fusão da API da GenesisX com o visual da redzlib (CORRIGIDO)
    - Layout com abas, cada aba com Left/Right
    - Ícones dinâmicos (repositório remoto)
    - Sistema de flags (salvamento automático)
    - Estilo visual da redzlib (gradientes, strokes, temas)
    - Métodos: CreateTab, CreateSection, CreateToggle, CreateButton, CreateSlider,
      CreateDropdown, CreateMultiDropdown, CreateInput, CreateLabel, CreateSeparator,
      Notify, Dialog
    - Nome global: GenesisV2, GenesisX, SpectrumX
]]

local GenesisV2 = {}
GenesisV2.__index = GenesisV2

-- Serviços
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

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
--        TEMAS (redzlib)
-- ==============================
GenesisV2.Themes = {
    Darker = {
        ["Color Hub 1"] = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
        }),
        ["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(88, 101, 242),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180)
    },
    Dark = {
        ["Color Hub 1"] = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(47.5, 47.5, 47.5)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
        }),
        ["Color Hub 2"] = Color3.fromRGB(45, 45, 45),
        ["Color Stroke"] = Color3.fromRGB(65, 65, 65),
        ["Color Theme"] = Color3.fromRGB(65, 150, 255),
        ["Color Text"] = Color3.fromRGB(245, 245, 245),
        ["Color Dark Text"] = Color3.fromRGB(190, 190, 190)
    },
    Purple = {
        ["Color Hub 1"] = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27.5, 25, 30)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(27.5, 25, 30))
        }),
        ["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(150, 0, 255),
        ["Color Text"] = Color3.fromRGB(240, 240, 240),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180)
    },
    Green = {
        ["Color Hub 1"] = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 35, 25)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 45, 35)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 35, 25))
        }),
        ["Color Hub 2"] = Color3.fromRGB(25, 40, 30),
        ["Color Stroke"] = Color3.fromRGB(35, 55, 40),
        ["Color Theme"] = Color3.fromRGB(50, 205, 50),
        ["Color Text"] = Color3.fromRGB(235, 245, 235),
        ["Color Dark Text"] = Color3.fromRGB(180, 200, 180)
    },
    Orange = {
        ["Color Hub 1"] = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 25, 15)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(55, 35, 25)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 25, 15))
        }),
        ["Color Hub 2"] = Color3.fromRGB(45, 30, 20),
        ["Color Stroke"] = Color3.fromRGB(60, 40, 25),
        ["Color Theme"] = Color3.fromRGB(255, 140, 0),
        ["Color Text"] = Color3.fromRGB(250, 240, 230),
        ["Color Dark Text"] = Color3.fromRGB(200, 160, 120)
    }
}

GenesisV2.Theme = GenesisV2.Themes.Purple

-- ==============================
--       CONFIGURAÇÕES
-- ==============================
GenesisV2.Config = {
    AnimationSpeed = 0.2,
    CornerRadius = 7,
}

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
    stroke.Color = color or self.Theme["Color Stroke"]
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function GenesisV2:CreateGradient(parent, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = self.Theme["Color Hub 1"]
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    return gradient
end

function GenesisV2:MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging = false
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
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch) then
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
    
    -- Carregar flags salvos
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
    local themeName = config.Theme or "Purple"
    self.Theme = self.Themes[themeName] or self.Themes.Purple
    
    -- ScreenGui
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
    
    -- Dimensões da janela
    local UISizeX = config.SizeX or 550
    local UISizeY = config.SizeY or 380
    local TabSize = config.TabSize or 160
    
    local MainFrame = Instance.new("ImageButton")
    MainFrame.Name = "Hub"
    MainFrame.Size = UDim2.fromOffset(UISizeX, UISizeY)
    MainFrame.Position = UDim2.new(0.5, -UISizeX/2, 0.5, -UISizeY/2)
    MainFrame.BackgroundTransparency = 0.03
    MainFrame.AutoButtonColor = false
    MainFrame.Parent = self.ScreenGui
    self:CreateGradient(MainFrame, 45)
    self:CreateCorner(MainFrame)
    self:MakeDraggable(MainFrame)
    
    local Components = Instance.new("Folder")
    Components.Name = "Components"
    Components.Parent = MainFrame
    
    -- Top bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "Top Bar"
    TopBar.Size = UDim2.new(1, 0, 0, 28)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Components
    
    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.new(0, 15, 0.5)
    Title.AnchorPoint = Vector2.new(0, 0.5)
    Title.AutomaticSize = Enum.AutomaticSize.X
    Title.Text = config.Title or "GenesisV2"
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 12
    Title.TextColor3 = self.Theme["Color Text"]
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamMedium
    Title.Parent = TopBar
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.fromScale(0, 1)
    SubTitle.AutomaticSize = Enum.AutomaticSize.X
    SubTitle.AnchorPoint = Vector2.new(0, 1)
    SubTitle.Position = UDim2.new(1, 5, 0.9)
    SubTitle.Text = config.Subtitle or "by GenesisV2"
    SubTitle.TextColor3 = self.Theme["Color Dark Text"]
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.TextYAlignment = Enum.TextYAlignment.Bottom
    SubTitle.TextSize = 8
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.Parent = Title
    
    -- Botões
    local function MakeControlBtn(parent, image, callback)
        local btn = Instance.new("ImageButton")
        btn.Size = UDim2.new(0, 14, 0, 14)
        btn.BackgroundTransparency = 1
        btn.Image = image
        btn.AutoButtonColor = false
        btn.Parent = parent
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    local CloseBtn = MakeControlBtn(TopBar, "rbxassetid://10747384394", function()
        local dialog = window:Dialog({
            Title = "Close",
            Text = "Deseja fechar a UI?",
            Options = {
                {"Confirm", function() self.ScreenGui:Destroy() end},
                {"Cancel"}
            }
        })
    end)
    CloseBtn.Position = UDim2.new(1, -10, 0.5)
    CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
    
    local MinimizeBtn = CloseBtn:Clone()
    MinimizeBtn.Image = "rbxassetid://10734896206"
    MinimizeBtn.Position = UDim2.new(1, -35, 0.5)
    MinimizeBtn.Parent = TopBar
    local minimized = false
    local originalSize = MainFrame.Size
    MinimizeBtn.MouseButton1Click:Connect(function()
        if minimized then
            MainFrame.Size = originalSize
            minimized = false
        else
            originalSize = MainFrame.Size
            MainFrame.Size = UDim2.fromOffset(MainFrame.Size.X.Offset, 28)
            minimized = true
        end
    end)
    
    -- Sidebar (abas)
    local MainScroll = Instance.new("ScrollingFrame")
    MainScroll.Size = UDim2.new(0, TabSize, 1, -TopBar.Size.Y.Offset)
    MainScroll.Position = UDim2.new(0, 0, 1, 0)
    MainScroll.AnchorPoint = Vector2.new(0, 1)
    MainScroll.ScrollBarThickness = 1.5
    MainScroll.ScrollBarImageColor3 = self.Theme["Color Theme"]
    MainScroll.BackgroundTransparency = 1
    MainScroll.CanvasSize = UDim2.new()
    MainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    MainScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    MainScroll.BorderSizePixel = 0
    MainScroll.Parent = Components
    
    local sidebarPadding = Instance.new("UIPadding")
    sidebarPadding.PaddingLeft = UDim.new(0, 10)
    sidebarPadding.PaddingRight = UDim.new(0, 10)
    sidebarPadding.PaddingTop = UDim.new(0, 10)
    sidebarPadding.PaddingBottom = UDim.new(0, 10)
    sidebarPadding.Parent = MainScroll
    
    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.Padding = UDim.new(0, 5)
    sidebarLayout.Parent = MainScroll
    
    -- Área de conteúdo
    local Containers = Instance.new("Frame")
    Containers.Size = UDim2.new(1, -TabSize, 1, -TopBar.Size.Y.Offset)
    Containers.AnchorPoint = Vector2.new(1, 1)
    Containers.Position = UDim2.new(1, 0, 1, 0)
    Containers.BackgroundTransparency = 1
    Containers.ClipsDescendants = true
    Containers.Parent = Components
    
    -- Controles de redimensionamento
    local ResizeCorner = Instance.new("ImageButton")
    ResizeCorner.Size = UDim2.new(0, 35, 0, 35)
    ResizeCorner.Position = MainFrame.Size
    ResizeCorner.AnchorPoint = Vector2.new(0.8, 0.8)
    ResizeCorner.BackgroundTransparency = 1
    ResizeCorner.Parent = MainFrame
    ResizeCorner:GetPropertyChangedSignal("Position"):Connect(function()
        MainFrame.Size = ResizeCorner.Position
    end)
    
    local ResizeSide = Instance.new("ImageButton")
    ResizeSide.Size = UDim2.new(0, 20, 1, -30)
    ResizeSide.Position = UDim2.new(0, MainScroll.Size.X.Offset, 1, 0)
    ResizeSide.AnchorPoint = Vector2.new(0.5, 1)
    ResizeSide.BackgroundTransparency = 1
    ResizeSide.Parent = MainFrame
    ResizeSide:GetPropertyChangedSignal("Position"):Connect(function()
        MainScroll.Size = UDim2.new(0, ResizeSide.Position.X.Offset, 1, -TopBar.Size.Y.Offset)
        Containers.Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset)
    end)
    
    window.MainFrame = MainFrame
    window.Tabs = {}
    window.CurrentTab = nil
    
    -- ==============================
    --        CREATE TAB (CORRIGIDO)
    -- ==============================
    function window:CreateTab(tabConfig)
        local name = tabConfig.Name or "Tab"
        local icon = self:GetIcon(tabConfig.Icon) or ""
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 24)
        tabBtn.AutoButtonColor = false
        tabBtn.BackgroundTransparency = 1
        tabBtn.Parent = MainScroll
        self:CreateCorner(tabBtn)
        
        local labelTitle = Instance.new("TextLabel")
        labelTitle.Size = UDim2.new(1, icon ~= "" and -25 or -15, 1)
        labelTitle.Position = UDim2.new(0, icon ~= "" and 25 or 15, 0)
        labelTitle.BackgroundTransparency = 1
        labelTitle.Font = Enum.Font.GothamMedium
        labelTitle.Text = name
        labelTitle.TextColor3 = self.Theme["Color Text"]
        labelTitle.TextSize = 10
        labelTitle.TextXAlignment = Enum.TextXAlignment.Left
        labelTitle.Parent = tabBtn
        
        if icon ~= "" then
            local labelIcon = Instance.new("ImageLabel")
            labelIcon.Position = UDim2.new(0, 8, 0.5)
            labelIcon.Size = UDim2.new(0, 13, 0, 13)
            labelIcon.AnchorPoint = Vector2.new(0, 0.5)
            labelIcon.Image = icon
            labelIcon.BackgroundTransparency = 1
            labelIcon.Parent = tabBtn
        end
        
        -- Barra lateral indicadora (agora guardada em uma variável)
        local selectedBar = Instance.new("Frame")
        selectedBar.Size = UDim2.new(0, 4, 0, 13)
        selectedBar.Position = UDim2.new(0, 1, 0.5)
        selectedBar.AnchorPoint = Vector2.new(0, 0.5)
        selectedBar.BackgroundColor3 = self.Theme["Color Theme"]
        selectedBar.BackgroundTransparency = 1
        selectedBar.Parent = tabBtn
        self:CreateCorner(selectedBar, UDim.new(0.5, 0))
        
        -- Container da aba (Left + Right)
        local container = Instance.new("ScrollingFrame")
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundTransparency = 1
        container.ScrollBarThickness = 1.5
        container.ScrollBarImageColor3 = self.Theme["Color Theme"]
        container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        container.ScrollingDirection = Enum.ScrollingDirection.Y
        container.BorderSizePixel = 0
        container.Visible = false
        container.Parent = Containers
        
        local containerPad = Instance.new("UIPadding")
        containerPad.PaddingLeft = UDim.new(0, 10)
        containerPad.PaddingRight = UDim.new(0, 10)
        containerPad.PaddingTop = UDim.new(0, 10)
        containerPad.PaddingBottom = UDim.new(0, 10)
        containerPad.Parent = container
        
        local columnsLayout = Instance.new("UIListLayout")
        columnsLayout.FillDirection = Enum.FillDirection.Horizontal
        columnsLayout.Padding = UDim.new(0, 10)
        columnsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        columnsLayout.Parent = container
        
        local leftCol = Instance.new("ScrollingFrame")
        leftCol.Size = UDim2.new(0.49, 0, 1, 0)
        leftCol.BackgroundTransparency = 1
        leftCol.ScrollBarThickness = 1.5
        leftCol.ScrollBarImageColor3 = self.Theme["Color Theme"]
        leftCol.AutomaticCanvasSize = Enum.AutomaticSize.Y
        leftCol.ScrollingDirection = Enum.ScrollingDirection.Y
        leftCol.BorderSizePixel = 0
        leftCol.Parent = container
        
        local leftPad = Instance.new("UIPadding")
        leftPad.PaddingBottom = UDim.new(0, 10)
        leftPad.Parent = leftCol
        
        local leftLayout = Instance.new("UIListLayout")
        leftLayout.Padding = UDim.new(0, 5)
        leftLayout.Parent = leftCol
        
        local rightCol = leftCol:Clone()
        rightCol.Parent = container
        
        local tabData = {
            Button = tabBtn,
            Container = container,
            Left = leftCol,
            Right = rightCol,
            Name = name,
            SelectedBar = selectedBar,  -- armazena a barra
            Enable = function()
                for _, t in pairs(window.Tabs) do
                    t.Container.Visible = false
                    if t.SelectedBar then
                        t.SelectedBar.BackgroundTransparency = 1
                        t.SelectedBar.Size = UDim2.new(0, 4, 0, 4)
                    end
                end
                container.Visible = true
                selectedBar.BackgroundTransparency = 0
                selectedBar.Size = UDim2.new(0, 4, 0, 13)
                window.CurrentTab = name
            end,
            Disable = function()
                container.Visible = false
                selectedBar.BackgroundTransparency = 1
                selectedBar.Size = UDim2.new(0, 4, 0, 4)
            end
        }
        
        tabBtn.MouseButton1Click:Connect(tabData.Enable)
        table.insert(window.Tabs, tabData)
        
        if not window.CurrentTab then
            tabData:Enable()
        end
        
        return tabData
    end
    
    -- ==============================
    --   FUNÇÕES DE CRIAÇÃO DE ELEMENTOS
    -- ==============================
    local function CreateButtonFrame(parent, title, desc)
        local frame = Instance.new("TextButton")
        frame.Size = UDim2.new(1, 0, 0, 25)
        frame.AutomaticSize = Enum.AutomaticSize.Y
        frame.AutoButtonColor = false
        frame.BackgroundColor3 = self.Theme["Color Hub 2"]
        frame.Parent = parent
        self:CreateCorner(frame, UDim.new(0,6))
        
        local holder = Instance.new("Frame")
        holder.AutomaticSize = Enum.AutomaticSize.Y
        holder.BackgroundTransparency = 1
        holder.Size = UDim2.new(1, -20, 0, 0)
        holder.Position = UDim2.new(0, 10, 0, 0)
        holder.Parent = frame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Font = Enum.Font.GothamMedium
        titleLabel.TextColor3 = self.Theme["Color Text"]
        titleLabel.Size = UDim2.new(1, -20, 0, 0)
        titleLabel.AutomaticSize = Enum.AutomaticSize.Y
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
        titleLabel.TextSize = 10
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Text = title
        titleLabel.Parent = holder
        
        local descLabel = nil
        if desc and desc ~= "" then
            descLabel = Instance.new("TextLabel")
            descLabel.Font = Enum.Font.Gotham
            descLabel.TextColor3 = self.Theme["Color Dark Text"]
            descLabel.Size = UDim2.new(1, -20, 0, 0)
            descLabel.AutomaticSize = Enum.AutomaticSize.Y
            descLabel.Position = UDim2.new(0, 0, 0, 15)
            descLabel.BackgroundTransparency = 1
            descLabel.TextWrapped = true
            descLabel.TextSize = 8
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.Text = desc
            descLabel.Parent = holder
        end
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.Padding = UDim.new(0, 2)
        layout.Parent = holder
        
        return frame, titleLabel, descLabel
    end
    
    -- CREATE SECTION
    function window:CreateSection(parent, text, color, icon)
        color = color or self.Theme["Color Theme"]
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 20)
        frame.BackgroundTransparency = 1
        frame.Parent = parent
        
        local line = Instance.new("Frame")
        line.BackgroundColor3 = self.Theme["Color Theme"]
        line.BackgroundTransparency = 0.7
        line.BorderSizePixel = 0
        line.Position = UDim2.new(0, 0, 0.5, 0)
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Parent = frame
        
        local labelBg = Instance.new("Frame")
        labelBg.BackgroundColor3 = self.Theme["Color Hub 2"]
        labelBg.BorderSizePixel = 0
        labelBg.AutomaticSize = Enum.AutomaticSize.X
        labelBg.Position = UDim2.new(0, 6, 0, 0)
        labelBg.Size = UDim2.new(0, 0, 1, 0)
        labelBg.Parent = frame
        
        if icon then
            local iconAsset = self:GetIcon(icon)
            if iconAsset then
                local iconImg = Instance.new("ImageLabel")
                iconImg.Size = UDim2.new(0, 14, 0, 14)
                iconImg.BackgroundTransparency = 1
                iconImg.Image = iconAsset
                iconImg.ImageColor3 = self.Theme["Color Theme"]
                iconImg.Parent = labelBg
            end
        end
        
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.AutomaticSize = Enum.AutomaticSize.X
        label.Size = UDim2.new(0, 0, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.Text = text
        label.TextColor3 = self.Theme["Color Theme"]
        label.TextSize = 11
        label.Parent = labelBg
        
        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.Padding = UDim.new(0, 5)
        layout.Parent = labelBg
        
        return frame
    end
    
    -- CREATE TOGGLE
    function window:CreateToggle(parent, config)
        local text = config.Text or "Toggle"
        local flag = config.Flag
        local default = (flag and self.GetFlag(flag) ~= nil) and self.GetFlag(flag) or (config.Default or false)
        local callback = config.Callback or function() end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, text, config.Description)
        
        local toggleHolder = Instance.new("Frame")
        toggleHolder.Size = UDim2.new(0, 35, 0, 18)
        toggleHolder.Position = UDim2.new(1, -10, 0.5)
        toggleHolder.AnchorPoint = Vector2.new(1, 0.5)
        toggleHolder.BackgroundColor3 = self.Theme["Color Stroke"]
        toggleHolder.Parent = frame
        self:CreateCorner(toggleHolder, UDim.new(0.5,0))
        
        local slider = Instance.new("Frame")
        slider.BackgroundTransparency = 1
        slider.Size = UDim2.new(0.8, 0, 0.8, 0)
        slider.Position = UDim2.new(0.5, 0, 0.5, 0)
        slider.AnchorPoint = Vector2.new(0.5, 0.5)
        slider.Parent = toggleHolder
        
        local toggle = Instance.new("Frame")
        toggle.Size = UDim2.new(0, 12, 0, 12)
        toggle.Position = default and UDim2.new(1, 0, 0.5) or UDim2.new(0, 0, 0.5)
        toggle.AnchorPoint = default and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
        toggle.BackgroundColor3 = self.Theme["Color Theme"]
        toggle.BackgroundTransparency = default and 0 or 0.8
        toggle.Parent = slider
        self:CreateCorner(toggle, UDim.new(0.5,0))
        
        local state = default
        local function setState(newState, skipCallback)
            state = newState
            if not skipCallback then
                if flag then self.SetFlag(flag, state) end
                callback(state)
            end
            if state then
                self:Tween(toggle, {Position = UDim2.new(1, 0, 0.5), BackgroundTransparency = 0}, 0.25)
                self:Tween(toggle, {AnchorPoint = Vector2.new(1, 0.5)}, 0.25)
            else
                self:Tween(toggle, {Position = UDim2.new(0, 0, 0.5), BackgroundTransparency = 0.8}, 0.25)
                self:Tween(toggle, {AnchorPoint = Vector2.new(0, 0.5)}, 0.25)
            end
        end
        
        frame.MouseButton1Click:Connect(function() setState(not state) end)
        setState(state, true)
        
        return {
            Frame = frame,
            GetState = function() return state end,
            SetState = function(s) setState(s) end
        }
    end
    
    -- CREATE BUTTON
    function window:CreateButton(parent, config)
        local text = config.Text or "Button"
        local callback = config.Callback or function() end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, text, config.Description)
        
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 14, 0, 14)
        icon.Position = UDim2.new(1, -10, 0.5)
        icon.AnchorPoint = Vector2.new(1, 0.5)
        icon.BackgroundTransparency = 1
        icon.Image = "rbxassetid://10709791437"
        icon.Parent = frame
        
        frame.MouseButton1Click:Connect(callback)
        
        return {
            Frame = frame,
            SetText = function(t) titleLabel.Text = t end,
            SetDesc = function(d) if descLabel then descLabel.Text = d end end
        }
    end
    
    -- CREATE SLIDER
    function window:CreateSlider(parent, config)
        local text = config.Text or "Slider"
        local min = config.Min or 0
        local max = config.Max or 100
        local default = config.Default or min
        local flag = config.Flag
        local callback = config.Callback or function() end
        
        if flag and self.GetFlag(flag) ~= nil then default = self.GetFlag(flag) end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, text, config.Description)
        
        local sliderHolder = Instance.new("Frame")
        sliderHolder.Size = UDim2.new(0.45, 0, 1, 0)
        sliderHolder.Position = UDim2.new(1, 0, 0, 0)
        sliderHolder.AnchorPoint = Vector2.new(1, 0)
        sliderHolder.BackgroundTransparency = 1
        sliderHolder.Parent = frame
        
        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -20, 0, 6)
        sliderBar.Position = UDim2.new(0.5, 0, 0.5, 0)
        sliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
        sliderBar.BackgroundColor3 = self.Theme["Color Stroke"]
        sliderBar.Parent = sliderHolder
        self:CreateCorner(sliderBar, UDim.new(1,0))
        
        local fill = Instance.new("Frame")
        fill.BackgroundColor3 = self.Theme["Color Theme"]
        fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBar
        self:CreateCorner(fill, UDim.new(1,0))
        
        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 6, 0, 12)
        knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
        knob.Position = UDim2.new((default-min)/(max-min), -3, 0.5, 0)
        knob.AnchorPoint = Vector2.new(0.5, 0.5)
        knob.BackgroundTransparency = 0.2
        knob.Parent = sliderBar
        self:CreateCorner(knob, UDim.new(1,0))
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 14, 0, 14)
        valueLabel.AnchorPoint = Vector2.new(1, 0.5)
        valueLabel.Position = UDim2.new(0, 0, 0.5)
        valueLabel.BackgroundTransparency = 1
        valueLabel.TextColor3 = self.Theme["Color Text"]
        valueLabel.Font = Enum.Font.FredokaOne
        valueLabel.TextSize = 12
        valueLabel.Text = tostring(default)
        valueLabel.Parent = sliderHolder
        
        local dragging = false
        local current = default
        
        local function updateValue(value)
            current = math.clamp(value, min, max)
            local percent = (current - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, -3, 0.5, 0)
            valueLabel.Text = tostring(math.floor(current))
            if flag then self.SetFlag(flag, current) end
            callback(current)
        end
        
        local function onDrag(input)
            local percent = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            updateValue(min + (max - min) * percent)
        end
        
        sliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                onDrag(input)
            end
        end)
        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                onDrag(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        updateValue(default)
        
        return {
            Frame = frame,
            GetValue = function() return current end,
            SetValue = function(v) updateValue(v) end
        }
    end
    
    -- CREATE DROPDOWN (simples)
    function window:CreateDropdown(parent, config)
        local labelText = config.Label or "Dropdown"
        local options = config.Options or {}
        local default = config.Default or options[1]
        local flag = config.Flag
        local callback = config.Callback or function() end
        
        if flag and self.GetFlag(flag) then default = self.GetFlag(flag) end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, labelText, config.Description)
        
        local selectedFrame = Instance.new("Frame")
        selectedFrame.Size = UDim2.new(0, 150, 0, 18)
        selectedFrame.Position = UDim2.new(1, -10, 0.5)
        selectedFrame.AnchorPoint = Vector2.new(1, 0.5)
        selectedFrame.BackgroundColor3 = self.Theme["Color Stroke"]
        selectedFrame.Parent = frame
        self:CreateCorner(selectedFrame, UDim.new(0,4))
        
        local selectedText = Instance.new("TextLabel")
        selectedText.Size = UDim2.new(0.85, 0, 0.85, 0)
        selectedText.AnchorPoint = Vector2.new(0.5, 0.5)
        selectedText.Position = UDim2.new(0.5, 0, 0.5, 0)
        selectedText.BackgroundTransparency = 1
        selectedText.Font = Enum.Font.GothamBold
        selectedText.TextScaled = true
        selectedText.TextColor3 = self.Theme["Color Text"]
        selectedText.Text = tostring(default)
        selectedText.Parent = selectedFrame
        
        local arrow = Instance.new("ImageLabel")
        arrow.Size = UDim2.new(0, 15, 0, 15)
        arrow.Position = UDim2.new(0, -5, 0.5)
        arrow.AnchorPoint = Vector2.new(1, 0.5)
        arrow.Image = "rbxassetid://10709791523"
        arrow.BackgroundTransparency = 1
        arrow.Parent = selectedFrame
        
        local dropdownContainer = Instance.new("Frame")
        dropdownContainer.Size = UDim2.new(0, 152, 0, 0)
        dropdownContainer.BackgroundColor3 = Color3.fromRGB(255,255,255)
        dropdownContainer.BackgroundTransparency = 0.1
        dropdownContainer.ClipsDescendants = true
        dropdownContainer.Visible = false
        dropdownContainer.Parent = self.ScreenGui
        
        local dropdownList = Instance.new("ScrollingFrame")
        dropdownList.Size = UDim2.new(1, 0, 1, 0)
        dropdownList.BackgroundTransparency = 1
        dropdownList.ScrollBarThickness = 1.5
        dropdownList.ScrollBarImageColor3 = self.Theme["Color Theme"]
        dropdownList.CanvasSize = UDim2.new()
        dropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        dropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
        dropdownList.Parent = dropdownContainer
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 4)
        listLayout.Parent = dropdownList
        
        local isOpen = false
        
        local function close()
            if not isOpen then return end
            isOpen = false
            self:Tween(dropdownContainer, {Size = UDim2.new(0, 152, 0, 0)}, 0.2)
            self:Tween(arrow, {Rotation = 0}, 0.2)
            task.wait(0.2)
            dropdownContainer.Visible = false
        end
        
        local function open()
            if isOpen then close(); return end
            for _, child in ipairs(dropdownList:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for _, opt in ipairs(options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 21)
                btn.Text = "  " .. opt
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Font = Enum.Font.GothamBold
                btn.TextColor3 = self.Theme["Color Text"]
                btn.BackgroundColor3 = self.Theme["Color Hub 2"]
                btn.AutoButtonColor = false
                btn.Parent = dropdownList
                self:CreateCorner(btn, UDim.new(0,4))
                btn.MouseButton1Click:Connect(function()
                    selectedText.Text = opt
                    if flag then self.SetFlag(flag, opt) end
                    callback(opt)
                    close()
                end)
            end
            local contentHeight = listLayout.AbsoluteContentSize.Y + 10
            local targetHeight = math.min(contentHeight, 200)
            dropdownContainer.Size = UDim2.new(0, 152, 0, 0)
            dropdownContainer.Visible = true
            dropdownContainer.Position = UDim2.new(0, selectedFrame.AbsolutePosition.X, 0, selectedFrame.AbsolutePosition.Y + selectedFrame.AbsoluteSize.Y)
            self:Tween(dropdownContainer, {Size = UDim2.new(0, 152, 0, targetHeight)}, 0.2)
            self:Tween(arrow, {Rotation = 180}, 0.2)
            isOpen = true
        end
        
        frame.MouseButton1Click:Connect(open)
        
        return {
            Frame = frame,
            GetValue = function() return selectedText.Text end,
            SetValue = function(v) selectedText.Text = v; callback(v) end,
            SetOptions = function(newOpts) options = newOpts end
        }
    end
    
    -- CREATE MULTI DROPDOWN (estilo GenesisX)
    function window:CreateMultiDropdown(parent, config)
        local labelText = config.Label or "Multi Select"
        local options = config.Options or {}
        local default = config.Default or {}
        local flag = config.Flag
        local callback = config.Callback or function() end
        
        local selectedValues = {}
        for _, v in ipairs(default) do table.insert(selectedValues, v) end
        if flag and self.GetFlag(flag) then
            local saved = self.GetFlag(flag)
            if type(saved) == "table" then
                selectedValues = saved
            end
        end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, labelText, config.Description)
        
        local selectedFrame = Instance.new("Frame")
        selectedFrame.Size = UDim2.new(0, 150, 0, 18)
        selectedFrame.Position = UDim2.new(1, -10, 0.5)
        selectedFrame.AnchorPoint = Vector2.new(1, 0.5)
        selectedFrame.BackgroundColor3 = self.Theme["Color Stroke"]
        selectedFrame.Parent = frame
        self:CreateCorner(selectedFrame, UDim.new(0,4))
        
        local selectedText = Instance.new("TextLabel")
        selectedText.Size = UDim2.new(0.85, 0, 0.85, 0)
        selectedText.AnchorPoint = Vector2.new(0.5, 0.5)
        selectedText.Position = UDim2.new(0.5, 0, 0.5, 0)
        selectedText.BackgroundTransparency = 1
        selectedText.Font = Enum.Font.GothamBold
        selectedText.TextScaled = true
        selectedText.TextColor3 = self.Theme["Color Text"]
        selectedText.Text = #selectedValues > 0 and #selectedValues .. " selecionados" or "Nenhum"
        selectedText.Parent = selectedFrame
        
        local arrow = Instance.new("ImageLabel")
        arrow.Size = UDim2.new(0, 15, 0, 15)
        arrow.Position = UDim2.new(0, -5, 0.5)
        arrow.AnchorPoint = Vector2.new(1, 0.5)
        arrow.Image = "rbxassetid://10709791523"
        arrow.BackgroundTransparency = 1
        arrow.Parent = selectedFrame
        
        local dropdownContainer = Instance.new("Frame")
        dropdownContainer.Size = UDim2.new(0, 152, 0, 0)
        dropdownContainer.BackgroundColor3 = Color3.fromRGB(255,255,255)
        dropdownContainer.BackgroundTransparency = 0.1
        dropdownContainer.ClipsDescendants = true
        dropdownContainer.Visible = false
        dropdownContainer.Parent = self.ScreenGui
        
        local dropdownList = Instance.new("ScrollingFrame")
        dropdownList.Size = UDim2.new(1, 0, 1, 0)
        dropdownList.BackgroundTransparency = 1
        dropdownList.ScrollBarThickness = 1.5
        dropdownList.ScrollBarImageColor3 = self.Theme["Color Theme"]
        dropdownList.CanvasSize = UDim2.new()
        dropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        dropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
        dropdownList.Parent = dropdownContainer
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 4)
        listLayout.Parent = dropdownList
        
        local isOpen = false
        
        local function isSelected(opt)
            for _, v in ipairs(selectedValues) do
                if v == opt then return true end
            end
            return false
        end
        
        local function updateText()
            if #selectedValues == 0 then
                selectedText.Text = "Nenhum"
            elseif #selectedValues == 1 then
                selectedText.Text = selectedValues[1]
            else
                selectedText.Text = #selectedValues .. " selecionados"
            end
            if flag then self.SetFlag(flag, selectedValues) end
            callback(selectedValues)
        end
        
        local function toggleOption(opt)
            local found = false
            for i, v in ipairs(selectedValues) do
                if v == opt then
                    table.remove(selectedValues, i)
                    found = true
                    break
                end
            end
            if not found then
                table.insert(selectedValues, opt)
            end
            updateText()
            -- Recriar lista para atualizar checkmarks
            open() -- fecha e reabre para atualizar visual
        end
        
        local function close()
            if not isOpen then return end
            isOpen = false
            self:Tween(dropdownContainer, {Size = UDim2.new(0, 152, 0, 0)}, 0.2)
            self:Tween(arrow, {Rotation = 0}, 0.2)
            task.wait(0.2)
            dropdownContainer.Visible = false
        end
        
        local function open()
            if isOpen then close(); return end
            for _, child in ipairs(dropdownList:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for _, opt in ipairs(options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 21)
                local prefix = isSelected(opt) and "✓ " or "  "
                btn.Text = prefix .. opt
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Font = Enum.Font.GothamBold
                btn.TextColor3 = self.Theme["Color Text"]
                btn.BackgroundColor3 = self.Theme["Color Hub 2"]
                btn.AutoButtonColor = false
                btn.Parent = dropdownList
                self:CreateCorner(btn, UDim.new(0,4))
                btn.MouseButton1Click:Connect(function()
                    toggleOption(opt)
                end)
            end
            local contentHeight = listLayout.AbsoluteContentSize.Y + 10
            local targetHeight = math.min(contentHeight, 200)
            dropdownContainer.Size = UDim2.new(0, 152, 0, 0)
            dropdownContainer.Visible = true
            dropdownContainer.Position = UDim2.new(0, selectedFrame.AbsolutePosition.X, 0, selectedFrame.AbsolutePosition.Y + selectedFrame.AbsoluteSize.Y)
            self:Tween(dropdownContainer, {Size = UDim2.new(0, 152, 0, targetHeight)}, 0.2)
            self:Tween(arrow, {Rotation = 180}, 0.2)
            isOpen = true
        end
        
        frame.MouseButton1Click:Connect(open)
        
        return {
            Frame = frame,
            GetValues = function() return selectedValues end,
            SetValues = function(vals)
                selectedValues = {}
                for _, val in ipairs(vals) do table.insert(selectedValues, val) end
                updateText()
                if isOpen then open() end
            end,
            SetOptions = function(newOpts) options = newOpts end
        }
    end
    
    -- CREATE INPUT
    function window:CreateInput(parent, config)
        local labelText = config.Label or "Input"
        local default = config.Default or ""
        local placeholder = config.Placeholder or "Digite..."
        local callback = config.Callback or function() end
        
        local frame, titleLabel, descLabel = CreateButtonFrame(parent, labelText, config.Description)
        
        local inputBox = Instance.new("TextBox")
        inputBox.Size = UDim2.new(0, 150, 0, 18)
        inputBox.Position = UDim2.new(1, -10, 0.5)
        inputBox.AnchorPoint = Vector2.new(1, 0.5)
        inputBox.BackgroundColor3 = self.Theme["Color Stroke"]
        inputBox.Font = Enum.Font.GothamBold
        inputBox.TextScaled = true
        inputBox.TextColor3 = self.Theme["Color Text"]
        inputBox.PlaceholderText = placeholder
        inputBox.Text = tostring(default)
        inputBox.Parent = frame
        self:CreateCorner(inputBox, UDim.new(0,4))
        
        inputBox.FocusLost:Connect(function()
            callback(inputBox.Text)
        end)
        
        return {
            Frame = frame,
            GetText = function() return inputBox.Text end,
            SetText = function(t) inputBox.Text = t end
        }
    end
    
    -- CREATE NUMBER INPUT
    function window:CreateNumberInput(parent, config)
    local labelText = config.Label or "Number"
    local default = tonumber(config.Default) or 0
    local min = tonumber(config.Min) or -math.huge
    local max = tonumber(config.Max) or math.huge
    local flag = config.Flag
    local callback = config.Callback or function() end

    if flag and self.GetFlag(flag) ~= nil then
        local saved = tonumber(self.GetFlag(flag))
        if saved then default = saved end
    end

    local frame, titleLabel, descLabel = CreateButtonFrame(parent, labelText, config.Description)

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0, 150, 0, 18)
    inputBox.Position = UDim2.new(1, -10, 0.5)
    inputBox.AnchorPoint = Vector2.new(1, 0.5)
    inputBox.BackgroundColor3 = self.Theme["Color Stroke"]
    inputBox.Font = Enum.Font.GothamBold
    inputBox.TextScaled = true
    inputBox.TextColor3 = self.Theme["Color Text"]
    inputBox.PlaceholderText = "Número"
    inputBox.Text = tostring(default)
    inputBox.Parent = frame
    self:CreateCorner(inputBox, UDim.new(0,4))

    local function setValue(value)
        local num = tonumber(value)
        if not num then
            inputBox.Text = tostring(default)
            return
        end
        num = math.clamp(num, min, max)
        inputBox.Text = tostring(num)
        if flag then self.SetFlag(flag, num) end
        callback(num)
    end

    inputBox.FocusLost:Connect(function()
        setValue(inputBox.Text)
    end)

    return {
        Frame = frame,
        GetValue = function() return tonumber(inputBox.Text) or default end,
        SetValue = function(v) setValue(v) end
        }
    end
    
    -- CREATE LABEL
    function window:CreateLabel(parent, config)
        local text = config.Text or "Label"
        local color = config.Color or self.Theme["Color Dark Text"]
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 20)
        frame.BackgroundTransparency = 1
        frame.Parent = parent
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.Text = text
        label.TextColor3 = color
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        return {
            Frame = frame,
            SetText = function(t) label.Text = t end,
            SetColor = function(c) label.TextColor3 = c end
        }
    end
    
    -- CREATE SEPARATOR
    function window:CreateSeparator(parent)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 12)
        frame.BackgroundTransparency = 1
        frame.Parent = parent
        
        local line = Instance.new("Frame")
        line.BackgroundColor3 = self.Theme["Color Stroke"]
        line.BorderSizePixel = 0
        line.Position = UDim2.new(0, 0, 0.5, 0)
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Parent = frame
        
        return frame
    end
    
    -- NOTIFY
    function window:Notify(config)
        local message = config.Text or "Notificação"
        local title = config.Title or "Info"
        local ntype = config.Type or "info"
        local duration = config.Duration or 4
        
        local colors = {
            success = Color3.fromRGB(50, 205, 50),
            warning = Color3.fromRGB(255, 140, 0),
            error = Color3.fromRGB(255, 50, 50),
            info = Color3.fromRGB(65, 150, 255),
            genesis = self.Theme["Color Theme"]
        }
        local accent = colors[ntype] or colors.info
        
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 300, 0, 50)
        notif.Position = UDim2.new(1, 320, 0, 20)
        notif.BackgroundColor3 = self.Theme["Color Hub 2"]
        notif.ClipsDescendants = true
        notif.ZIndex = 10000
        notif.Parent = self.ScreenGui
        self:CreateCorner(notif, UDim.new(0,8))
        self:CreateStroke(notif, accent, 1.5, 0.3)
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 20)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = accent
        titleLabel.TextSize = 12
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = notif
        
        local msgLabel = Instance.new("TextLabel")
        msgLabel.Size = UDim2.new(1, -20, 0, 20)
        msgLabel.Position = UDim2.new(0, 10, 0, 25)
        msgLabel.BackgroundTransparency = 1
        msgLabel.Font = Enum.Font.Gotham
        msgLabel.Text = message
        msgLabel.TextColor3 = self.Theme["Color Dark Text"]
        msgLabel.TextSize = 10
        msgLabel.TextXAlignment = Enum.TextXAlignment.Left
        msgLabel.Parent = notif
        
        local function dismiss()
            self:Tween(notif, {Position = UDim2.new(1, 320, 0, notif.Position.Y.Offset)}, 0.3)
            task.delay(0.35, function() notif:Destroy() end)
        end
        
        self:Tween(notif, {Position = UDim2.new(1, -320, 0, 20)}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        task.delay(duration, function() if notif.Parent then dismiss() end end)
        
        notif.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dismiss() end
        end)
        
        return { Destroy = dismiss }
    end
    
    -- DIALOG
    function window:Dialog(config)
        local title = config.Title or "Dialog"
        local text = config.Text or "Are you sure?"
        local options = config.Options or {{"Confirm", function() end}, {"Cancel"}}
        
        if MainFrame:FindFirstChild("DialogOverlay") then return end
        
        local overlay = Instance.new("Frame")
        overlay.Name = "DialogOverlay"
        overlay.Size = UDim2.new(1,0,1,0)
        overlay.BackgroundColor3 = Color3.new(0,0,0)
        overlay.BackgroundTransparency = 0.6
        overlay.ZIndex = 2000
        overlay.Parent = MainFrame
        
        local dialogFrame = Instance.new("Frame")
        dialogFrame.Size = UDim2.new(0, 250, 0, 150)
        dialogFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
        dialogFrame.BackgroundColor3 = self.Theme["Color Hub 2"]
        dialogFrame.Parent = overlay
        self:CreateCorner(dialogFrame, UDim.new(0,12))
        self:CreateStroke(dialogFrame, self.Theme["Color Theme"], 1.5, 0.3)
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 30)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = self.Theme["Color Theme"]
        titleLabel.TextSize = 14
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = dialogFrame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -20, 0, 60)
        textLabel.Position = UDim2.new(0, 10, 0, 35)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.Gotham
        textLabel.Text = text
        textLabel.TextColor3 = self.Theme["Color Dark Text"]
        textLabel.TextSize = 12
        textLabel.TextWrapped = true
        textLabel.Parent = dialogFrame
        
        local btnHolder = Instance.new("Frame")
        btnHolder.Size = UDim2.new(1, 0, 0, 30)
        btnHolder.Position = UDim2.new(0, 0, 1, -40)
        btnHolder.BackgroundTransparency = 1
        btnHolder.Parent = dialogFrame
        
        local btnLayout = Instance.new("UIListLayout")
        btnLayout.FillDirection = Enum.FillDirection.Horizontal
        btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        btnLayout.Padding = UDim.new(0, 10)
        btnLayout.Parent = btnHolder
        
        local function close()
            self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
            self:Tween(dialogFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.delay(0.25, function() overlay:Destroy() end)
        end
        
        for _, opt in ipairs(options) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 80, 1, 0)
            btn.Text = opt[1]
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = self.Theme["Color Theme"]
            btn.AutoButtonColor = false
            btn.Parent = btnHolder
            self:CreateCorner(btn, UDim.new(0,6))
            btn.MouseButton1Click:Connect(function()
                if opt[2] then opt[2]() end
                close()
            end)
        end
        
        return { Close = close }
    end
    
    -- ==============================
    --        MÉTODOS EXTRAS
    -- ==============================
    function window:Destroy()
        self.ScreenGui:Destroy()
    end
    
    function window:SetVisible(visible)
        self.MainFrame.Visible = visible
    end
    
    function window:Toggle()
        self.MainFrame.Visible = not self.MainFrame.Visible
    end
    
    function window:SetTheme(themeName)
        local newTheme = self.Themes[themeName] or self.Themes.Purple
        self.Theme = newTheme
        -- Nota: para uma atualização completa, seria necessário recriar a UI.
        -- Por simplicidade, apenas alteramos o tema da janela atual.
        self.MainFrame.BackgroundColor3 = self.Theme["Color Hub 2"]
    end
    
    return window
end

-- ==============================
--        EXPORTAÇÃO GLOBAL
-- ==============================
local env = getgenv and getgenv() or _G
env.GenesisV2 = GenesisV2
env.GenesisX = GenesisV2   -- alias
env.SpectrumX = GenesisV2  -- alias

return GenesisV2
