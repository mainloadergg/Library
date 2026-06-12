-- GenesisX2 with Redz Visual Design
-- API: GenesisX2 | Visuals: Redz UI Library
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

-- // Theme System (Redz style + GenesisX2 backward compatibility)
local Themes = {
    Default = {
        -- Redz keys
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(88, 101, 242),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        -- GenesisX2 compatibility keys
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(110, 120, 255),
        AccentSecondary = Color3.fromRGB(70, 80, 200),
        AccentDark = Color3.fromRGB(60, 70, 180),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(88, 101, 242),
    },
    Red = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(255, 0, 0),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 0, 0),
        AccentHover = Color3.fromRGB(255, 50, 50),
        AccentSecondary = Color3.fromRGB(200, 0, 0),
        AccentDark = Color3.fromRGB(180, 0, 0),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(255, 0, 0),
    },
    Green = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(0, 255, 0),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(0, 255, 0),
        AccentHover = Color3.fromRGB(50, 255, 50),
        AccentSecondary = Color3.fromRGB(0, 200, 0),
        AccentDark = Color3.fromRGB(0, 180, 0),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(0, 255, 0),
    },
    Blue = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(0, 100, 255),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(0, 100, 255),
        AccentHover = Color3.fromRGB(50, 130, 255),
        AccentSecondary = Color3.fromRGB(0, 80, 200),
        AccentDark = Color3.fromRGB(0, 70, 180),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(0, 100, 255),
    },
    Purple = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(150, 0, 255),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(150, 0, 255),
        AccentHover = Color3.fromRGB(170, 50, 255),
        AccentSecondary = Color3.fromRGB(120, 0, 200),
        AccentDark = Color3.fromRGB(100, 0, 180),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(150, 0, 255),
    },
    Pink = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(255, 0, 255),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 0, 255),
        AccentHover = Color3.fromRGB(255, 50, 255),
        AccentSecondary = Color3.fromRGB(200, 0, 200),
        AccentDark = Color3.fromRGB(180, 0, 180),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(255, 0, 255),
    },
    Orange = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(255, 100, 0),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 100, 0),
        AccentHover = Color3.fromRGB(255, 130, 50),
        AccentSecondary = Color3.fromRGB(200, 80, 0),
        AccentDark = Color3.fromRGB(180, 70, 0),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(255, 100, 0),
    },
    Yellow = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(255, 255, 0),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 255, 0),
        AccentHover = Color3.fromRGB(255, 255, 50),
        AccentSecondary = Color3.fromRGB(200, 200, 0),
        AccentDark = Color3.fromRGB(180, 180, 0),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(255, 255, 0),
    },
    Gray = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(150, 150, 150),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(150, 150, 150),
        AccentHover = Color3.fromRGB(170, 170, 170),
        AccentSecondary = Color3.fromRGB(120, 120, 120),
        AccentDark = Color3.fromRGB(100, 100, 100),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(150, 150, 150),
    },
    White = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(255, 255, 255),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 255, 255),
        AccentHover = Color3.fromRGB(255, 255, 255),
        AccentSecondary = Color3.fromRGB(200, 200, 200),
        AccentDark = Color3.fromRGB(180, 180, 180),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(255, 255, 255),
    },
    Black = {
        ["Color Hub 1"] = Color3.fromRGB(30, 30, 30),
        ["Color Hub 2"] = Color3.fromRGB(35, 35, 35),
        ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
        ["Color Theme"] = Color3.fromRGB(0, 0, 0),
        ["Color Text"] = Color3.fromRGB(243, 243, 243),
        ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(35, 35, 35),
        CardHover = Color3.fromRGB(45, 45, 45),
        Input = Color3.fromRGB(25, 25, 25),
        InputHover = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(0, 0, 0),
        AccentHover = Color3.fromRGB(30, 30, 30),
        AccentSecondary = Color3.fromRGB(20, 20, 20),
        AccentDark = Color3.fromRGB(10, 10, 10),
        Text = Color3.fromRGB(243, 243, 243),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(140, 140, 140),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Info = Color3.fromRGB(80, 160, 255),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(40, 40, 40),
        BorderBright = Color3.fromRGB(60, 60, 60),
        ToggleOff = Color3.fromRGB(50, 50, 50),
        ToggleOn = Color3.fromRGB(0, 0, 0),
    },
}

local Theme = Themes.Default

-- Expose Theme table for backward compatibility
GenesisX.Theme = Theme
GenesisX.Themes = Themes

-- // Utility Functions (Redz style)
local function InsertTheme(obj, themeType)
    local themeMap = {
        ["Frame"] = "Color Hub 2",
        ["Stroke"] = "Color Stroke",
        ["Theme"] = "Color Theme",
        ["Text"] = "Color Text",
        ["DarkText"] = "Color Dark Text",
    }

    if themeMap[themeType] then
        local prop = themeType == "Text" and "TextColor3" or themeType == "DarkText" and "TextColor3" or themeType == "Stroke" and "Color" or themeType == "Theme" and "BackgroundColor3" or "BackgroundColor3"
        obj[prop] = Theme[themeMap[themeType]]
    end
    return obj
end

local function CreateTween(obj, info, props)
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

local function Create(className, props, children)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = obj
        end
    end
    if props and props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function Make(className, parent, props)
    local obj = Instance.new(className)
    obj.Parent = parent
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    return obj
end

local function SetProps(obj, props)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    return obj
end

local function SetChildren(obj, children)
    for _, child in ipairs(children) do
        child.Parent = obj
    end
    return obj
end

-- // ButtonFrame helper (Redz style visual container)
local function ButtonFrame(parent, title, description)
    local frame = InsertTheme(Make("Frame", parent, {
        Size = UDim2.new(1, 0, 0, 25),
        AutomaticSize = "Y",
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
        Name = "Option",
    }), "Frame")

    Make("UICorner", frame, {CornerRadius = UDim.new(0, 6)})
    Make("UIStroke", frame, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })

    local labelHolder = Make("Frame", frame, {
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AnchorPoint = Vector2.new(0, 0),
    })

    Make("UIListLayout", labelHolder, {
        SortOrder = "LayoutOrder",
        VerticalAlignment = "Center",
        Padding = UDim.new(0, 2),
    })

    Make("UIPadding", labelHolder, {
        PaddingBottom = UDim.new(0, 5),
        PaddingTop = UDim.new(0, 5),
    })

    local titleLabel = InsertTheme(Make("TextLabel", labelHolder, {
        Font = Enum.Font.GothamMedium,
        TextColor3 = Theme["Color Text"],
        Size = UDim2.new(1, -20, 0, 0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        TextTruncate = "AtEnd",
        TextSize = 10,
        TextXAlignment = "Left",
        Text = title or "",
        RichText = true,
    }), "Text")

    local descLabel
    if description and description ~= "" then
        descLabel = InsertTheme(Make("TextLabel", labelHolder, {
            Font = Enum.Font.Gotham,
            TextColor3 = Theme["Color Dark Text"],
            Size = UDim2.new(1, -20, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            TextWrapped = true,
            TextSize = 8,
            TextXAlignment = "Left",
            Text = description,
            RichText = true,
        }), "DarkText")
    end

    return frame, titleLabel, descLabel
end

-- // Drag functionality
local function MakeDrag(frame, dragFrame)
    local dragging = false
    local dragInput, mousePos, framePos

    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

-- // Scale system (from GenesisX2)
local Scale = {
    Value = 1,
    UIScale = nil,
}

function GenesisX:SetScale(scale)
    Scale.Value = scale
    if Scale.UIScale then
        Scale.UIScale.Scale = scale
    end
end

function GenesisX:GetScale()
    return Scale.Value
end

-- // Font system (Redz style fonts)
GenesisX.Fonts = {
    Title = Enum.Font.GothamBold,
    Subtitle = Enum.Font.GothamMedium,
    Body = Enum.Font.Gotham,
    Small = Enum.Font.Gotham,
}

-- // Window creation
function GenesisX:CreateWindow(config)
    config = config or {}
    local Window = {}

    local ThemeColor = config.ThemeColor or Color3.fromRGB(88, 101, 242)
    local WindowTitle = config.Title or "GenesisX"
    local WindowSubTitle = config.SubTitle or ""
    local WindowSize = config.Size or UDim2.new(0, 550, 0, 380)
    local TabSize = config.TabSize or 160

    -- Update theme
    Theme["Color Theme"] = ThemeColor

    -- ScreenGui
    local ScreenGui = Make("ScreenGui", CoreGui, {
        Name = "GenesisX_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    -- Main Frame
    local MainFrame = Make("Frame", ScreenGui, {
        Size = WindowSize,
        Position = UDim2.new(0.5, -WindowSize.X.Offset/2, 0.5, -WindowSize.Y.Offset/2),
        BackgroundColor3 = Theme["Color Hub 1"],
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    Make("UICorner", MainFrame, {CornerRadius = UDim.new(0, 10)})
    Make("UIStroke", MainFrame, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })

    -- UIScale
    Scale.UIScale = Make("UIScale", MainFrame, {Scale = Scale.Value})

    -- Top Bar
    local TopBar = Make("Frame", MainFrame, {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
        Name = "TopBar",
    })

    Make("UICorner", TopBar, {CornerRadius = UDim.new(0, 10)})
    local topBarFix = Make("Frame", TopBar, {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
    })

    -- Title
    local TitleLabel = Make("TextLabel", TopBar, {
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = WindowTitle,
        TextColor3 = Theme["Color Text"],
        TextSize = 14,
        TextXAlignment = "Left",
        TextTruncate = "AtEnd",
    })

    -- Subtitle
    if WindowSubTitle and WindowSubTitle ~= "" then
        Make("TextLabel", TopBar, {
            Size = UDim2.new(1, -100, 0, 14),
            Position = UDim2.new(0, 15, 1, -16),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = WindowSubTitle,
            TextColor3 = Theme["Color Dark Text"],
            TextSize = 9,
            TextXAlignment = "Left",
            TextTruncate = "AtEnd",
        })
        TitleLabel.Size = UDim2.new(1, -100, 0, 20)
        TitleLabel.Position = UDim2.new(0, 15, 0, 4)
    end

    -- Close button
    local CloseButton = Make("TextButton", TopBar, {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = Theme["Color Hub 2"],
        Text = "",
        AutoButtonColor = false,
    })
    Make("UICorner", CloseButton, {CornerRadius = UDim.new(0, 6)})
    Make("UIStroke", CloseButton, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
    })

    local closeIcon = Make("ImageLabel", CloseButton, {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Icons["x"] or "rbxassetid://10747384394",
        ImageColor3 = Theme["Color Text"],
    })

    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)})
    end)
    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme["Color Hub 2"]})
    end)

    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        })
        task.wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Minimize button
    local MinimizeButton = Make("TextButton", TopBar, {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -68, 0, 5),
        BackgroundColor3 = Theme["Color Hub 2"],
        Text = "",
        AutoButtonColor = false,
    })
    Make("UICorner", MinimizeButton, {CornerRadius = UDim.new(0, 6)})
    Make("UIStroke", MinimizeButton, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
    })

    local minIcon = Make("ImageLabel", MinimizeButton, {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = Icons["minus"] or "rbxassetid://10734896206",
        ImageColor3 = Theme["Color Text"],
    })

    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            CreateTween(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, WindowSize.X.Offset, 0, 38)})
        else
            CreateTween(MainFrame, TweenInfo.new(0.3), {Size = WindowSize})
        end
    end)

    -- Tab Container (Left side)
    local TabContainer = Make("Frame", MainFrame, {
        Size = UDim2.new(0, TabSize, 1, -38),
        Position = UDim2.new(0, 0, 0, 38),
        BackgroundColor3 = Theme["Color Hub 1"],
        BorderSizePixel = 0,
        Name = "TabContainer",
    })

    local tabList = Make("ScrollingFrame", TabContainer, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme["Color Theme"],
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = "Y",
    })

    Make("UIListLayout", tabList, {
        SortOrder = "LayoutOrder",
        Padding = UDim.new(0, 4),
    })

    Make("UIPadding", tabList, {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
    })

    -- Content Container (Right side)
    local ContentContainer = Make("Frame", MainFrame, {
        Size = UDim2.new(1, -TabSize - 1, 1, -38),
        Position = UDim2.new(0, TabSize + 1, 0, 38),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
        Name = "ContentContainer",
    })

    Make("UICorner", ContentContainer, {CornerRadius = UDim.new(0, 8)})

    local contentFix = Make("Frame", ContentContainer, {
        Size = UDim2.new(0, 8, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
    })

    local contentList = Make("ScrollingFrame", ContentContainer, {
        Size = UDim2.new(1, -16, 1, -16),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundTransparency = 1,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme["Color Theme"],
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = "Y",
        BorderSizePixel = 0,
    })

    Make("UIListLayout", contentList, {
        SortOrder = "LayoutOrder",
        Padding = UDim.new(0, 6),
    })

    Make("UIPadding", contentList, {
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4),
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
    })

    -- Separator line
    Make("Frame", MainFrame, {
        Size = UDim2.new(0, 1, 1, -38),
        Position = UDim2.new(0, TabSize, 0, 38),
        BackgroundColor3 = Theme["Color Stroke"],
        BorderSizePixel = 0,
    })

    -- Drag
    MakeDrag(MainFrame, TopBar)

    -- Tab system
    local Tabs = {}
    local ActiveTab = nil

    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local Tab = {}

        local tabName = tabConfig.Name or "Tab"
        local tabIcon = tabConfig.Icon or nil

        -- Tab Button
        local TabButton = Make("TextButton", tabList, {
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = Theme["Color Hub 2"],
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #Tabs + 1,
        })
        Make("UICorner", TabButton, {CornerRadius = UDim.new(0, 6)})

        local tabStroke = Make("UIStroke", TabButton, {
            Color = Theme["Color Stroke"],
            Thickness = 1,
            Transparency = 1,
        })

        local tabIndicator = Make("Frame", TabButton, {
            Size = UDim2.new(0, 3, 0.6, 0),
            Position = UDim2.new(0, 0, 0.2, 0),
            BackgroundColor3 = Theme["Color Theme"],
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
        })
        Make("UICorner", tabIndicator, {CornerRadius = UDim.new(0, 2)})

        local tabButtonContent = Make("Frame", TabButton, {
            Size = UDim2.new(1, -12, 1, 0),
            Position = UDim2.new(0, 6, 0, 0),
            BackgroundTransparency = 1,
        })

        local tabButtonList = Make("UIListLayout", tabButtonContent, {
            FillDirection = "Horizontal",
            SortOrder = "LayoutOrder",
            VerticalAlignment = "Center",
            Padding = UDim.new(0, 6),
        })

        if tabIcon then
            local iconId = Icons[tabIcon] or tabIcon
            Make("ImageLabel", tabButtonContent, {
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = iconId,
                ImageColor3 = Theme["Color Dark Text"],
                LayoutOrder = 1,
            })
        end

        local tabText = Make("TextLabel", tabButtonContent, {
            Size = UDim2.new(1, tabIcon and -22 or 0, 0, 14),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            Text = tabName,
            TextColor3 = Theme["Color Dark Text"],
            TextSize = 11,
            TextXAlignment = "Left",
            TextTruncate = "AtEnd",
            LayoutOrder = 2,
        })

        -- Tab Content
        local TabContent = Make("Frame", contentList, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Visible = false,
            Name = tabName .. "_Content",
        })

        local tabContentList = Make("UIListLayout", TabContent, {
            SortOrder = "LayoutOrder",
            Padding = UDim.new(0, 6),
        })

        Make("UIPadding", TabContent, {
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4),
        })

        -- Tab activation
        local function ActivateTab()
            if ActiveTab then
                local old = ActiveTab
                CreateTween(old.Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme["Color Hub 2"]})
                old.Indicator.BackgroundTransparency = 1
                old.Text.TextColor3 = Theme["Color Dark Text"]
                if old.Icon then
                    old.Icon.ImageColor3 = Theme["Color Dark Text"]
                end
                old.Stroke.Transparency = 1
                old.Content.Visible = false
            end

            ActiveTab = Tab
            CreateTween(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme["Color Hub 1"]})
            tabIndicator.BackgroundTransparency = 0
            tabText.TextColor3 = Theme["Color Text"]
            if tabIcon then
                local icon = tabButtonContent:FindFirstChildOfClass("ImageLabel")
                if icon then icon.ImageColor3 = Theme["Color Theme"] end
            end
            tabStroke.Transparency = 0
            TabContent.Visible = true
        end

        TabButton.MouseButton1Click:Connect(ActivateTab)

        TabButton.MouseEnter:Connect(function()
            if ActiveTab ~= Tab then
                CreateTween(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Theme["Color Hub 1"]})
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if ActiveTab ~= Tab then
                CreateTween(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Theme["Color Hub 2"]})
            end
        end)

        -- Store tab data
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Indicator = tabIndicator
        Tab.Text = tabText
        Tab.Stroke = tabStroke
        Tab.Icon = tabIcon and tabButtonContent:FindFirstChildOfClass("ImageLabel") or nil

        table.insert(Tabs, Tab)

        -- Auto-activate first tab
        if #Tabs == 1 then
            ActivateTab()
        end

        -- ===== ELEMENT CREATION METHODS =====

        -- Section
        function Tab:CreateSection(config)
            config = config or {}
            local section = {}

            local sectionFrame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
                LayoutOrder = #TabContent:GetChildren(),
            })

            local sectionTitle = Make("TextLabel", sectionFrame, {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = config.Name or "Section",
                TextColor3 = Theme["Color Text"],
                TextSize = 12,
                TextXAlignment = "Left",
            })

            local sectionLine = Make("Frame", sectionFrame, {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0, 18),
                BackgroundColor3 = Theme["Color Stroke"],
                BorderSizePixel = 0,
            })

            local sectionContent = Make("Frame", sectionFrame, {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 23),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", sectionContent, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4),
            })

            section.Frame = sectionFrame
            section.Content = sectionContent

            return section
        end

        -- Label
        function Tab:CreateLabel(config)
            config = config or {}
            local label = {}

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Label", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            label.Frame = frame
            label.Set = function(self, text)
                titleLabel.Text = text
            end

            return label
        end

        -- Button
        function Tab:CreateButton(config)
            config = config or {}
            local button = {}

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Button", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local icon = Make("ImageLabel", frame, {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(1, -26, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = Icons["chevron-right"] or "rbxassetid://10709791437",
                ImageColor3 = Theme["Color Dark Text"],
            })

            clickButton.MouseEnter:Connect(function()
                CreateTween(frame, TweenInfo.new(0.15), {BackgroundColor3 = Theme["Color Hub 1"]})
            end)

            clickButton.MouseLeave:Connect(function()
                CreateTween(frame, TweenInfo.new(0.15), {BackgroundColor3 = Theme["Color Hub 2"]})
            end)

            clickButton.MouseButton1Click:Connect(function()
                CreateTween(frame, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Theme"]})
                task.wait(0.1)
                CreateTween(frame, TweenInfo.new(0.2), {BackgroundColor3 = Theme["Color Hub 1"]})
                if config.Callback then
                    pcall(config.Callback)
                end
            end)

            button.Frame = frame
            button.Click = clickButton

            return button
        end

        -- Toggle
        function Tab:CreateToggle(config)
            config = config or {}
            local toggle = {}
            toggle.Value = config.Default or false

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Toggle", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            -- Toggle switch (Redz style)
            local toggleFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 36, 0, 20),
                Position = UDim2.new(1, -46, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = toggle.Value and Theme["Color Theme"] or Theme["Color Stroke"],
                BorderSizePixel = 0,
            })
            Make("UICorner", toggleFrame, {CornerRadius = UDim.new(1, 0)})

            local toggleCircle = Make("Frame", toggleFrame, {
                Size = UDim2.new(0, 16, 0, 16),
                Position = toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
            })
            Make("UICorner", toggleCircle, {CornerRadius = UDim.new(1, 0)})

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local function UpdateToggle()
                toggle.Value = not toggle.Value
                local targetColor = toggle.Value and Theme["Color Theme"] or Theme["Color Stroke"]
                local targetPos = toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)

                CreateTween(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
                CreateTween(toggleCircle, TweenInfo.new(0.2), {Position = targetPos})

                if config.Callback then
                    pcall(config.Callback, toggle.Value)
                end
            end

            clickButton.MouseButton1Click:Connect(UpdateToggle)

            toggle.Frame = frame
            toggle.Set = function(self, value)
                if toggle.Value ~= value then
                    toggle.Value = value
                    local targetColor = toggle.Value and Theme["Color Theme"] or Theme["Color Stroke"]
                    local targetPos = toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    CreateTween(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
                    CreateTween(toggleCircle, TweenInfo.new(0.2), {Position = targetPos})
                    if config.Callback then
                        pcall(config.Callback, toggle.Value)
                    end
                end
            end
            toggle.Get = function(self)
                return toggle.Value
            end

            return toggle
        end

        -- Slider
        function Tab:CreateSlider(config)
            config = config or {}
            local slider = {}

            local min = config.Min or 0
            local max = config.Max or 100
            local default = math.clamp(config.Default or min, min, max)
            local increment = config.Increment or 1

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Slider", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            -- Value display
            local valueLabel = Make("TextLabel", frame, {
                Size = UDim2.new(0, 40, 0, 14),
                Position = UDim2.new(1, -50, 0, 8),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = tostring(default),
                TextColor3 = Theme["Color Theme"],
                TextSize = 10,
                TextXAlignment = "Right",
            })

            -- Slider bar
            local sliderBar = Make("Frame", frame, {
                Size = UDim2.new(1, -20, 0, 4),
                Position = UDim2.new(0, 10, 1, -14),
                BackgroundColor3 = Theme["Color Stroke"],
                BorderSizePixel = 0,
            })
            Make("UICorner", sliderBar, {CornerRadius = UDim.new(1, 0)})

            local sliderFill = Make("Frame", sliderBar, {
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme["Color Theme"],
                BorderSizePixel = 0,
            })
            Make("UICorner", sliderFill, {CornerRadius = UDim.new(1, 0)})

            local sliderKnob = Make("Frame", sliderBar, {
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
            })
            Make("UICorner", sliderKnob, {CornerRadius = UDim.new(1, 0)})
            Make("UIStroke", sliderKnob, {
                Color = Theme["Color Theme"],
                Thickness = 2,
            })

            local dragging = false

            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                local value = min + (max - min) * pos
                value = math.floor(value / increment + 0.5) * increment
                value = math.clamp(value, min, max)

                local newPos = (value - min) / (max - min)
                sliderFill.Size = UDim2.new(newPos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(newPos, -6, 0.5, -6)
                valueLabel.Text = tostring(value)

                if config.Callback then
                    pcall(config.Callback, value)
                end

                return value
            end

            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    UpdateSlider(input)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            slider.Frame = frame
            slider.Set = function(self, value)
                value = math.clamp(math.floor(value / increment + 0.5) * increment, min, max)
                local newPos = (value - min) / (max - min)
                sliderFill.Size = UDim2.new(newPos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(newPos, -6, 0.5, -6)
                valueLabel.Text = tostring(value)
                if config.Callback then
                    pcall(config.Callback, value)
                end
            end
            slider.Get = function(self)
                return tonumber(valueLabel.Text) or default
            end

            return slider
        end

        -- Dropdown
        function Tab:CreateDropdown(config)
            config = config or {}
            local dropdown = {}

            local options = config.Options or {}
            local selected = config.Default or (options[1] or "")

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Dropdown", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            -- Selected value display
            local valueFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 120, 0, 22),
                Position = UDim2.new(1, -130, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Hub 1"],
                BorderSizePixel = 0,
            })
            Make("UICorner", valueFrame, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", valueFrame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local valueLabel = Make("TextLabel", valueFrame, {
                Size = UDim2.new(1, -24, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = selected,
                TextColor3 = Theme["Color Text"],
                TextSize = 9,
                TextXAlignment = "Left",
                TextTruncate = "AtEnd",
            })

            local arrowIcon = Make("ImageLabel", valueFrame, {
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(1, -16, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = Icons["chevron-down"] or "rbxassetid://10709790948",
                ImageColor3 = Theme["Color Dark Text"],
            })

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local dropdownOpen = false
            local dropdownList = nil

            local function OpenDropdown()
                if dropdownOpen then return end
                dropdownOpen = true

                CreateTween(arrowIcon, TweenInfo.new(0.2), {Rotation = 180})

                dropdownList = Make("Frame", frame, {
                    Size = UDim2.new(1, 0, 0, math.min(#options * 26 + 8, 150)),
                    Position = UDim2.new(0, 0, 1, 4),
                    BackgroundColor3 = Theme["Color Hub 2"],
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                Make("UICorner", dropdownList, {CornerRadius = UDim.new(0, 6)})
                Make("UIStroke", dropdownList, {
                    Color = Theme["Color Stroke"],
                    Thickness = 1,
                })

                local scroll = Make("ScrollingFrame", dropdownList, {
                    Size = UDim2.new(1, -8, 1, -8),
                    Position = UDim2.new(0, 4, 0, 4),
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = Theme["Color Theme"],
                    CanvasSize = UDim2.new(0, 0, 0, #options * 26),
                    ZIndex = 10,
                })

                for i, option in ipairs(options) do
                    local optionBtn = Make("TextButton", scroll, {
                        Size = UDim2.new(1, 0, 0, 26),
                        Position = UDim2.new(0, 0, 0, (i-1) * 26),
                        BackgroundColor3 = option == selected and Theme["Color Theme"] or Theme["Color Hub 2"],
                        Text = "",
                        AutoButtonColor = false,
                        ZIndex = 10,
                    })
                    Make("UICorner", optionBtn, {CornerRadius = UDim.new(0, 4)})

                    local optionText = Make("TextLabel", optionBtn, {
                        Size = UDim2.new(1, -16, 1, 0),
                        Position = UDim2.new(0, 8, 0, 0),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.Gotham,
                        Text = option,
                        TextColor3 = option == selected and Color3.fromRGB(255,255,255) or Theme["Color Text"],
                        TextSize = 10,
                        TextXAlignment = "Left",
                        ZIndex = 10,
                    })

                    optionBtn.MouseEnter:Connect(function()
                        if option ~= selected then
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 1"]})
                        end
                    end)

                    optionBtn.MouseLeave:Connect(function()
                        if option ~= selected then
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 2"]})
                        end
                    end)

                    optionBtn.MouseButton1Click:Connect(function()
                        selected = option
                        valueLabel.Text = selected

                        for _, child in ipairs(scroll:GetChildren()) do
                            if child:IsA("TextButton") then
                                local txt = child:FindFirstChildOfClass("TextLabel")
                                if txt and txt.Text == selected then
                                    CreateTween(child, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Theme"]})
                                    txt.TextColor3 = Color3.fromRGB(255,255,255)
                                else
                                    CreateTween(child, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 2"]})
                                    if txt then txt.TextColor3 = Theme["Color Text"] end
                                end
                            end
                        end

                        task.wait(0.1)
                        if dropdownList then
                            dropdownList:Destroy()
                            dropdownList = nil
                        end
                        dropdownOpen = false
                        CreateTween(arrowIcon, TweenInfo.new(0.2), {Rotation = 0})

                        if config.Callback then
                            pcall(config.Callback, selected)
                        end
                    end)
                end
            end

            local function CloseDropdown()
                if dropdownList then
                    dropdownList:Destroy()
                    dropdownList = nil
                end
                dropdownOpen = false
                CreateTween(arrowIcon, TweenInfo.new(0.2), {Rotation = 0})
            end

            clickButton.MouseButton1Click:Connect(function()
                if dropdownOpen then
                    CloseDropdown()
                else
                    OpenDropdown()
                end
            end)

            -- Close when clicking outside
            UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
                    local pos = input.Position
                    if dropdownList then
                        local absPos = dropdownList.AbsolutePosition
                        local absSize = dropdownList.AbsoluteSize
                        if pos.X < absPos.X or pos.X > absPos.X + absSize.X or pos.Y < absPos.Y or pos.Y > absPos.Y + absSize.Y then
                            local framePos = frame.AbsolutePosition
                            local frameSize = frame.AbsoluteSize
                            if pos.X < framePos.X or pos.X > framePos.X + frameSize.X or pos.Y < framePos.Y or pos.Y > framePos.Y + frameSize.Y then
                                CloseDropdown()
                            end
                        end
                    end
                end
            end)

            dropdown.Frame = frame
            dropdown.Set = function(self, value)
                if table.find(options, value) then
                    selected = value
                    valueLabel.Text = selected
                    if config.Callback then
                        pcall(config.Callback, selected)
                    end
                end
            end
            dropdown.Get = function(self)
                return selected
            end
            dropdown.Refresh = function(self, newOptions, keepSelected)
                options = newOptions
                if not keepSelected or not table.find(options, selected) then
                    selected = options[1] or ""
                    valueLabel.Text = selected
                end
            end

            return dropdown
        end

        -- TextBox (Input)
        function Tab:CreateInput(config)
            config = config or {}
            local input = {}

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Input", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local textBox = Make("TextBox", frame, {
                Size = UDim2.new(0, 120, 0, 24),
                Position = UDim2.new(1, -130, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Hub 1"],
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                Text = config.Default or "",
                TextColor3 = Theme["Color Text"],
                TextSize = 10,
                TextXAlignment = "Left",
                ClearTextOnFocus = false,
                PlaceholderText = config.Placeholder or "",
                PlaceholderColor3 = Theme["Color Dark Text"],
            })
            Make("UICorner", textBox, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", textBox, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })
            Make("UIPadding", textBox, {
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
            })

            textBox.Focused:Connect(function()
                CreateTween(textBox:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2), {Color = Theme["Color Theme"]})
            end)

            textBox.FocusLost:Connect(function(enterPressed)
                CreateTween(textBox:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2), {Color = Theme["Color Stroke"]})
                if config.Callback then
                    pcall(config.Callback, textBox.Text, enterPressed)
                end
            end)

            input.Frame = frame
            input.Set = function(self, text)
                textBox.Text = text
                if config.Callback then
                    pcall(config.Callback, textBox.Text, false)
                end
            end
            input.Get = function(self)
                return textBox.Text
            end

            return input
        end

        -- Keybind
        function Tab:CreateKeybind(config)
            config = config or {}
            local keybind = {}

            local currentKey = config.Default or nil

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Keybind", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local keyFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 60, 0, 22),
                Position = UDim2.new(1, -70, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Hub 1"],
                BorderSizePixel = 0,
            })
            Make("UICorner", keyFrame, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", keyFrame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local keyLabel = Make("TextLabel", keyFrame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = currentKey and tostring(currentKey):gsub("Enum.KeyCode.", "") or "None",
                TextColor3 = Theme["Color Text"],
                TextSize = 9,
            })

            local keyButton = Make("TextButton", keyFrame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local listening = false

            keyButton.MouseButton1Click:Connect(function()
                listening = true
                keyLabel.Text = "..."
                CreateTween(keyFrame:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2), {Color = Theme["Color Theme"]})
            end)

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if listening and not gameProcessed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        keyLabel.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
                        listening = false
                        CreateTween(keyFrame:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2), {Color = Theme["Color Stroke"]})
                        if config.Callback then
                            pcall(config.Callback, currentKey)
                        end
                    end
                elseif currentKey and input.KeyCode == currentKey and not gameProcessed then
                    if config.Callback then
                        pcall(config.Callback, currentKey)
                    end
                end
            end)

            keybind.Frame = frame
            keybind.Set = function(self, key)
                currentKey = key
                keyLabel.Text = key and tostring(key):gsub("Enum.KeyCode.", "") or "None"
            end
            keybind.Get = function(self)
                return currentKey
            end

            return keybind
        end

        -- Color Picker
        function Tab:CreateColorPicker(config)
            config = config or {}
            local picker = {}

            local currentColor = config.Default or Color3.fromRGB(255, 255, 255)

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Color Picker", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local colorPreview = Make("Frame", frame, {
                Size = UDim2.new(0, 28, 0, 22),
                Position = UDim2.new(1, -38, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = currentColor,
                BorderSizePixel = 0,
            })
            Make("UICorner", colorPreview, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", colorPreview, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local pickerOpen = false
            local pickerFrame = nil

            clickButton.MouseButton1Click:Connect(function()
                if pickerOpen then
                    if pickerFrame then pickerFrame:Destroy() pickerFrame = nil end
                    pickerOpen = false
                    return
                end

                pickerOpen = true
                pickerFrame = Make("Frame", frame, {
                    Size = UDim2.new(0, 180, 0, 140),
                    Position = UDim2.new(1, -190, 1, 4),
                    BackgroundColor3 = Theme["Color Hub 2"],
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                Make("UICorner", pickerFrame, {CornerRadius = UDim.new(0, 6)})
                Make("UIStroke", pickerFrame, {
                    Color = Theme["Color Stroke"],
                    Thickness = 1,
                })

                -- Simple RGB sliders
                local r = math.floor(currentColor.R * 255)
                local g = math.floor(currentColor.G * 255)
                local b = math.floor(currentColor.B * 255)

                local function createChannelSlider(name, value, yPos, color)
                    local label = Make("TextLabel", pickerFrame, {
                        Size = UDim2.new(0, 20, 0, 14),
                        Position = UDim2.new(0, 8, 0, yPos),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = color,
                        TextSize = 10,
                        ZIndex = 10,
                    })

                    local bar = Make("Frame", pickerFrame, {
                        Size = UDim2.new(1, -40, 0, 6),
                        Position = UDim2.new(0, 32, 0, yPos + 4),
                        BackgroundColor3 = Theme["Color Stroke"],
                        BorderSizePixel = 0,
                        ZIndex = 10,
                    })
                    Make("UICorner", bar, {CornerRadius = UDim.new(1, 0)})

                    local fill = Make("Frame", bar, {
                        Size = UDim2.new(value / 255, 0, 1, 0),
                        BackgroundColor3 = color,
                        BorderSizePixel = 0,
                        ZIndex = 10,
                    })
                    Make("UICorner", fill, {CornerRadius = UDim.new(1, 0)})

                    return bar, fill
                end

                local rBar, rFill = createChannelSlider("R", r, 10, Color3.fromRGB(255, 80, 80))
                local gBar, gFill = createChannelSlider("G", g, 40, Color3.fromRGB(80, 255, 80))
                local bBar, bFill = createChannelSlider("B", b, 70, Color3.fromRGB(80, 80, 255))

                local preview = Make("Frame", pickerFrame, {
                    Size = UDim2.new(0, 40, 0, 24),
                    Position = UDim2.new(0.5, -20, 0, 100),
                    BackgroundColor3 = currentColor,
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                Make("UICorner", preview, {CornerRadius = UDim.new(0, 4)})

                local function updateColor()
                    currentColor = Color3.fromRGB(r, g, b)
                    colorPreview.BackgroundColor3 = currentColor
                    preview.BackgroundColor3 = currentColor
                    if config.Callback then
                        pcall(config.Callback, currentColor)
                    end
                end

                local function setupSlider(bar, fill, channel)
                    local dragging = false
                    bar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                            local val = math.floor(pos * 255)
                            if channel == "R" then r = val
                            elseif channel == "G" then g = val
                            else b = val end
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            updateColor()
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                            local val = math.floor(pos * 255)
                            if channel == "R" then r = val
                            elseif channel == "G" then g = val
                            else b = val end
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            updateColor()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                end

                setupSlider(rBar, rFill, "R")
                setupSlider(gBar, gFill, "G")
                setupSlider(bBar, bFill, "B")
            end)

            picker.Frame = frame
            picker.Set = function(self, color)
                currentColor = color
                colorPreview.BackgroundColor3 = currentColor
                if config.Callback then
                    pcall(config.Callback, currentColor)
                end
            end
            picker.Get = function(self)
                return currentColor
            end

            return picker
        end

        -- Paragraph
        function Tab:CreateParagraph(config)
            config = config or {}
            local paragraph = {}

            local frame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                LayoutOrder = #TabContent:GetChildren(),
            })
            Make("UICorner", frame, {CornerRadius = UDim.new(0, 6)})
            Make("UIStroke", frame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local content = Make("Frame", frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", content, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4),
            })

            Make("UIPadding", content, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
            })

            if config.Title then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = config.Title,
                    TextColor3 = Theme["Color Text"],
                    TextSize = 11,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                    RichText = true,
                })
            end

            if config.Content then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = config.Content,
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 10,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                    RichText = true,
                })
            end

            paragraph.Frame = frame
            paragraph.SetTitle = function(self, text)
                local labels = content:GetChildren()
                for _, label in ipairs(labels) do
                    if label:IsA("TextLabel") and label.Font == Enum.Font.GothamBold then
                        label.Text = text
                        return
                    end
                end
            end
            paragraph.SetContent = function(self, text)
                local labels = content:GetChildren()
                for _, label in ipairs(labels) do
                    if label:IsA("TextLabel") and label.Font == Enum.Font.Gotham then
                        label.Text = text
                        return
                    end
                end
            end

            return paragraph
        end

        -- Divider
        function Tab:CreateDivider(config)
            config = config or {}
            local divider = {}

            local frame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                LayoutOrder = #TabContent:GetChildren(),
            })

            local line = Make("Frame", frame, {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Stroke"],
                BorderSizePixel = 0,
            })

            if config.Text and config.Text ~= "" then
                line.Size = UDim2.new(1, 0, 0, 1)

                local textLabel = Make("TextLabel", frame, {
                    Size = UDim2.new(0, 0, 0, 14),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Theme["Color Hub 2"],
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Font = Enum.Font.Gotham,
                    Text = " " .. config.Text .. " ",
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 9,
                    AutomaticSize = "X",
                })

                local leftLine = Make("Frame", frame, {
                    Size = UDim2.new(0.5, -textLabel.AbsoluteSize.X/2 - 4, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme["Color Stroke"],
                    BorderSizePixel = 0,
                })

                local rightLine = Make("Frame", frame, {
                    Size = UDim2.new(0.5, -textLabel.AbsoluteSize.X/2 - 4, 0, 1),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Theme["Color Stroke"],
                    BorderSizePixel = 0,
                })

                line:Destroy()
            end

            divider.Frame = frame

            return divider
        end

        -- ===== GENESISX2 UNIQUE ELEMENTS (adapted to Redz visual style) =====

        -- Number Input (unique to GenesisX2)
        function Tab:CreateNumberInput(config)
            config = config or {}
            local numberInput = {}

            local min = config.Min or -math.huge
            local max = config.Max or math.huge
            local default = config.Default or 0

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Number Input", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local valueFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 80, 0, 24),
                Position = UDim2.new(1, -90, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Hub 1"],
                BorderSizePixel = 0,
            })
            Make("UICorner", valueFrame, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", valueFrame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local textBox = Make("TextBox", valueFrame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = tostring(default),
                TextColor3 = Theme["Color Text"],
                TextSize = 10,
                TextXAlignment = "Center",
                ClearTextOnFocus = false,
            })

            textBox.FocusLost:Connect(function()
                local num = tonumber(textBox.Text)
                if num then
                    num = math.clamp(num, min, max)
                    textBox.Text = tostring(num)
                    if config.Callback then
                        pcall(config.Callback, num)
                    end
                else
                    textBox.Text = tostring(default)
                end
            end)

            numberInput.Frame = frame
            numberInput.Set = function(self, value)
                value = math.clamp(value, min, max)
                textBox.Text = tostring(value)
                if config.Callback then
                    pcall(config.Callback, value)
                end
            end
            numberInput.Get = function(self)
                return tonumber(textBox.Text) or default
            end

            return numberInput
        end

        -- Multi Dropdown (unique to GenesisX2)
        function Tab:CreateMultiDropdown(config)
            config = config or {}
            local multiDropdown = {}

            local options = config.Options or {}
            local selected = config.Default or {}
            if type(selected) == "string" then selected = {selected} end

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Multi Dropdown", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local valueFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 120, 0, 22),
                Position = UDim2.new(1, -130, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme["Color Hub 1"],
                BorderSizePixel = 0,
            })
            Make("UICorner", valueFrame, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", valueFrame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local valueLabel = Make("TextLabel", valueFrame, {
                Size = UDim2.new(1, -24, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                Text = #selected > 0 and table.concat(selected, ", ") or "None",
                TextColor3 = Theme["Color Text"],
                TextSize = 9,
                TextXAlignment = "Left",
                TextTruncate = "AtEnd",
            })

            local arrowIcon = Make("ImageLabel", valueFrame, {
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(1, -16, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = Icons["chevron-down"] or "rbxassetid://10709790948",
                ImageColor3 = Theme["Color Dark Text"],
            })

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local dropdownOpen = false
            local dropdownList = nil

            local function updateLabel()
                if #selected > 0 then
                    valueLabel.Text = table.concat(selected, ", ")
                else
                    valueLabel.Text = "None"
                end
            end

            local function OpenDropdown()
                if dropdownOpen then return end
                dropdownOpen = true

                CreateTween(arrowIcon, TweenInfo.new(0.2), {Rotation = 180})

                dropdownList = Make("Frame", frame, {
                    Size = UDim2.new(1, 0, 0, math.min(#options * 26 + 8, 150)),
                    Position = UDim2.new(0, 0, 1, 4),
                    BackgroundColor3 = Theme["Color Hub 2"],
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                Make("UICorner", dropdownList, {CornerRadius = UDim.new(0, 6)})
                Make("UIStroke", dropdownList, {
                    Color = Theme["Color Stroke"],
                    Thickness = 1,
                })

                local scroll = Make("ScrollingFrame", dropdownList, {
                    Size = UDim2.new(1, -8, 1, -8),
                    Position = UDim2.new(0, 4, 0, 4),
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = Theme["Color Theme"],
                    CanvasSize = UDim2.new(0, 0, 0, #options * 26),
                    ZIndex = 10,
                })

                for i, option in ipairs(options) do
                    local isSelected = table.find(selected, option) ~= nil

                    local optionBtn = Make("TextButton", scroll, {
                        Size = UDim2.new(1, 0, 0, 26),
                        Position = UDim2.new(0, 0, 0, (i-1) * 26),
                        BackgroundColor3 = isSelected and Theme["Color Theme"] or Theme["Color Hub 2"],
                        Text = "",
                        AutoButtonColor = false,
                        ZIndex = 10,
                    })
                    Make("UICorner", optionBtn, {CornerRadius = UDim.new(0, 4)})

                    local checkIcon = Make("ImageLabel", optionBtn, {
                        Size = UDim2.new(0, 14, 0, 14),
                        Position = UDim2.new(0, 8, 0.5, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundTransparency = 1,
                        Image = isSelected and (Icons["check"] or "rbxassetid://10709790644") or "",
                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                        ZIndex = 10,
                    })

                    local optionText = Make("TextLabel", optionBtn, {
                        Size = UDim2.new(1, -30, 1, 0),
                        Position = UDim2.new(0, 26, 0, 0),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.Gotham,
                        Text = option,
                        TextColor3 = isSelected and Color3.fromRGB(255,255,255) or Theme["Color Text"],
                        TextSize = 10,
                        TextXAlignment = "Left",
                        ZIndex = 10,
                    })

                    optionBtn.MouseEnter:Connect(function()
                        if not table.find(selected, option) then
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 1"]})
                        end
                    end)

                    optionBtn.MouseLeave:Connect(function()
                        if not table.find(selected, option) then
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 2"]})
                        end
                    end)

                    optionBtn.MouseButton1Click:Connect(function()
                        local idx = table.find(selected, option)
                        if idx then
                            table.remove(selected, idx)
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Hub 2"]})
                            optionText.TextColor3 = Theme["Color Text"]
                            checkIcon.Image = ""
                        else
                            table.insert(selected, option)
                            CreateTween(optionBtn, TweenInfo.new(0.1), {BackgroundColor3 = Theme["Color Theme"]})
                            optionText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            checkIcon.Image = Icons["check"] or "rbxassetid://10709790644"
                        end
                        updateLabel()
                        if config.Callback then
                            pcall(config.Callback, selected)
                        end
                    end)
                end
            end

            local function CloseDropdown()
                if dropdownList then
                    dropdownList:Destroy()
                    dropdownList = nil
                end
                dropdownOpen = false
                CreateTween(arrowIcon, TweenInfo.new(0.2), {Rotation = 0})
            end

            clickButton.MouseButton1Click:Connect(function()
                if dropdownOpen then
                    CloseDropdown()
                else
                    OpenDropdown()
                end
            end)

            UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
                    local pos = input.Position
                    if dropdownList then
                        local absPos = dropdownList.AbsolutePosition
                        local absSize = dropdownList.AbsoluteSize
                        if pos.X < absPos.X or pos.X > absPos.X + absSize.X or pos.Y < absPos.Y or pos.Y > absPos.Y + absSize.Y then
                            local framePos = frame.AbsolutePosition
                            local frameSize = frame.AbsoluteSize
                            if pos.X < framePos.X or pos.X > framePos.X + frameSize.X or pos.Y < framePos.Y or pos.Y > framePos.Y + frameSize.Y then
                                CloseDropdown()
                            end
                        end
                    end
                end
            end)

            multiDropdown.Frame = frame
            multiDropdown.Set = function(self, values)
                selected = values
                updateLabel()
                if config.Callback then
                    pcall(config.Callback, selected)
                end
            end
            multiDropdown.Get = function(self)
                return selected
            end
            multiDropdown.Refresh = function(self, newOptions, keepSelected)
                options = newOptions
                if not keepSelected then
                    selected = {}
                else
                    local newSelected = {}
                    for _, v in ipairs(selected) do
                        if table.find(options, v) then
                            table.insert(newSelected, v)
                        end
                    end
                    selected = newSelected
                end
                updateLabel()
            end

            return multiDropdown
        end

        -- Checkbox (unique to GenesisX2)
        function Tab:CreateCheckbox(config)
            config = config or {}
            local checkbox = {}
            checkbox.Value = config.Default or false

            local frame, titleLabel, descLabel = ButtonFrame(TabContent, config.Name or "Checkbox", config.Description)
            frame.LayoutOrder = #TabContent:GetChildren()

            local checkFrame = Make("Frame", frame, {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(1, -28, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = checkbox.Value and Theme["Color Theme"] or Theme["Color Hub 1"],
                BorderSizePixel = 0,
            })
            Make("UICorner", checkFrame, {CornerRadius = UDim.new(0, 4)})
            Make("UIStroke", checkFrame, {
                Color = checkbox.Value and Theme["Color Theme"] or Theme["Color Stroke"],
                Thickness = 1,
            })

            local checkIcon = Make("ImageLabel", checkFrame, {
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = checkbox.Value and (Icons["check"] or "rbxassetid://10709790644") or "",
                ImageColor3 = Color3.fromRGB(255, 255, 255),
            })

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local function UpdateCheckbox()
                checkbox.Value = not checkbox.Value
                local targetColor = checkbox.Value and Theme["Color Theme"] or Theme["Color Hub 1"]
                local strokeColor = checkbox.Value and Theme["Color Theme"] or Theme["Color Stroke"]

                CreateTween(checkFrame, TweenInfo.new(0.15), {BackgroundColor3 = targetColor})
                CreateTween(checkFrame:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.15), {Color = strokeColor})
                checkIcon.Image = checkbox.Value and (Icons["check"] or "rbxassetid://10709790644") or ""

                if config.Callback then
                    pcall(config.Callback, checkbox.Value)
                end
            end

            clickButton.MouseButton1Click:Connect(UpdateCheckbox)

            checkbox.Frame = frame
            checkbox.Set = function(self, value)
                if checkbox.Value ~= value then
                    checkbox.Value = value
                    local targetColor = checkbox.Value and Theme["Color Theme"] or Theme["Color Hub 1"]
                    local strokeColor = checkbox.Value and Theme["Color Theme"] or Theme["Color Stroke"]
                    CreateTween(checkFrame, TweenInfo.new(0.15), {BackgroundColor3 = targetColor})
                    CreateTween(checkFrame:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.15), {Color = strokeColor})
                    checkIcon.Image = checkbox.Value and (Icons["check"] or "rbxassetid://10709790644") or ""
                    if config.Callback then
                        pcall(config.Callback, checkbox.Value)
                    end
                end
            end
            checkbox.Get = function(self)
                return checkbox.Value
            end

            return checkbox
        end

        -- LabelToggleSubTitle (unique to GenesisX2)
        function Tab:CreateLabelToggleSubTitle(config)
            config = config or {}
            local lts = {}

            local frame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                LayoutOrder = #TabContent:GetChildren(),
            })
            Make("UICorner", frame, {CornerRadius = UDim.new(0, 6)})
            Make("UIStroke", frame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local content = Make("Frame", frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", content, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 2),
            })

            Make("UIPadding", content, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
            })

            -- Title row with toggle
            local titleRow = Make("Frame", content, {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
            })

            local titleLabel = Make("TextLabel", titleRow, {
                Size = UDim2.new(1, -50, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = config.Name or "Label Toggle",
                TextColor3 = Theme["Color Text"],
                TextSize = 11,
                TextXAlignment = "Left",
                TextTruncate = "AtEnd",
            })

            -- Toggle switch
            local toggleValue = config.Default or false
            local toggleFrame = Make("Frame", titleRow, {
                Size = UDim2.new(0, 36, 0, 20),
                Position = UDim2.new(1, -36, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = toggleValue and Theme["Color Theme"] or Theme["Color Stroke"],
                BorderSizePixel = 0,
            })
            Make("UICorner", toggleFrame, {CornerRadius = UDim.new(1, 0)})

            local toggleCircle = Make("Frame", toggleFrame, {
                Size = UDim2.new(0, 16, 0, 16),
                Position = toggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
            })
            Make("UICorner", toggleCircle, {CornerRadius = UDim.new(1, 0)})

            -- Subtitle
            if config.SubTitle and config.SubTitle ~= "" then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = config.SubTitle,
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 9,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                })
            end

            local clickButton = Make("TextButton", frame, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
            })

            local function UpdateToggle()
                toggleValue = not toggleValue
                local targetColor = toggleValue and Theme["Color Theme"] or Theme["Color Stroke"]
                local targetPos = toggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)

                CreateTween(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
                CreateTween(toggleCircle, TweenInfo.new(0.2), {Position = targetPos})

                if config.Callback then
                    pcall(config.Callback, toggleValue)
                end
            end

            clickButton.MouseButton1Click:Connect(UpdateToggle)

            lts.Frame = frame
            lts.Set = function(self, value)
                if toggleValue ~= value then
                    toggleValue = value
                    local targetColor = toggleValue and Theme["Color Theme"] or Theme["Color Stroke"]
                    local targetPos = toggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    CreateTween(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
                    CreateTween(toggleCircle, TweenInfo.new(0.2), {Position = targetPos})
                    if config.Callback then
                        pcall(config.Callback, toggleValue)
                    end
                end
            end
            lts.Get = function(self)
                return toggleValue
            end

            return lts
        end

        -- StatusCard (unique to GenesisX2)
        function Tab:CreateStatusCard(config)
            config = config or {}
            local statusCard = {}

            local frame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = "Y",
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                LayoutOrder = #TabContent:GetChildren(),
            })
            Make("UICorner", frame, {CornerRadius = UDim.new(0, 6)})
            Make("UIStroke", frame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local content = Make("Frame", frame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", content, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4),
            })

            Make("UIPadding", content, {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
            })

            -- Status indicator
            local statusRow = Make("Frame", content, {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
            })

            local statusDot = Make("Frame", statusRow, {
                Size = UDim2.new(0, 8, 0, 8),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = config.StatusColor or Theme["Color Theme"],
                BorderSizePixel = 0,
            })
            Make("UICorner", statusDot, {CornerRadius = UDim.new(1, 0)})

            local statusLabel = Make("TextLabel", statusRow, {
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Text = config.Status or "Active",
                TextColor3 = config.StatusColor or Theme["Color Theme"],
                TextSize = 10,
                TextXAlignment = "Left",
            })

            if config.Name then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = config.Name,
                    TextColor3 = Theme["Color Text"],
                    TextSize = 12,
                    TextXAlignment = "Left",
                })
            end

            if config.Description then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = config.Description,
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 9,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                })
            end

            statusCard.Frame = frame
            statusCard.SetStatus = function(self, status, color)
                statusLabel.Text = status
                statusLabel.TextColor3 = color or Theme["Color Theme"]
                statusDot.BackgroundColor3 = color or Theme["Color Theme"]
            end

            return statusCard
        end

        -- ImageLabel (unique to GenesisX2)
        function Tab:CreateImageLabel(config)
            config = config or {}
            local imageLabel = {}

            local frame = Make("Frame", TabContent, {
                Size = UDim2.new(1, 0, 0, config.Size and config.Size.Y.Offset or 120),
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                LayoutOrder = #TabContent:GetChildren(),
            })
            Make("UICorner", frame, {CornerRadius = UDim.new(0, 6)})
            Make("UIStroke", frame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local image = Make("ImageLabel", frame, {
                Size = UDim2.new(1, -8, 1, -8),
                Position = UDim2.new(0, 4, 0, 4),
                BackgroundTransparency = 1,
                Image = config.Image or "",
                ScaleType = config.ScaleType or "Fit",
            })
            Make("UICorner", image, {CornerRadius = UDim.new(0, 4)})

            imageLabel.Frame = frame
            imageLabel.SetImage = function(self, img)
                image.Image = img
            end

            return imageLabel
        end

        -- Notification (Window-level, adapted to Redz style)
        function Window:Notify(config)
            config = config or {}

            local notifFrame = Make("Frame", ScreenGui, {
                Size = UDim2.new(0, 260, 0, 0),
                Position = UDim2.new(1, -280, 1, -20),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                AutomaticSize = "Y",
                ClipsDescendants = true,
            })
            Make("UICorner", notifFrame, {CornerRadius = UDim.new(0, 8)})
            Make("UIStroke", notifFrame, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local content = Make("Frame", notifFrame, {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", content, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 4),
            })

            Make("UIPadding", content, {
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
            })

            -- Title row
            local titleRow = Make("Frame", content, {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
            })

            local notifIcon = Make("ImageLabel", titleRow, {
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = Icons["info"] or "rbxassetid://10723415903",
                ImageColor3 = config.Type == "Error" and Color3.fromRGB(255, 80, 80) or config.Type == "Warning" and Color3.fromRGB(255, 180, 0) or Theme["Color Theme"],
            })

            Make("TextLabel", titleRow, {
                Size = UDim2.new(1, -24, 1, 0),
                Position = UDim2.new(0, 22, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = config.Title or "Notification",
                TextColor3 = Theme["Color Text"],
                TextSize = 11,
                TextXAlignment = "Left",
                TextTruncate = "AtEnd",
            })

            if config.Content then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = config.Content,
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 10,
                    TextXAlignment = "Left",
                    TextWrapped = true,
                })
            end

            -- Animate in
            notifFrame.Position = UDim2.new(1, 20, 1, -20)
            CreateTween(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -280, 1, -20),
            })

            -- Auto dismiss
            local duration = config.Duration or 3
            task.delay(duration, function()
                CreateTween(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.new(1, 20, 1, -20),
                })
                task.wait(0.3)
                notifFrame:Destroy()
            end)
        end

        -- Dialog (Window-level, adapted to Redz style)
        function Window:Dialog(config)
            config = config or {}

            local dialogFrame = Make("Frame", ScreenGui, {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundTransparency = 0.5,
                ZIndex = 100,
            })

            local dialogBox = Make("Frame", dialogFrame, {
                Size = UDim2.new(0, 300, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Theme["Color Hub 2"],
                BorderSizePixel = 0,
                AutomaticSize = "Y",
            })
            Make("UICorner", dialogBox, {CornerRadius = UDim.new(0, 10)})
            Make("UIStroke", dialogBox, {
                Color = Theme["Color Stroke"],
                Thickness = 1,
            })

            local content = Make("Frame", dialogBox, {
                Size = UDim2.new(1, -30, 0, 0),
                Position = UDim2.new(0, 15, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 1,
            })

            Make("UIListLayout", content, {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0, 8),
            })

            Make("UIPadding", content, {
                PaddingTop = UDim.new(0, 15),
                PaddingBottom = UDim.new(0, 15),
            })

            if config.Title then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = config.Title,
                    TextColor3 = Theme["Color Text"],
                    TextSize = 14,
                    TextXAlignment = "Center",
                    TextWrapped = true,
                })
            end

            if config.Content then
                Make("TextLabel", content, {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = "Y",
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = config.Content,
                    TextColor3 = Theme["Color Dark Text"],
                    TextSize = 11,
                    TextXAlignment = "Center",
                    TextWrapped = true,
                })
            end

            -- Buttons row
            local buttonsRow = Make("Frame", content, {
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
            })

            local buttonsList = Make("UIListLayout", buttonsRow, {
                FillDirection = "Horizontal",
                HorizontalAlignment = "Center",
                Padding = UDim.new(0, 10),
            })

            local buttons = config.Buttons or {{Title = "OK", Callback = function() end}}

            for _, btnConfig in ipairs(buttons) do
                local btn = Make("TextButton", buttonsRow, {
                    Size = UDim2.new(0, 80, 0, 30),
                    BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"] or Theme["Color Hub 1"],
                    Text = btnConfig.Title or "Button",
                    Font = Enum.Font.GothamMedium,
                    TextColor3 = btnConfig.Primary and Color3.fromRGB(255, 255, 255) or Theme["Color Text"],
                    TextSize = 11,
                    AutoButtonColor = false,
                })
                Make("UICorner", btn, {CornerRadius = UDim.new(0, 6)})
                Make("UIStroke", btn, {
                    Color = Theme["Color Stroke"],
                    Thickness = 1,
                })

                btn.MouseEnter:Connect(function()
                    CreateTween(btn, TweenInfo.new(0.15), {BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"]:Lerp(Color3.fromRGB(255,255,255), 0.2) or Theme["Color Hub 1"]:Lerp(Color3.fromRGB(255,255,255), 0.1)})
                end)

                btn.MouseLeave:Connect(function()
                    CreateTween(btn, TweenInfo.new(0.15), {BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"] or Theme["Color Hub 1"]})
                end)

                btn.MouseButton1Click:Connect(function()
                    CreateTween(dialogFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                    CreateTween(dialogBox, TweenInfo.new(0.2), {Size = UDim2.new(0, 300, 0, 0)})
                    task.wait(0.2)
                    dialogFrame:Destroy()
                    if btnConfig.Callback then
                        pcall(btnConfig.Callback)
                    end
                end)
            end

            -- Animate in
            dialogBox.Size = UDim2.new(0, 300, 0, 0)
            CreateTween(dialogBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 300, 0, dialogBox.AbsoluteSize.Y),
            })
        end

        return Tab
    end

    -- Window methods
    function Window:SelectTab(tabIndex)
        if Tabs[tabIndex] then
            Tabs[tabIndex].Button.MouseButton1Click:Fire()
        end
    end

    function Window:SetTheme(color)
    Theme["Color Theme"] = color
    Theme.Accent = color
    Theme.AccentHover = color
    Theme.ToggleOn = color
    GenesisX.Theme = Theme
end

    function Window:Destroy()
        ScreenGui:Destroy()
    end

    return Window
end

-- // Notification (global, standalone)
function GenesisX:Notify(config)
    config = config or {}

    local ScreenGui = Make("ScreenGui", CoreGui, {
        Name = "GenesisX_Notif_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    local notifFrame = Make("Frame", ScreenGui, {
        Size = UDim2.new(0, 260, 0, 0),
        Position = UDim2.new(1, -280, 1, -20),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
        AutomaticSize = "Y",
        ClipsDescendants = true,
    })
    Make("UICorner", notifFrame, {CornerRadius = UDim.new(0, 8)})
    Make("UIStroke", notifFrame, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
    })

    local content = Make("Frame", notifFrame, {
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
    })

    Make("UIListLayout", content, {
        SortOrder = "LayoutOrder",
        Padding = UDim.new(0, 4),
    })

    Make("UIPadding", content, {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
    })

    local titleRow = Make("Frame", content, {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
    })

    local notifIcon = Make("ImageLabel", titleRow, {
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundTransparency = 1,
        Image = Icons["info"] or "rbxassetid://10723415903",
        ImageColor3 = config.Type == "Error" and Color3.fromRGB(255, 80, 80) or config.Type == "Warning" and Color3.fromRGB(255, 180, 0) or Theme["Color Theme"],
    })

    Make("TextLabel", titleRow, {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 22, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = config.Title or "Notification",
        TextColor3 = Theme["Color Text"],
        TextSize = 11,
        TextXAlignment = "Left",
        TextTruncate = "AtEnd",
    })

    if config.Content then
        Make("TextLabel", content, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = config.Content,
            TextColor3 = Theme["Color Dark Text"],
            TextSize = 10,
            TextXAlignment = "Left",
            TextWrapped = true,
        })
    end

    notifFrame.Position = UDim2.new(1, 20, 1, -20)
    CreateTween(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -280, 1, -20),
    })

    local duration = config.Duration or 3
    task.delay(duration, function()
        CreateTween(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 1, -20),
        })
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
end

-- // Dialog (global, standalone)
function GenesisX:Dialog(config)
    config = config or {}

    local ScreenGui = Make("ScreenGui", CoreGui, {
        Name = "GenesisX_Dialog_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    local dialogFrame = Make("Frame", ScreenGui, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        ZIndex = 100,
    })

    local dialogBox = Make("Frame", dialogFrame, {
        Size = UDim2.new(0, 300, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme["Color Hub 2"],
        BorderSizePixel = 0,
        AutomaticSize = "Y",
    })
    Make("UICorner", dialogBox, {CornerRadius = UDim.new(0, 10)})
    Make("UIStroke", dialogBox, {
        Color = Theme["Color Stroke"],
        Thickness = 1,
    })

    local content = Make("Frame", dialogBox, {
        Size = UDim2.new(1, -30, 0, 0),
        Position = UDim2.new(0, 15, 0, 0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
    })

    Make("UIListLayout", content, {
        SortOrder = "LayoutOrder",
        Padding = UDim.new(0, 8),
    })

    Make("UIPadding", content, {
        PaddingTop = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
    })

    if config.Title then
        Make("TextLabel", content, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            Text = config.Title,
            TextColor3 = Theme["Color Text"],
            TextSize = 14,
            TextXAlignment = "Center",
            TextWrapped = true,
        })
    end

    if config.Content then
        Make("TextLabel", content, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = config.Content,
            TextColor3 = Theme["Color Dark Text"],
            TextSize = 11,
            TextXAlignment = "Center",
            TextWrapped = true,
        })
    end

    local buttonsRow = Make("Frame", content, {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
    })

    Make("UIListLayout", buttonsRow, {
        FillDirection = "Horizontal",
        HorizontalAlignment = "Center",
        Padding = UDim.new(0, 10),
    })

    local buttons = config.Buttons or {{Title = "OK", Callback = function() end}}

    for _, btnConfig in ipairs(buttons) do
        local btn = Make("TextButton", buttonsRow, {
            Size = UDim2.new(0, 80, 0, 30),
            BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"] or Theme["Color Hub 1"],
            Text = btnConfig.Title or "Button",
            Font = Enum.Font.GothamMedium,
            TextColor3 = btnConfig.Primary and Color3.fromRGB(255, 255, 255) or Theme["Color Text"],
            TextSize = 11,
            AutoButtonColor = false,
        })
        Make("UICorner", btn, {CornerRadius = UDim.new(0, 6)})
        Make("UIStroke", btn, {
            Color = Theme["Color Stroke"],
            Thickness = 1,
        })

        btn.MouseEnter:Connect(function()
            CreateTween(btn, TweenInfo.new(0.15), {BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"]:Lerp(Color3.fromRGB(255,255,255), 0.2) or Theme["Color Hub 1"]:Lerp(Color3.fromRGB(255,255,255), 0.1)})
        end)

        btn.MouseLeave:Connect(function()
            CreateTween(btn, TweenInfo.new(0.15), {BackgroundColor3 = btnConfig.Primary and Theme["Color Theme"] or Theme["Color Hub 1"]})
        end)

        btn.MouseButton1Click:Connect(function()
            CreateTween(dialogFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1})
            CreateTween(dialogBox, TweenInfo.new(0.2), {Size = UDim2.new(0, 300, 0, 0)})
            task.wait(0.2)
            ScreenGui:Destroy()
            if btnConfig.Callback then
                pcall(btnConfig.Callback)
            end
        end)
    end

    dialogBox.Size = UDim2.new(0, 300, 0, 0)
    CreateTween(dialogBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, dialogBox.AbsoluteSize.Y),
    })
end

-- // Theme management
function GenesisX:SetTheme(themeName)
    if Themes[themeName] then
        Theme = Themes[themeName]
        GenesisX.Theme = Theme
    end
end

function GenesisX:GetThemes()
    local names = {}
    for name, _ in pairs(Themes) do
        table.insert(names, name)
    end
    return names
end

-- // Return library
return GenesisX
