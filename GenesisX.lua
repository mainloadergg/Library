-- GenesisX2 with Redz Visual Design
-- API: GenesisX2 (100% compatible) | Visuals: Redz UI Library
-- Icons loaded externally via require (same as original GenesisX2)

local GenesisX = {}

-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // Icon System (external import, same as GenesisX2)
local Success, Response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Library/refs/heads/main/Icons.lua")
end)

local Icons = {}
if Success then
    local Func, Err = loadstring(Response)
    if Func then
        local IconData = Func()
        if IconData and IconData.assets then
            for Name, AssetId in pairs(IconData.assets) do
                Icons[Name] = AssetId
            end
        end
    end
end

-- // Theme System (GenesisX2 colors + Redz structure)
GenesisX.Themes = {
    Dark = {
        -- GenesisX2 original keys (purple theme)
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(150, 80, 230),
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
        -- Redz compatibility keys
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(150, 80, 230),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
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
        -- Redz compatibility keys
        ["Color Hub 1"] = Color3.fromRGB(245, 245, 245),
        ["Color Hub 2"] = Color3.fromRGB(235, 235, 235),
        ["Color Stroke"] = Color3.fromRGB(200, 200, 200),
        ["Color Theme"] = Color3.fromRGB(130, 60, 210),
        ["Color Text"] = Color3.fromRGB(30, 30, 30),
        ["Color Dark Text"] = Color3.fromRGB(100, 100, 100),
    }
}

GenesisX.Theme = GenesisX.Themes.Dark

-- // Redz-style visual helpers
local ThemeInstances = {}

local function InsertTheme(Instance, Type)
    table.insert(ThemeInstances, {
        Instance = Instance,
        Type = Type
    })
    return Instance
end

local function CreateTween(Configs)
    local Instance = Configs[1] or Configs.Instance
    local Prop = Configs[2] or Configs.Prop
    local NewVal = Configs[3] or Configs.NewVal
    local Time = Configs[4] or Configs.Time or 0.5
    local TweenWait = Configs[5] or Configs.wait or false
    local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Quint)

    local Tween = TweenService:Create(Instance, TweenInfo, {[Prop] = NewVal})
    Tween:Play()
    if TweenWait then
        Tween.Completed:Wait()
    end
    return Tween
end

local function SetProps(Instance, Props)
    if Props then
        for prop, value in pairs(Props) do
            Instance[prop] = value
        end
    end
    return Instance
end

local function SetChildren(Instance, Children)
    if Children then
        for _, Child in ipairs(Children) do
            Child.Parent = Instance
        end
    end
    return Instance
end

local function Create(className, parent, props, children)
    local new = Instance.new(className)
    if type(parent) == "table" then
        SetProps(new, parent)
        SetChildren(new, props)
    else
        new.Parent = parent
        SetProps(new, props)
        SetChildren(new, children)
    end
    return new
end

local function Make(className, parent, props, children)
    return Create(className, parent, props, children)
end

local function GetColor(Instance)
    if Instance:IsA("Frame") or Instance:IsA("TextButton") then
        return "BackgroundColor3"
    elseif Instance:IsA("ImageLabel") or Instance:IsA("ImageButton") then
        return "ImageColor3"
    elseif Instance:IsA("TextLabel") or Instance:IsA("TextBox") then
        return "TextColor3"
    elseif Instance:IsA("ScrollingFrame") then
        return "ScrollBarImageColor3"
    elseif Instance:IsA("UIStroke") then
        return "Color"
    end
    return ""
end

-- // ButtonFrame helper (Redz style visual container)
local function ButtonFrame(parent, title, description, holderSize)
    local TitleL = InsertTheme(Create("TextLabel", {
        Font = Enum.Font.GothamMedium,
        TextColor3 = GenesisX.Theme["Color Text"],
        Size = UDim2.new(1, -20),
        AutomaticSize = "Y",
        Position = UDim2.new(0, 0, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        TextTruncate = "AtEnd",
        TextSize = 10,
        TextXAlignment = "Left",
        Text = "",
        RichText = true
    }), "Text")

    local DescL = InsertTheme(Create("TextLabel", {
        Font = Enum.Font.Gotham,
        TextColor3 = GenesisX.Theme["Color Dark Text"],
        Size = UDim2.new(1, -20),
        AutomaticSize = "Y",
        Position = UDim2.new(0, 12, 0, 15),
        BackgroundTransparency = 1,
        TextWrapped = true,
        TextSize = 8,
        TextXAlignment = "Left",
        Text = "",
        RichText = true
    }), "DarkText")

    local Frame = Create("TextButton", parent, {
        Size = UDim2.new(1, 0, 0, 25),
        AutomaticSize = "Y",
        BackgroundColor3 = GenesisX.Theme["Color Hub 2"],
        Text = "",
        AutoButtonColor = false,
        Name = "Option"
    })
    Create("UICorner", Frame, {CornerRadius = UDim.new(0, 6)})
    Create("UIStroke", Frame, {
        Color = GenesisX.Theme["Color Stroke"],
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })

    local LabelHolder = Create("Frame", Frame, {
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        Size = holderSize or UDim2.new(1, -20),
        Position = UDim2.new(0, 10, 0),
        AnchorPoint = Vector2.new(0, 0)
    }, {
        Create("UIListLayout", {
            SortOrder = "LayoutOrder",
            VerticalAlignment = "Center",
            Padding = UDim.new(0, 2)
        }),
        Create("UIPadding", {
            PaddingBottom = UDim.new(0, 5),
            PaddingTop = UDim.new(0, 5)
        }),
        TitleL,
        DescL
    })

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
            LabelHolder.Position = UDim2.new(0, 10, 0)
            LabelHolder.AnchorPoint = Vector2.new(0, 0)
        else
            DescL.Visible = false
            DescL.Text = ""
            LabelHolder.Position = UDim2.new(0, 10, 0.5)
            LabelHolder.AnchorPoint = Vector2.new(0, 0.5)
        end
    end

    Label:SetTitle(title or "")
    Label:SetDesc(description or "")
    return Frame, Label
end

-- // Scale system (from GenesisX2)
GenesisX.Config = {
    CornerRadius    = UDim.new(0, 8),
    ShadowEnabled   = false,
    ShadowIntensity = 0.4,
    AnimationSpeed  = 0.2,
    Font            = Enum.Font.GothamMedium,
    FontBold        = Enum.Font.GothamBold,
    Scale           = 1,
}

function GenesisX:SetScale(scale)
    self.Config.Scale = scale
    if self._UIScale then
        self._UIScale.Scale = scale
    end
end

function GenesisX:GetScale()
    return self.Config.Scale
end

-- // Font system
GenesisX.Fonts = {
    Title = Enum.Font.GothamBold,
    Subtitle = Enum.Font.GothamMedium,
    Body = Enum.Font.Gotham,
    Small = Enum.Font.Gotham,
}

-- // Theme management
function GenesisX:SetTheme(themeName)
    if self.Themes[themeName] then
        self.Theme = self.Themes[themeName]
        -- Update all themed instances
        for _, Val in ipairs(ThemeInstances) do
            if Val.Type == "Frame" or Val.Type == "Button" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Hub 2"]
            elseif Val.Type == "Stroke" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Stroke"]
            elseif Val.Type == "Theme" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Theme"]
            elseif Val.Type == "Text" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Text"]
            elseif Val.Type == "DarkText" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Dark Text"]
            elseif Val.Type == "ScrollBar" then
                Val.Instance[GetColor(Val.Instance)] = self.Theme["Color Theme"]
            end
        end
    end
end

function GenesisX:GetThemes()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    return names
end

-- // Legacy visual helpers (keep for compatibility but use redz style internally)
function GenesisX:CreateCorner(parent, radius)
    local corner = Create("UICorner", parent, {
        CornerRadius = radius or self.Config.CornerRadius
    })
    return corner
end

function GenesisX:CreateStroke(parent, color, thickness, transparency)
    local stroke = Create("UIStroke", parent, {
        Color = color or self.Theme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    return stroke
end

function GenesisX:CreateShadow(parent, intensity)
    -- Redz doesn't use shadows, so this is a no-op
    return nil
end

function GenesisX:CreateGradient(parent, colors, rotation)
    local gradient = Create("UIGradient", parent, {
        Color = colors or ColorSequence.new(self.Theme.Background, self.Theme.Card),
        Rotation = rotation or 0
    })
    return gradient
end

function GenesisX:CreateDivider(parent, text, color)
    local divider = Create("Frame", parent, {
        Size = UDim2.new(1, 0, 0, text and 30 or 20),
        BackgroundTransparency = 1,
        Name = "Divider"
    })

    if text and text ~= "" then
        local leftLine = Create("Frame", divider, {
            Size = UDim2.new(0.5, -50, 0, 1),
            Position = UDim2.new(0, 0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = color or self.Theme.Border,
            BorderSizePixel = 0
        })

        local rightLine = Create("Frame", divider, {
            Size = UDim2.new(0.5, -50, 0, 1),
            Position = UDim2.new(1, 0, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = color or self.Theme.Border,
            BorderSizePixel = 0
        })

        Create("TextLabel", divider, {
            Size = UDim2.new(0, 0, 0, 14),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = " " .. text .. " ",
            TextColor3 = self.Theme.TextMuted,
            TextSize = 9,
            AutomaticSize = "X"
        })
    else
        Create("Frame", divider, {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = color or self.Theme.Border,
            BorderSizePixel = 0
        })
    end

    return divider
end

-- // Drag functionality (Redz style with smooth tween)
local function MakeDrag(Instance)
    SetProps(Instance, {
        Active = true,
        AutoButtonColor = false
    })

    local DragStart, StartPos, InputOn

    local function Update(Input)
        local delta = Input.Position - DragStart
        local Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        CreateTween({Instance, "Position", Position, 0.35})
    end

    Instance.MouseButton1Down:Connect(function()
        InputOn = true
    end)

    Instance.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            StartPos = Instance.Position
            DragStart = Input.Position

            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                RunService.Heartbeat:Wait()
                if InputOn then
                    Update(Input)
                end
            end
            InputOn = false
        end
    end)

    return Instance
end

-- // Window creation (Redz visual style, GenesisX2 API)
function GenesisX:CreateWindow(config)
    config = config or {}
    local Window = {}

    local ThemeColor = config.ThemeColor or self.Theme.Accent
    local WindowTitle = config.Title or "GenesisX"
    local WindowSubTitle = config.SubTitle or ""
    local WindowSize = config.Size or UDim2.new(0, 550, 0, 380)
    local TabSize = config.TabSize or 160

    -- Update theme accent
    self.Theme.Accent = ThemeColor
    self.Theme["Color Theme"] = ThemeColor
    self.Theme.ToggleOn = ThemeColor

    -- ScreenGui
    local ScreenGui = Create("ScreenGui", CoreGui, {
        Name = "GenesisX_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    -- Main Frame (Redz style - gradient background)
    local MainFrame = InsertTheme(Create("ImageButton", ScreenGui, {
        Size = WindowSize,
        Position = UDim2.new(0.5, -WindowSize.X.Offset/2, 0.5, -WindowSize.Y.Offset/2),
        BackgroundTransparency = 0.03,
        Name = "Hub"
    }), "Main")

    Create("UIGradient", MainFrame, {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, self.Theme.Background),
            ColorSequenceKeypoint.new(0.50, self.Theme.Background:Lerp(Color3.fromRGB(255,255,255), 0.02)),
            ColorSequenceKeypoint.new(1.00, self.Theme.Background)
        }),
        Rotation = 45
    })

    MakeDrag(MainFrame)
    Create("UICorner", MainFrame, {CornerRadius = UDim.new(0, 10)})

    -- UIScale
    self._UIScale = Create("UIScale", MainFrame, {Scale = self.Config.Scale})

    -- Components folder
    local Components = Create("Folder", MainFrame, {Name = "Components"})

    -- Dropdown holder (for dropdown menus)
    local DropdownHolder = Create("Folder", ScreenGui, {Name = "Dropdown"})

    -- Top Bar
    local TopBar = Create("Frame", Components, {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Name = "Top Bar"
    })

    local Title = InsertTheme(Create("TextLabel", TopBar, {
        Position = UDim2.new(0, 15, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        AutomaticSize = "XY",
        Text = WindowTitle,
        TextXAlignment = "Left",
        TextSize = 12,
        TextColor3 = self.Theme["Color Text"],
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Name = "Title"
    }, {
        InsertTheme(Create("TextLabel", {
            Size = UDim2.fromScale(0, 1),
            AutomaticSize = "X",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(1, 5, 0.9),
            Text = WindowSubTitle,
            TextColor3 = self.Theme["Color Dark Text"],
            BackgroundTransparency = 1,
            TextXAlignment = "Left",
            TextYAlignment = "Bottom",
            TextSize = 8,
            Font = Enum.Font.Gotham,
            Name = "SubTitle"
        }), "DarkText")
    }), "Text")

    -- Tab Scroll (Left sidebar)
    local MainScroll = InsertTheme(Create("ScrollingFrame", Components, {
        Size = UDim2.new(0, TabSize, 1, -TopBar.Size.Y.Offset),
        ScrollBarImageColor3 = self.Theme["Color Theme"],
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        ScrollBarThickness = 1.5,
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 0.2,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = "Y",
        ScrollingDirection = "Y",
        BorderSizePixel = 0,
        Name = "Tab Scroll"
    }, {
        Create("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        }),
        Create("UIListLayout", {
            Padding = UDim.new(0, 5)
        })
    }), "ScrollBar")

    -- Containers (Right content area)
    local Containers = Create("Frame", Components, {
        Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset),
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Name = "Containers"
    })

    -- Resize controls
    local ControlSize1, ControlSize2 = MakeDrag(Create("ImageButton", MainFrame, {
        Size = UDim2.new(0, 35, 0, 35),
        Position = MainFrame.Size,
        Active = true,
        AnchorPoint = Vector2.new(0.8, 0.8),
        BackgroundTransparency = 1,
        Name = "Control Hub Size"
    })), MakeDrag(Create("ImageButton", MainFrame, {
        Size = UDim2.new(0, 20, 1, -30),
        Position = UDim2.new(0, MainScroll.Size.X.Offset, 1, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        Active = true,
        BackgroundTransparency = 1,
        Name = "Control Tab Size"
    }))

    local function ControlSize()
        local Pos1, Pos2 = ControlSize1.Position, ControlSize2.Position
        ControlSize1.Position = UDim2.fromOffset(
            math.clamp(Pos1.X.Offset, 430, 1000),
            math.clamp(Pos1.Y.Offset, 200, 500)
        )
        ControlSize2.Position = UDim2.new(0, math.clamp(Pos2.X.Offset, 135, 250), 1, 0)

        MainScroll.Size = UDim2.new(0, ControlSize2.Position.X.Offset, 1, -TopBar.Size.Y.Offset)
        Containers.Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset)
        MainFrame.Size = ControlSize1.Position
    end

    ControlSize1:GetPropertyChangedSignal("Position"):Connect(ControlSize)
    ControlSize2:GetPropertyChangedSignal("Position"):Connect(ControlSize)

    -- Buttons (Close/Minimize)
    local ButtonsFolder = Create("Folder", TopBar, {Name = "Buttons"})

    local CloseButton = Create("ImageButton", ButtonsFolder, {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, -10, 0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = Icons["x"] or "rbxassetid://10747384394",
        AutoButtonColor = false,
        Name = "Close"
    })

    local MinimizeButton = SetProps(CloseButton:Clone(), {
        Position = UDim2.new(1, -35, 0.5),
        Image = Icons["minus"] or "rbxassetid://10734896206",
        Name = "Minimize"
    })
    MinimizeButton.Parent = ButtonsFolder

    -- Minimize/Close functionality
    local Minimized, SaveSize, WaitClick

    function Window:CloseBtn()
        local Dialog = Window:Dialog({
            Title = "Close",
            Text = "You Want Close Ui?",
            Options = {
                {"Confirm", function()
                    ScreenGui:Destroy()
                end},
                {"Cancel"}
            }
        })
    end

    function Window:MinimizeBtn()
        if WaitClick then return end
        WaitClick = true

        if Minimized then
            MinimizeButton.Image = Icons["minus"] or "rbxassetid://10734896206"
            CreateTween({MainFrame, "Size", SaveSize, 0.25, true})
            ControlSize1.Visible = true
            ControlSize2.Visible = true
            Minimized = false
        else
            MinimizeButton.Image = Icons["plus"] or "rbxassetid://10734924532"
            SaveSize = MainFrame.Size
            ControlSize1.Visible = false
            ControlSize2.Visible = false
            CreateTween({MainFrame, "Size", UDim2.fromOffset(MainFrame.Size.X.Offset, 28), 0.25, true})
            Minimized = true
        end

        WaitClick = false
    end

    function Window:Minimize()
        MainFrame.Visible = not MainFrame.Visible
    end

    function Window:AddMinimizeButton(Configs)
        local Button = MakeDrag(Create("ImageButton", ScreenGui, {
            Size = UDim2.fromOffset(35, 35),
            Position = UDim2.fromScale(0.15, 0.15),
            BackgroundTransparency = 1,
            BackgroundColor3 = self.Theme["Color Hub 2"],
            AutoButtonColor = false
        }))

        local Stroke, Corner
        if Configs.Corner then
            Corner = Create("UICorner", Button)
            SetProps(Corner, Configs.Corner)
        end
        if Configs.Stroke then
            Stroke = Create("UIStroke", Button)
            SetProps(Stroke, Configs.Corner)
        end

        SetProps(Button, Configs.Button)
        Button.Activated:Connect(Window.Minimize)

        return {
            Stroke = Stroke,
            Corner = Corner,
            Button = Button
        }
    end

    function Window:Set(Val1, Val2)
        if type(Val1) == "string" and type(Val2) == "string" then
            Title.Text = Val1
            Title.SubTitle.Text = Val2
        elseif type(Val1) == "string" then
            Title.Text = Val1
        end
    end

    -- Dialog (Redz style)
    function Window:Dialog(Configs)
        if MainFrame:FindFirstChild("Dialog") then return end
        if Minimized then
            Window:MinimizeBtn()
        end

        local DTitle = Configs[1] or Configs.Title or "Dialog"
        local DText = Configs[2] or Configs.Text or "This is a Dialog"
        local DOptions = Configs[3] or Configs.Options or {}

        local Frame = Create("Frame", {
            Active = true,
            Size = UDim2.fromOffset(250 * 1.08, 150 * 1.08),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }, {
            InsertTheme(Create("TextLabel", {
                Font = Enum.Font.GothamBold,
                Size = UDim2.new(1, 0, 0, 20),
                Text = DTitle,
                TextXAlignment = "Left",
                TextColor3 = self.Theme["Color Text"],
                TextSize = 15,
                Position = UDim2.fromOffset(15, 5),
                BackgroundTransparency = 1
            }), "Text"),
            InsertTheme(Create("TextLabel", {
                Font = Enum.Font.GothamMedium,
                Size = UDim2.new(1, -25),
                AutomaticSize = "Y",
                Text = DText,
                TextXAlignment = "Left",
                TextColor3 = self.Theme["Color Dark Text"],
                TextSize = 12,
                Position = UDim2.fromOffset(15, 25),
                BackgroundTransparency = 1,
                TextWrapped = true
            }), "DarkText")
        })

        Create("UIGradient", Frame, {Rotation = 270})
        Create("UICorner", Frame)

        local ButtonsHolder = Create("Frame", Frame, {
            Size = UDim2.fromScale(1, 0.35),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = self.Theme["Color Hub 2"],
            BackgroundTransparency = 1
        }, {
            Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                VerticalAlignment = "Center",
                FillDirection = "Horizontal",
                HorizontalAlignment = "Center"
            })
        })

        local Screen = InsertTheme(Create("Frame", MainFrame, {
            BackgroundTransparency = 0.6,
            Active = true,
            BackgroundColor3 = self.Theme["Color Stroke"],
            Size = UDim2.new(1, 0, 1, 0),
            Name = "Dialog"
        }), "Stroke")

        Create("UICorner", Screen)
        Frame.Parent = Screen
        CreateTween({Frame, "Size", UDim2.fromOffset(250, 150), 0.2})
        CreateTween({Frame, "BackgroundTransparency", 0, 0.15})
        CreateTween({Screen, "BackgroundTransparency", 0.3, 0.15})

        local ButtonCount, Dialog = 1, {}
        function Dialog:Button(Configs)
            local Name = Configs[1] or Configs.Name or Configs.Title or ""
            local Callback = Configs[2] or Configs.Callback or function()end

            ButtonCount = ButtonCount + 1
            local Button = Create("TextButton", ButtonsHolder, {
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundColor3 = self.Theme["Color Hub 2"],
                Text = Name,
                Font = Enum.Font.GothamBold,
                TextColor3 = self.Theme["Color Text"],
                TextSize = 12,
                AutoButtonColor = false
            })
            Create("UICorner", Button)
            Create("UIStroke", Button, {
                Color = self.Theme["Color Stroke"],
                Thickness = 1
            })

            for _, Btn in pairs(ButtonsHolder:GetChildren()) do
                if Btn:IsA("TextButton") then
                    Btn.Size = UDim2.new(1 / ButtonCount, -(((ButtonCount - 1) * 20) / ButtonCount), 0, 32)
                end
            end

            Button.Activated:Connect(Dialog.Close)
            Button.Activated:Connect(Callback)
        end

        function Dialog:Close()
            CreateTween({Frame, "Size", UDim2.fromOffset(250 * 1.08, 150 * 1.08), 0.2})
            CreateTween({Screen, "BackgroundTransparency", 1, 0.15})
            CreateTween({Frame, "BackgroundTransparency", 1, 0.15, true})
            Screen:Destroy()
        end

        for _, BtnConfig in ipairs(DOptions) do
            Dialog:Button(BtnConfig)
        end
        return Dialog
    end

    function Window:SelectTab(TabSelect)
        if type(TabSelect) == "number" then
            if self._Tabs and self._Tabs[TabSelect] then
                self._Tabs[TabSelect].func:Enable()
            end
        end
    end

    -- Tab system
    local Tabs = {}
    local ContainerList = {}
    Window._Tabs = Tabs
    local FirstTab = false

    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local Tab = {}

        local TName = tabConfig.Name or tabConfig[1] or "Tab"
        local TIcon = tabConfig.Icon or tabConfig[2] or ""

        -- Get icon
        if type(TIcon) == "string" and TIcon:len() > 0 then
            TIcon = Icons[TIcon] or TIcon
            if not TIcon:find("rbxassetid://") or TIcon:gsub("rbxassetid://", ""):len() < 6 then
                TIcon = false
            end
        else
            TIcon = false
        end

        -- Tab button (Redz style)
        local TabSelect = Create("TextButton", MainScroll, {
            Size = UDim2.new(1, 0, 0, 24),
            BackgroundColor3 = self.Theme["Color Hub 2"],
            Text = "",
            AutoButtonColor = false
        })
        Create("UICorner", TabSelect, {CornerRadius = UDim.new(0, 6)})

        local LabelTitle = InsertTheme(Create("TextLabel", TabSelect, {
            Size = UDim2.new(1, TIcon and -25 or -15, 1),
            Position = UDim2.fromOffset(TIcon and 25 or 15),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            Text = TName,
            TextColor3 = self.Theme["Color Text"],
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTransparency = FirstTab and 0.3 or 0,
            TextTruncate = "AtEnd"
        }), "Text")

        local LabelIcon = InsertTheme(Create("ImageLabel", TabSelect, {
            Position = UDim2.new(0, 8, 0.5),
            Size = UDim2.new(0, 13, 0, 13),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = TIcon or "",
            BackgroundTransparency = 1,
            ImageTransparency = FirstTab and 0.3 or 0
        }), "Text")

        local Selected = InsertTheme(Create("Frame", TabSelect, {
            Size = FirstTab and UDim2.new(0, 4, 0, 4) or UDim2.new(0, 4, 0, 13),
            Position = UDim2.new(0, 1, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = self.Theme["Color Theme"],
            BackgroundTransparency = FirstTab and 1 or 0
        }), "Theme")
        Create("UICorner", Selected, {CornerRadius = UDim.new(0.5, 0)})

        -- Container for this tab
        local Container = InsertTheme(Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            ScrollBarThickness = 1.5,
            BackgroundTransparency = 1,
            ScrollBarImageTransparency = 0.2,
            ScrollBarImageColor3 = self.Theme["Color Theme"],
            AutomaticCanvasSize = "Y",
            ScrollingDirection = "Y",
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            Name = ("Container %i [ %s ]"):format(#ContainerList + 1, TName)
        }, {
            Create("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            }),
            Create("UIListLayout", {
                Padding = UDim.new(0, 5)
            })
        }), "ScrollBar")

        table.insert(ContainerList, Container)
        if not FirstTab then
            Container.Parent = Containers
        end

        -- Left/Right sections
        Tab.Left = Container
        Tab.Right = Container
        Tab.Content = Container

        -- Tab activation
        local function ActivateTab()
            if Container.Parent then return end
            for _, Frame in pairs(ContainerList) do
                if Frame:IsA("ScrollingFrame") and Frame ~= Container then
                    Frame.Parent = nil
                end
            end
            Container.Parent = Containers
            Container.Size = UDim2.new(1, 0, 1, 150)

            for _, T in pairs(Tabs) do
                if T.Cont ~= Container then
                    T.func:Disable()
                end
            end

            CreateTween({Container, "Size", UDim2.new(1, 0, 1, 0), 0.3})
            CreateTween({LabelTitle, "TextTransparency", 0, 0.35})
            CreateTween({LabelIcon, "ImageTransparency", 0, 0.35})
            CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 13), 0.35})
            CreateTween({Selected, "BackgroundTransparency", 0, 0.35})
        end

        TabSelect.Activated:Connect(ActivateTab)

        FirstTab = true
        table.insert(Tabs, {TabInfo = {Name = TName, Icon = TIcon}, func = Tab, Cont = Container})

        function Tab:Disable()
            Container.Parent = nil
            CreateTween({LabelTitle, "TextTransparency", 0.3, 0.35})
            CreateTween({LabelIcon, "ImageTransparency", 0.3, 0.35})
            CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 4), 0.35})
            CreateTween({Selected, "BackgroundTransparency", 1, 0.35})
        end

        function Tab:Enable()
            ActivateTab()
        end

        function Tab:Visible(Bool)
            TabSelect.Visible = Bool ~= nil and Bool or not TabSelect.Visible
            if Bool ~= nil then
                Container.Parent = Bool and Containers or nil
            end
        end

        function Tab:Destroy()
            TabSelect:Destroy()
            Container:Destroy()
        end

                TextColor3 = self.Theme["Color Text"],
                Text = TDefault,
                ClearTextOnFocus = TClearText,
                PlaceholderText = TPlaceholder,
                PlaceholderColor3 = self.Theme["Color Dark Text"]
            }), "Text")

            TextBoxInput.Focused:Connect(function()
                CreateTween({SelectedFrame:FindFirstChildOfClass("UIStroke"), "Color", self.Theme["Color Theme"], 0.2})
            end)

            TextBoxInput.FocusLost:Connect(function(enterPressed)
                CreateTween({SelectedFrame:FindFirstChildOfClass("UIStroke"), "Color", self.Theme["Color Stroke"], 0.2})
                if type(Callback) == "function" then
                    Callback(TextBoxInput.Text, enterPressed)
                end
            end)

            local Input = {}
            function Input:Set(Val)
                if type(Val) == "string" then
                    TextBoxInput.Text = Val
                elseif type(Val) == "function" then
                    Callback = Val
                end
            end
            function Input:Get()
                return TextBoxInput.Text
            end
            function Input:Destroy()
                Button:Destroy()
            end
            return Input
        end

        -- Keybind
        function Tab:CreateKeybind(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Keybind"
            local TDesc = config.Description or config.Desc or ""
            local TDefault = config.Default or config[2] or "F"
            local Callback = config.Callback or config[3] or function()end
            local Flag = config.Flag or config[4] or false

            local Button, LabelFunc = ButtonFrame(self.Content, TName, TDesc, UDim2.new(1, -38))

            local SelectedFrame = InsertTheme(Create("Frame", Button, {
                Size = UDim2.new(0, 60, 0, 18),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = self.Theme["Color Stroke"]
            }), "Stroke")
            Create("UICorner", SelectedFrame, {CornerRadius = UDim.new(0, 4)})

            local TextBoxInput = InsertTheme(Create("TextBox", SelectedFrame, {
                Size = UDim2.new(0.85, 0, 0.85, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextScaled = true,
                TextColor3 = self.Theme["Color Text"],
                Text = tostring(TDefault),
                ClearTextOnFocus = true,
                PlaceholderText = "...",
                PlaceholderColor3 = self.Theme["Color Dark Text"]
            }), "Text")

            local OldBind = TDefault
            local Bind = TDefault

            local function BindEnded()
                TextBoxInput.Text = tostring(Bind)
                if type(Callback) == "function" then
                    Callback(Bind)
                end
            end

            TextBoxInput.FocusLost:Connect(function()
                local NewKey = TextBoxInput.Text:gsub(" ", "")
                if NewKey:len() < 1 then
                    Bind = OldBind
                else
                    Bind = NewKey
                end
                BindEnded()
            end)

            UserInputService.InputBegan:Connect(function(Input, gameProcessed)
                if Input.KeyCode and Input.KeyCode.Name == Bind and not gameProcessed then
                    if type(Callback) == "function" then
                        Callback(Bind)
                    end
                end
            end)

            local Keybind = {}
            function Keybind:Set(Val)
                if type(Val) == "string" then
                    Bind = Val
                    BindEnded()
                elseif type(Val) == "function" then
                    Callback = Val
                end
            end
            function Keybind:Get()
                return Bind
            end
            function Keybind:Destroy()
                Button:Destroy()
            end
            return Keybind
        end

        -- Color Picker
        function Tab:CreateColorPicker(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Color Picker"
            local TDesc = config.Description or config.Desc or ""
            local TDefault = config.Default or config[2] or Color3.fromRGB(255, 255, 255)
            local Callback = config.Callback or config[3] or function()end
            local Flag = config.Flag or config[4] or false

            local Button, LabelFunc = ButtonFrame(self.Content, TName, TDesc, UDim2.new(1, -38))

            local SelectedFrame = InsertTheme(Create("Frame", Button, {
                Size = UDim2.new(0, 35, 0, 18),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = TDefault
            }), "Theme")
            Create("UICorner", SelectedFrame, {CornerRadius = UDim.new(0, 4)})
            Create("UIStroke", SelectedFrame, {Color = self.Theme["Color Stroke"], Thickness = 1})

            local ColorPicker = {}
            function ColorPicker:Set(Val)
                if typeof(Val) == "Color3" then
                    SelectedFrame.BackgroundColor3 = Val
                    if type(Callback) == "function" then
                        Callback(Val)
                    end
                elseif type(Val) == "function" then
                    Callback = Val
                end
            end
            function ColorPicker:Get()
                return SelectedFrame.BackgroundColor3
            end
            function ColorPicker:Destroy()
                Button:Destroy()
            end
            return ColorPicker
        end

        -- Paragraph
        function Tab:CreateParagraph(config)
            config = config or {}
            local Title = config.Title or config[1] or config.Name or "Paragraph"
            local Content = config.Content or config[2] or config.Description or ""

            local Frame = Create("Frame", self.Content, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = self.Theme["Color Hub 2"],
                Name = "Option"
            })
            Create("UICorner", Frame, {CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", Frame, {Color = self.Theme["Color Stroke"], Thickness = 1})

            local ContentFrame = Create("Frame", Frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1
            })

            Create("UIListLayout", ContentFrame, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4)
            })

            Create("UIPadding", ContentFrame, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8)
            })

            if Title and Title ~= "" then
                Create("TextLabel", ContentFrame, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = Title,
                    TextColor3 = self.Theme["Color Text"],
                    TextSize = 11,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                    RichText = true
                })
            end

            if Content and Content ~= "" then
                Create("TextLabel", ContentFrame, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = Content,
                    TextColor3 = self.Theme["Color Dark Text"],
                    TextSize = 10,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                    RichText = true
                })
            end

            local Paragraph = {}
            function Paragraph:SetTitle(text)
                local labels = ContentFrame:GetChildren()
                for _, label in ipairs(labels) do
                    if label:IsA("TextLabel") and label.Font == Enum.Font.GothamBold then
                        label.Text = text
                        return
                    end
                end
            end
            function Paragraph:SetContent(text)
                local labels = ContentFrame:GetChildren()
                for _, label in ipairs(labels) do
                    if label:IsA("TextLabel") and label.Font == Enum.Font.Gotham then
                        label.Text = text
                        return
                    end
                end
            end
            function Paragraph:Destroy()
                Frame:Destroy()
            end
            return Paragraph
        end

        -- Divider
        function Tab:CreateDivider(config)
            config = config or {}
            local text = config.Text or config[1] or ""

            local Frame = Create("Frame", self.Content, {
                Size = UDim2.new(1, 0, 0, text ~= "" and 30 or 20),
                BackgroundTransparency = 1,
                Name = "Option"
            })

            if text ~= "" then
                local leftLine = Create("Frame", Frame, {
                    Size = UDim2.new(0.5, -50, 0, 1),
                    Position = UDim2.new(0, 0, 0.5),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = self.Theme["Color Stroke"],
                    BorderSizePixel = 0
                })

                local rightLine = Create("Frame", Frame, {
                    Size = UDim2.new(0.5, -50, 0, 1),
                    Position = UDim2.new(1, 0, 0.5),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = self.Theme["Color Stroke"],
                    BorderSizePixel = 0
                })

                Create("TextLabel", Frame, {
                    Size = UDim2.new(0, 0, 0, 14),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = " " .. text .. " ",
                    TextColor3 = self.Theme["Color Dark Text"],
                    TextSize = 9,
                    AutomaticSize = "X"
                })
            else
                Create("Frame", Frame, {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = self.Theme["Color Stroke"],
                    BorderSizePixel = 0
                })
            end

            local Divider = {}
            function Divider:Destroy()
                Frame:Destroy()
            end
            return Divider
        end

        -- ===== GENESISX2 UNIQUE ELEMENTS (adapted to Redz visual style) =====

        -- Number Input
        function Tab:CreateNumberInput(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Number Input"
            local TDesc = config.Description or config.Desc or ""
            local Min = config.Min or config[2] or -math.huge
            local Max = config.Max or config[3] or math.huge
            local Default = config.Default or config[4] or 0
            local Callback = config.Callback or config[5] or function()end

            local Button, LabelFunc = ButtonFrame(self.Content, TName, TDesc, UDim2.new(1, -38))

            local SelectedFrame = InsertTheme(Create("Frame", Button, {
                Size = UDim2.new(0, 80, 0, 18),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = self.Theme["Color Stroke"]
            }), "Stroke")
            Create("UICorner", SelectedFrame, {CornerRadius = UDim.new(0, 4)})

            local TextBoxInput = InsertTheme(Create("TextBox", SelectedFrame, {
                Size = UDim2.new(0.85, 0, 0.85, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextScaled = true,
                TextColor3 = self.Theme["Color Text"],
                Text = tostring(Default),
                ClearTextOnFocus = false,
                PlaceholderText = "0",
                PlaceholderColor3 = self.Theme["Color Dark Text"]
            }), "Text")

            TextBoxInput.FocusLost:Connect(function()
                local num = tonumber(TextBoxInput.Text)
                if num then
                    num = math.clamp(num, Min, Max)
                    TextBoxInput.Text = tostring(num)
                    if type(Callback) == "function" then
                        Callback(num)
                    end
                else
                    TextBoxInput.Text = tostring(Default)
                end
            end)

            local NumberInput = {}
            function NumberInput:Set(Val)
                if type(Val) == "number" then
                    Val = math.clamp(Val, Min, Max)
                    TextBoxInput.Text = tostring(Val)
                    if type(Callback) == "function" then
                        Callback(Val)
                    end
                elseif type(Val) == "function" then
                    Callback = Val
                end
            end
            function NumberInput:Get()
                return tonumber(TextBoxInput.Text) or Default
            end
            function NumberInput:Destroy()
                Button:Destroy()
            end
            return NumberInput
        end

        -- Multi Dropdown
        function Tab:CreateMultiDropdown(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Multi Dropdown"
            local TDesc = config.Description or config.Desc or ""
            local DOptions = config.Options or config[2] or {}
            local Default = config.Default or config[3] or {}
            local Callback = config.Callback or config[4] or function()end

            local Button, LabelFunc = ButtonFrame(self.Content, TName, TDesc, UDim2.new(1, -180))

            -- Use the same dropdown system as CreateDropdown but with MultiSelect = true
            local SelectedFrame = InsertTheme(Create("Frame", Button, {
                Size = UDim2.new(0, 150, 0, 18),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = self.Theme["Color Stroke"]
            }), "Stroke")
            Create("UICorner", SelectedFrame, {CornerRadius = UDim.new(0, 4)})

            local ActiveLabel = InsertTheme(Create("TextLabel", SelectedFrame, {
                Size = UDim2.new(0.85, 0, 0.85, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextScaled = true,
                TextColor3 = self.Theme["Color Text"],
                Text = "..."
            }), "Text")

            local Arrow = Create("ImageLabel", SelectedFrame, {
                Size = UDim2.new(0, 15, 0, 15),
                Position = UDim2.new(0, -5, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                Image = Icons["chevron-up"] or "rbxassetid://10709791523",
                BackgroundTransparency = 1
            })

            local NoClickFrame = Create("TextButton", DropdownHolder, {
                Name = "AntiClick",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Visible = false,
                Text = ""
            })

            local DropFrame = Create("Frame", NoClickFrame, {
                Size = UDim2.new(SelectedFrame.Size.X, 0, 0, 0),
                BackgroundTransparency = 0.1,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                AnchorPoint = Vector2.new(0, 1),
                Name = "DropdownFrame",
                ClipsDescendants = true,
                Active = true
            })
            Create("UICorner", DropFrame)
            Create("UIStroke", DropFrame, {Color = self.Theme["Color Stroke"], Thickness = 1})
            Create("UIGradient", DropFrame, {Rotation = 60, Color = ColorSequence.new(self.Theme.Background, self.Theme.Card)})

            local ScrollFrame = InsertTheme(Create("ScrollingFrame", DropFrame, {
                ScrollBarImageColor3 = self.Theme["Color Theme"],
                Size = UDim2.new(1, 0, 1, 0),
                ScrollBarThickness = 1.5,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                CanvasSize = UDim2.new(),
                ScrollingDirection = "Y",
                AutomaticCanvasSize = "Y",
                Active = true
            }, {
                Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5)
                }),
                Create("UIListLayout", {
                    Padding = UDim.new(0, 4)
                })
            }), "ScrollBar")

            local ScrollSize, WaitClick = 5, false
            local Selected = {}
            local Options = {}

            local function Disable()
                WaitClick = true
                CreateTween({Arrow, "Rotation", 0, 0.2})
                CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
                CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
                Arrow.Image = Icons["chevron-up"] or "rbxassetid://10709791523"
                NoClickFrame.Visible = false
                WaitClick = false
            end

            local function CalculateSize()
                local Count = 0
                for _, Frame in pairs(ScrollFrame:GetChildren()) do
                    if Frame:IsA("Frame") or Frame.Name == "Option" then
                        Count = Count + 1
                    end
                end
                ScrollSize = (math.clamp(Count, 0, 10) * 25) + 10
                if NoClickFrame.Visible then
                    CreateTween({DropFrame, "Size", UDim2.fromOffset(152, ScrollSize), 0.2, true})
                end
            end

            local function Minimize()
                if WaitClick then return end
                WaitClick = true
                if NoClickFrame.Visible then
                    Arrow.Image = Icons["chevron-up"] or "rbxassetid://10709791523"
                    CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
                    CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
                    NoClickFrame.Visible = false
                else
                    NoClickFrame.Visible = true
                    Arrow.Image = Icons["chevron-down"] or "rbxassetid://10709790948"
                    CreateTween({Arrow, "ImageColor3", self.Theme["Color Theme"], 0.2})
                    CreateTween({DropFrame, "Size", UDim2.fromOffset(152, ScrollSize), 0.2, true})
                end
                WaitClick = false
            end

            local function CalculatePos()
                local FramePos = SelectedFrame.AbsolutePosition
                local ScreenSize = ScreenGui.AbsoluteSize
                local UIScale = GenesisX.Config.Scale
                local ClampX = math.clamp((FramePos.X / UIScale), 0, ScreenSize.X / UIScale - DropFrame.Size.X.Offset)
                local ClampY = math.clamp((FramePos.Y / UIScale), 0, ScreenSize.Y / UIScale)
                local NewPos = UDim2.fromOffset(ClampX, ClampY)
                local AnchorPoint = FramePos.Y > ScreenSize.Y / 1.4 and 1 or ScrollSize > 80 and 0.5 or 0
                DropFrame.AnchorPoint = Vector2.new(0, AnchorPoint)
                CreateTween({DropFrame, "Position", NewPos, 0.1})
            end

            local function UpdateLabel()
                local list = {}
                for index, Value in pairs(Selected) do
                    if Value then
                        table.insert(list, index)
                    end
                end
                ActiveLabel.Text = #list > 0 and table.concat(list, ", ") or "..."
            end

            local function UpdateSelected()
                for _, v in pairs(Options) do
                    local nodes, Stats = v.nodes, v.Stats
                    CreateTween({nodes[2], "BackgroundTransparency", Stats and 0 or 0.8, 0.35})
                    CreateTween({nodes[2], "Size", Stats and UDim2.fromOffset(4, 12) or UDim2.fromOffset(4, 4), 0.35})
                    CreateTween({nodes[3], "TextTransparency", Stats and 0 or 0.4, 0.35})
                end
                UpdateLabel()
            end

            local function Select(Option)
                Option.Stats = not Option.Stats
                Selected[Option.Name] = Option.Stats
                if type(Callback) == "function" then
                    Callback(Selected)
                end
                UpdateSelected()
            end

            local function AddOption(index, Value)
                local Name = tostring(type(index) == "string" and index or Value)
                if Options[Name] then return end

                Options[Name] = {
                    index = index,
                    Value = Value,
                    Name = Name,
                    Stats = false
                }

                local Stats = Selected[Name]
                Selected[Name] = Stats or false
                Options[Name].Stats = Stats

                local OptButton = Create("TextButton", ScrollFrame, {
                    Name = "Option",
                    Size = UDim2.new(1, 0, 0, 21),
                    Position = UDim2.new(0, 0, 0.5),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = self.Theme["Color Hub 2"],
                    Text = "",
                    AutoButtonColor = false
                })
                Create("UICorner", OptButton, {CornerRadius = UDim.new(0, 4)})

                local IsSelected = InsertTheme(Create("Frame", OptButton, {
                    Position = UDim2.new(0, 1, 0.5),
                    Size = UDim2.new(0, 4, 0, 4),
                    BackgroundColor3 = self.Theme["Color Theme"],
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5)
                }), "Theme")
                Create("UICorner", IsSelected, {CornerRadius = UDim.new(0.5, 0)})

                local OptionName = InsertTheme(Create("TextLabel", OptButton, {
                    Size = UDim2.new(1, 0, 1),
                    Position = UDim2.new(0, 10),
                    Text = Name,
                    TextColor3 = self.Theme["Color Text"],
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = "Left",
                    BackgroundTransparency = 1,
                    TextTransparency = 0.4
                }), "Text")

                OptButton.Activated:Connect(function()
                    Select(Options[Name])
                end)

                Options[Name].nodes = {OptButton, IsSelected, OptionName}
            end

            for _, opt in ipairs(DOptions) do
                AddOption(_, opt)
            end
            UpdateSelected()

            Button.Activated:Connect(Minimize)
            NoClickFrame.MouseButton1Down:Connect(Disable)
            NoClickFrame.MouseButton1Click:Connect(Disable)
            MainFrame:GetPropertyChangedSignal("Visible"):Connect(Disable)
            SelectedFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(CalculatePos)
            Button.Activated:Connect(CalculateSize)
            ScrollFrame.ChildAdded:Connect(CalculateSize)
            ScrollFrame.ChildRemoved:Connect(CalculateSize)
            CalculatePos()
            CalculateSize()

            local MultiDropdown = {}
            function MultiDropdown:Set(Val1, Val2)
                if type(Val1) == "table" then
                    for _, opt in ipairs(Val1) do
                        AddOption(_, opt)
                    end
                elseif type(Val1) == "function" then
                    Callback = Val1
                end
            end
            function MultiDropdown:Select(Option)
                for _, Val in pairs(Options) do
                    if Val.Name == Option then
                        Select(Val)
                    end
                end
            end
            function MultiDropdown:Destroy()
                Button:Destroy()
            end
            return MultiDropdown
        end

        -- Checkbox
        function Tab:CreateCheckbox(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Checkbox"
            local TDesc = config.Description or config.Desc or ""
            local Default = config.Default or config[2] or false
            local Callback = config.Callback or config[3] or function()end

            local Button, LabelFunc = ButtonFrame(self.Content, TName, TDesc, UDim2.new(1, -38))

            local CheckFrame = InsertTheme(Create("Frame", Button, {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -28, 0.5),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = self.Theme["Color Stroke"]
            }), "Stroke")
            Create("UICorner", CheckFrame, {CornerRadius = UDim.new(0, 4)})

            local CheckIcon = Create("ImageLabel", CheckFrame, {
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = Icons["check"] or "rbxassetid://10709790644",
                ImageColor3 = self.Theme["Color Theme"],
                ImageTransparency = Default and 0 or 1
            })

            local CurrentValue = Default

            local function SetCheckbox(Val)
                CurrentValue = Val
                CreateTween({CheckIcon, "ImageTransparency", Val and 0 or 1, 0.2})
                CreateTween({CheckFrame, "BackgroundColor3", Val and self.Theme["Color Theme"] or self.Theme["Color Stroke"], 0.2})
                if type(Callback) == "function" then
                    Callback(CurrentValue)
                end
            end

            Button.Activated:Connect(function()
                SetCheckbox(not CurrentValue)
            end)

            task.spawn(SetCheckbox, Default)

            local Checkbox = {}
            function Checkbox:Set(Val)
                if type(Val) == "boolean" then
                    SetCheckbox(Val)
                elseif type(Val) == "function" then
                    Callback = Val
                end
            end
            function Checkbox:Get()
                return CurrentValue
            end
            function Checkbox:Destroy()
                Button:Destroy()
            end
            return Checkbox
        end

        -- LabelToggleSubTitle
        function Tab:CreateLabelToggleSubTitle(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Label Toggle"
            local TSubTitle = config.SubTitle or config[2] or ""
            local Default = config.Default or config[3] or false
            local Callback = config.Callback or config[4] or function()end

            local Frame = Create("Frame", self.Content, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = self.Theme["Color Hub 2"],
                Name = "Option"
            })
            Create("UICorner", Frame, {CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", Frame, {Color = self.Theme["Color Stroke"], Thickness = 1})

            local ContentFrame = Create("Frame", Frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1
            })

            Create("UIListLayout", ContentFrame, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 2)
            })

            Create("UIPadding", ContentFrame, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8)
            })

            -- Title row with toggle
            local TitleRow = Create("Frame", ContentFrame, {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1
            })

            local TitleLabel = InsertTheme(Create("TextLabel", TitleRow, {
                Size = UDim2.new(1, -50, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = TName,
                TextColor3 = self.Theme["Color Text"],
                TextSize = 11,
                TextXAlignment = "Left",
                TextTruncate = "AtEnd"
            }), "Text")

            -- Toggle switch
            local ToggleValue = Default
            local ToggleFrame = InsertTheme(Create("Frame", TitleRow, {
                Size = UDim2.new(0, 36, 0, 20),
                Position = UDim2.new(1, -36, 0.5),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = ToggleValue and self.Theme["Color Theme"] or self.Theme["Color Stroke"]
            }), ToggleValue and "Theme" or "Stroke")
            Create("UICorner", ToggleFrame, {CornerRadius = UDim.new(0.5, 0)})

            local ToggleCircle = Create("Frame", ToggleFrame, {
                Size = UDim2.new(0, 16, 0, 16),
                Position = ToggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            Create("UICorner", ToggleCircle, {CornerRadius = UDim.new(0.5, 0)})

            if TSubTitle and TSubTitle ~= "" then
                InsertTheme(Create("TextLabel", ContentFrame, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = TSubTitle,
                    TextColor3 = self.Theme["Color Dark Text"],
                    TextSize = 9,
                    TextXAlignment = "Left",
                    TextWrapped = true
                }), "DarkText")
            end

            local ClickButton = Create("TextButton", Frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false
            })

            local function UpdateToggle()
                ToggleValue = not ToggleValue
                local targetColor = ToggleValue and self.Theme["Color Theme"] or self.Theme["Color Stroke"]
                local targetPos = ToggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)

                CreateTween({ToggleFrame, "BackgroundColor3", targetColor, 0.2})
                CreateTween({ToggleCircle, "Position", targetPos, 0.2})

                if type(Callback) == "function" then
                    Callback(ToggleValue)
                end
            end

            ClickButton.Activated:Connect(UpdateToggle)

            local LTS = {}
            function LTS:Set(Val)
                if type(Val) == "boolean" and ToggleValue ~= Val then
                    ToggleValue = Val
                    local targetColor = ToggleValue and self.Theme["Color Theme"] or self.Theme["Color Stroke"]
                    local targetPos = ToggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    CreateTween({ToggleFrame, "BackgroundColor3", targetColor, 0.2})
                    CreateTween({ToggleCircle, "Position", targetPos, 0.2})
                    if type(Callback) == "function" then
                        Callback(ToggleValue)
                    end
                end
            end
            function LTS:Get()
                return ToggleValue
            end
            function LTS:Destroy()
                Frame:Destroy()
            end
            return LTS
        end

        -- StatusCard
        function Tab:CreateStatusCard(config)
            config = config or {}
            local TName = config.Name or config[1] or config.Title or "Status Card"
            local TDesc = config.Description or config.Desc or ""
            local TStatus = config.Status or config[2] or "Active"
            local TStatusColor = config.StatusColor or config[3] or self.Theme["Color Theme"]

            local Frame = Create("Frame", self.Content, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = self.Theme["Color Hub 2"],
                Name = "Option"
            })
            Create("UICorner", Frame, {CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", Frame, {Color = self.Theme["Color Stroke"], Thickness = 1})

            local ContentFrame = Create("Frame", Frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1
            })

            Create("UIListLayout", ContentFrame, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4)
            })

            Create("UIPadding", ContentFrame, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8)
            })

            -- Status indicator
            local StatusRow = Create("Frame", ContentFrame, {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1
            })

            local StatusDot = Create("Frame", StatusRow, {
                Size = UDim2.new(0, 8, 0, 8),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = TStatusColor,
                BorderSizePixel = 0
            })
            Create("UICorner", StatusDot, {CornerRadius = UDim.new(1, 0)})

            local StatusLabel = InsertTheme(Create("TextLabel", StatusRow, {
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = TStatus,
                TextColor3 = TStatusColor,
                TextSize = 10,
                TextXAlignment = "Left"
            }), "Theme")

            if TName and TName ~= "" then
                InsertTheme(Create("TextLabel", ContentFrame, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = TName,
                    TextColor3 = self.Theme["Color Text"],
                    TextSize = 12,
                    TextXAlignment = "Left"
                }), "Text")
            end

            if TDesc and TDesc ~= "" then
                InsertTheme(Create("TextLabel", ContentFrame, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = TDesc,
                    TextColor3 = self.Theme["Color Dark Text"],
                    TextSize = 9,
                    TextXAlignment = "Left",
                    TextWrapped = true
                }), "DarkText")
            end

            local StatusCard = {}
            function StatusCard:SetStatus(status, color)
                StatusLabel.Text = status
                StatusLabel.TextColor3 = color or TStatusColor
                StatusDot.BackgroundColor3 = color or TStatusColor
            end
            function StatusCard:Destroy()
                Frame:Destroy()
            end
            return StatusCard
        end

        -- ImageLabel
        function Tab:CreateImageLabel(config)
            config = config or {}
            local TImage = config.Image or config[1] or ""
            local TSize = config.Size or config[2] or UDim2.new(1, 0, 0, 120)

            local Frame = Create("Frame", self.Content, {
                Size = TSize,
                BackgroundColor3 = self.Theme["Color Hub 2"],
                Name = "Option"
            })
            Create("UICorner", Frame, {CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", Frame, {Color = self.Theme["Color Stroke"], Thickness = 1})

            local Image = Create("ImageLabel", Frame, {
                Size = UDim2.new(1, -8, 1, -8),
                Position = UDim2.new(0, 4, 0, 4),
                BackgroundTransparency = 1,
                Image = TImage,
                ScaleType = Enum.ScaleType.Fit
            })
            Create("UICorner", Image, {CornerRadius = UDim.new(0, 4)})

            local ImageLabel = {}
            function ImageLabel:SetImage(img)
                Image.Image = img
            end
            function ImageLabel:Destroy()
                Frame:Destroy()
            end
            return ImageLabel
        end

        return Tab
    end

    -- Notification
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or config[1] or "Notification"
        local Content = config.Content or config.Text or config[2] or ""
        local Duration = config.Duration or config[3] or 5
        local Type = config.Type or "Info"

        local NotifFrame = Create("Frame", ScreenGui, {
            Size = UDim2.new(0, 260, 0, 0),
            Position = UDim2.new(1, -280, 1, -20),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = self.Theme["Color Hub 2"],
            BorderSizePixel = 0,
            AutomaticSize = "Y",
            ClipsDescendants = true
        })
        Create("UICorner", NotifFrame, {CornerRadius = UDim.new(0, 8)})
        Create("UIStroke", NotifFrame, {Color = self.Theme["Color Stroke"], Thickness = 1})

        local NotifContent = Create("Frame", NotifFrame, {
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 10, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1
        })

        Create("UIListLayout", NotifContent, {
            SortOrder = "LayoutOrder",
            Padding = UDim.new(0, 4)
        })

        Create("UIPadding", NotifContent, {
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        })

        local typeColors = {
            Info = self.Theme.Info,
            Success = self.Theme.Success,
            Warning = self.Theme.Warning,
            Error = self.Theme.Error
        }
        local typeIcon = {
            Info = Icons["info"] or "rbxassetid://10723415903",
            Success = Icons["check"] or "rbxassetid://10709790644",
            Warning = Icons["alert-triangle"] or "rbxassetid://10723437086",
            Error = Icons["x"] or "rbxassetid://10747384394"
        }

        local TitleRow = Create("Frame", NotifContent, {
            Size = UDim2.new(1, 0, 0, 18),
            BackgroundTransparency = 1
        })

        Create("ImageLabel", TitleRow, {
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Image = typeIcon[Type] or typeIcon.Info,
            ImageColor3 = typeColors[Type] or self.Theme["Color Theme"]
        })

        InsertTheme(Create("TextLabel", TitleRow, {
            Size = UDim2.new(1, -24, 1, 0),
            Position = UDim2.new(0, 22, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            Text = Title,
            TextColor3 = self.Theme["Color Text"],
            TextSize = 11,
            TextXAlignment = "Left",
            TextTruncate = "AtEnd"
        }), "Text")

        if Content and Content ~= "" then
            InsertTheme(Create("TextLabel", NotifContent, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = Content,
                TextColor3 = self.Theme["Color Dark Text"],
                TextSize = 10,
                TextXAlignment = "Left",
                TextWrapped = true
            }), "DarkText")
        end

        NotifFrame.Position = UDim2.new(1, 20, 1, -20)
        CreateTween({NotifFrame, "Position", UDim2.new(1, -280, 1, -20), 0.4})

        task.delay(Duration, function()
            CreateTween({NotifFrame, "Position", UDim2.new(1, 20, 1, -20), 0.3, true})
            NotifFrame:Destroy()
        end)
    end

    -- Close button connections
    CloseButton.Activated:Connect(function()
        Window:CloseBtn()
    end)
    MinimizeButton.Activated:Connect(function()
        Window:MinimizeBtn()
    end)

    return Window
end

-- // Global Notification
function GenesisX:Notify(config)
    config = config or {}
    local Title = config.Title or config[1] or "Notification"
    local Content = config.Content or config.Text or config[2] or ""
    local Duration = config.Duration or config[3] or 5
    local Type = config.Type or "Info"

    local ScreenGui = Create("ScreenGui", CoreGui, {
        Name = "GenesisX_Notif_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local NotifFrame = Create("Frame", ScreenGui, {
        Size = UDim2.new(0, 260, 0, 0),
        Position = UDim2.new(1, -280, 1, -20),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = self.Theme["Color Hub 2"],
        BorderSizePixel = 0,
        AutomaticSize = "Y",
        ClipsDescendants = true
    })
    Create("UICorner", NotifFrame, {CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", NotifFrame, {Color = self.Theme["Color Stroke"], Thickness = 1})

    local NotifContent = Create("Frame", NotifFrame, {
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1
    })

    Create("UIListLayout", NotifContent, {
        SortOrder = "LayoutOrder",
        Padding = UDim.new(0, 4)
    })

    Create("UIPadding", NotifContent, {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10)
    })

    local typeColors = {
        Info = self.Theme.Info,
        Success = self.Theme.Success,
        Warning = self.Theme.Warning,
        Error = self.Theme.Error
    }
    local typeIcon = {
        Info = Icons["info"] or "rbxassetid://10723415903",
        Success = Icons["check"] or "rbxassetid://10709790644",
        Warning = Icons["alert-triangle"] or "rbxassetid://10723437086",
        Error = Icons["x"] or "rbxassetid://10747384394"
    }

    local TitleRow = Create("Frame", NotifContent, {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1
    })

    Create("ImageLabel", TitleRow, {
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundTransparency = 1,
        Image = typeIcon[Type] or typeIcon.Info,
        ImageColor3 = typeColors[Type] or self.Theme["Color Theme"]
    })

    InsertTheme(Create("TextLabel", TitleRow, {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 22, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = Title,
        TextColor3 = self.Theme["Color Text"],
        TextSize = 11,
        TextXAlignment = "Left",
        TextTruncate = "AtEnd"
    }), "Text")

    if Content and Content ~= "" then
        InsertTheme(Create("TextLabel", NotifContent, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = Content,
            TextColor3 = self.Theme["Color Dark Text"],
            TextSize = 10,
            TextXAlignment = "Left",
            TextWrapped = true
        }), "DarkText")
    end

    NotifFrame.Position = UDim2.new(1, 20, 1, -20)
    CreateTween({NotifFrame, "Position", UDim2.new(1, -280, 1, -20), 0.4})

    task.delay(Duration, function()
        CreateTween({NotifFrame, "Position", UDim2.new(1, 20, 1, -20), 0.3, true})
        NotifFrame:Destroy()
    end)
end

-- // Return library
return GenesisX
