local GenesisX = {}
GenesisX.__index = GenesisX

-- ─── SERVIÇOS ─────────────────────────────────────────────────────────────────
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ─── ÍCONES LUCIDE / SPECTRUMX ──────────────────────────────────────────────
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

-- ─── FONT SYSTEM ──────────────────────────────────────────────────────────────
GenesisX.Font = "Gotham"

local FontMap = {
    Legacy = Enum.Font.Legacy, Arial = Enum.Font.Arial, ArialBold = Enum.Font.ArialBold,
    SourceSans = Enum.Font.SourceSans, SourceSansBold = Enum.Font.SourceSansBold,
    SourceSansSemibold = Enum.Font.SourceSansSemibold, SourceSansLight = Enum.Font.SourceSansLight,
    Bodoni = Enum.Font.Bodoni, Garamond = Enum.Font.Garamond, Cartoon = Enum.Font.Cartoon,
    Code = Enum.Font.Code, Fantasy = Enum.Font.Fantasy, Antique = Enum.Font.Antique,
    Arcade = Enum.Font.Arcade, SciFi = Enum.Font.SciFi,
    Gotham = Enum.Font.Gotham, GothamMedium = Enum.Font.GothamMedium, GothamBold = Enum.Font.GothamBold,
    GothamBlack = Enum.Font.GothamBlack, GothamSemibold = Enum.Font.GothamSemibold,
    BuilderSans = Enum.Font.BuilderSans, BuilderSansBold = Enum.Font.BuilderSansBold,
    BuilderSansMedium = Enum.Font.BuilderSansMedium, BuilderSansSemibold = Enum.Font.BuilderSansSemibold,
    BuilderSansLight = Enum.Font.BuilderSansLight, BuilderSansExtraBold = Enum.Font.BuilderSansExtraBold,
    Montserrat = Enum.Font.Montserrat, MontserratBold = Enum.Font.MontserratBold,
    MontserratLight = Enum.Font.MontserratLight, MontserratMedium = Enum.Font.MontserratMedium,
    MontserratSemibold = Enum.Font.MontserratSemibold,
    Inter = Enum.Font.Inter, InterBold = Enum.Font.InterBold, InterLight = Enum.Font.InterLight,
    InterMedium = Enum.Font.InterMedium, InterSemibold = Enum.Font.InterSemibold,
    Ubuntu = Enum.Font.Ubuntu, UbuntuLight = Enum.Font.UbuntuLight, UbuntuMedium = Enum.Font.UbuntuMedium,
    UbuntuBold = Enum.Font.UbuntuBold,
    Roboto = Enum.Font.Roboto, RobotoBold = Enum.Font.RobotoBold, RobotoLight = Enum.Font.RobotoLight,
    RobotoMedium = Enum.Font.RobotoMedium, RobotoMono = Enum.Font.RobotoMono,
    RobotoMonoBold = Enum.Font.RobotoMonoBold, RobotoMonoLight = Enum.Font.RobotoMonoLight,
    RobotoMonoMedium = Enum.Font.RobotoMonoMedium,
    Merriweather = Enum.Font.Merriweather, MerriweatherBold = Enum.Font.MerriweatherBold,
    MerriweatherLight = Enum.Font.MerriweatherLight, MerriweatherItalic = Enum.Font.MerriweatherItalic,
    MerriweatherBoldItalic = Enum.Font.MerriweatherBoldItalic, MerriweatherLightItalic = Enum.Font.MerriweatherLightItalic,
    Fondamento = Enum.Font.Fondamento, FondamentoItalic = Enum.Font.FondamentoItalic,
    FondamentoBold = Enum.Font.FondamentoBold, FondamentoBoldItalic = Enum.Font.FondamentoBoldItalic,
    FredokaOne = Enum.Font.FredokaOne, Balthazar = Enum.Font.Balthazar,
    Cinzel = Enum.Font.Cinzel, CinzelBold = Enum.Font.CinzelBold,
    CinzelDecorative = Enum.Font.CinzelDecorative, CinzelDecorativeBold = Enum.Font.CinzelDecorativeBold,
    Sarpanch = Enum.Font.Sarpanch, SarpanchBold = Enum.Font.SarpanchBold,
    SarpanchMedium = Enum.Font.SarpanchMedium, SarpanchSemibold = Enum.Font.SarpanchSemibold,
    SarpanchBlack = Enum.Font.SarpanchBlack,
    Saira = Enum.Font.Saira, SairaBold = Enum.Font.SairaBold, SairaLight = Enum.Font.SairaLight,
    SairaMedium = Enum.Font.SairaMedium, SairaSemibold = Enum.Font.SairaSemibold,
    SairaExtraLight = Enum.Font.SairaExtraLight, SairaExtraBold = Enum.Font.SairaExtraBold,
    SairaBlack = Enum.Font.SairaBlack,
    Nunito = Enum.Font.Nunito, NunitoBold = Enum.Font.NunitoBold, NunitoLight = Enum.Font.NunitoLight,
    NunitoMedium = Enum.Font.NunitoMedium, NunitoSemibold = Enum.Font.NunitoSemibold,
    NunitoExtraBold = Enum.Font.NunitoExtraBold, NunitoExtraLight = Enum.Font.NunitoExtraLight,
    NunitoBlack = Enum.Font.NunitoBlack,
    Oswald = Enum.Font.Oswald, OswaldBold = Enum.Font.OswaldBold, OswaldLight = Enum.Font.OswaldLight,
    OswaldMedium = Enum.Font.OswaldMedium, OswaldSemibold = Enum.Font.OswaldSemibold,
    OswaldExtraLight = Enum.Font.OswaldExtraLight, OswaldExtraBold = Enum.Font.OswaldExtraBold,
    Poppins = Enum.Font.Poppins, PoppinsBold = Enum.Font.PoppinsBold, PoppinsLight = Enum.Font.PoppinsLight,
    PoppinsMedium = Enum.Font.PoppinsMedium, PoppinsSemibold = Enum.Font.PoppinsSemibold,
    PoppinsExtraBold = Enum.Font.PoppinsExtraBold, PoppinsExtraLight = Enum.Font.PoppinsExtraLight,
    PoppinsThin = Enum.Font.PoppinsThin, PoppinsBlack = Enum.Font.PoppinsBlack,
    RussoOne = Enum.Font.RussoOne,
    TitilliumWeb = Enum.Font.TitilliumWeb, TitilliumWebBold = Enum.Font.TitilliumWebBold,
    TitilliumWebLight = Enum.Font.TitilliumWebLight, TitilliumWebSemibold = Enum.Font.TitilliumWebSemibold,
    TitilliumWebExtraLight = Enum.Font.TitilliumWebExtraLight, TitilliumWebBlack = Enum.Font.TitilliumWebBlack,
    Jura = Enum.Font.Jura, JuraBold = Enum.Font.JuraBold, JuraLight = Enum.Font.JuraLight,
    JuraMedium = Enum.Font.JuraMedium, JuraSemibold = Enum.Font.JuraSemibold,
    JuraExtraLight = Enum.Font.JuraExtraLight, JuraExtraBold = Enum.Font.JuraExtraBold,
    JuraBlack = Enum.Font.JuraBlack,
    AmaticSC = Enum.Font.AmaticSC, AmaticSCBold = Enum.Font.AmaticSCBold,
    Michroma = Enum.Font.Michroma, PressStart2P = Enum.Font.PressStart2P,
    SpecialElite = Enum.Font.SpecialElite,
    Inconsolata = Enum.Font.Inconsolata, InconsolataBold = Enum.Font.InconsolataBold,
    InconsolataExtraBold = Enum.Font.InconsolataExtraBold, InconsolataMedium = Enum.Font.InconsolataMedium,
    InconsolataSemiBold = Enum.Font.InconsolataSemiBold, InconsolataLight = Enum.Font.InconsolataLight,
    InconsolataExtraLight = Enum.Font.InconsolataExtraLight, InconsolataBlack = Enum.Font.InconsolataBlack,
    GrenzeGotisch = Enum.Font.GrenzeGotisch, GrenzeGotischBold = Enum.Font.GrenzeGotischBold,
    GrenzeGotischLight = Enum.Font.GrenzeGotischLight, GrenzeGotischMedium = Enum.Font.GrenzeGotischMedium,
    GrenzeGotischSemibold = Enum.Font.GrenzeGotischSemibold, GrenzeGotischExtraLight = Enum.Font.GrenzeGotischExtraLight,
    GrenzeGotischExtraBold = Enum.Font.GrenzeGotischExtraBold, GrenzeGotischBlack = Enum.Font.GrenzeGotischBlack,
    GrenzeGotischThin = Enum.Font.GrenzeGotischThin,
    Kalam = Enum.Font.Kalam, KalamBold = Enum.Font.KalamBold, KalamLight = Enum.Font.KalamLight,
    KalamMedium = Enum.Font.KalamMedium, KalamSemiBold = Enum.Font.KalamSemiBold,
    KalamExtraLight = Enum.Font.KalamExtraLight, KalamExtraBold = Enum.Font.KalamExtraBold,
    KalamBlack = Enum.Font.KalamBlack, KalamThin = Enum.Font.KalamThin,
    NotoSans = Enum.Font.NotoSans, NotoSansBold = Enum.Font.NotoSansBold,
    NotoSansLight = Enum.Font.NotoSansLight, NotoSansMedium = Enum.Font.NotoSansMedium,
    NotoSansSemibold = Enum.Font.NotoSansSemibold, NotoSansExtraLight = Enum.Font.NotoSansExtraLight,
    NotoSansExtraBold = Enum.Font.NotoSansExtraBold, NotoSansBlack = Enum.Font.NotoSansBlack,
    NotoSansThin = Enum.Font.NotoSansThin,
}

function GenesisX:GetFont(name)
    name = name or self.Font
    if typeof(name) == "EnumItem" then return name end
    return FontMap[name] or FontMap[self.Font] or Enum.Font.Gotham
end

function GenesisX:GetFontBold()
    local base = self.Font or "Gotham"
    local boldMap = {
        Gotham = "GothamBold", SourceSans = "SourceSansBold", BuilderSans = "BuilderSansBold",
        Montserrat = "MontserratBold", Inter = "InterBold", Ubuntu = "UbuntuBold",
        Roboto = "RobotoBold", RobotoMono = "RobotoMonoBold", Merriweather = "MerriweatherBold",
        Cinzel = "CinzelBold", Sarpanch = "SarpanchBold", Saira = "SairaBold",
        Nunito = "NunitoBold", Oswald = "OswaldBold", Poppins = "PoppinsBold",
        TitilliumWeb = "TitilliumWebBold", Jura = "JuraBold",
        Inconsolata = "InconsolataBold", GrenzeGotisch = "GrenzeGotischBold",
        Kalam = "KalamBold", NotoSans = "NotoSansBold",
    }
    return FontMap[boldMap[base]] or FontMap[base] or Enum.Font.GothamBold
end

function GenesisX:GetFontSemibold()
    local base = self.Font or "Gotham"
    local semiMap = {
        Gotham = "GothamSemibold", SourceSans = "SourceSansSemibold", BuilderSans = "BuilderSansSemibold",
        Montserrat = "MontserratSemibold", Inter = "InterSemibold", Ubuntu = "UbuntuMedium",
        Roboto = "RobotoMedium", RobotoMono = "RobotoMonoMedium", Merriweather = "Merriweather",
        Cinzel = "Cinzel", Sarpanch = "SarpanchSemibold", Saira = "SairaSemibold",
        Nunito = "NunitoSemibold", Oswald = "OswaldSemibold", Poppins = "PoppinsSemibold",
        TitilliumWeb = "TitilliumWebSemibold", Jura = "JuraSemibold",
        Inconsolata = "InconsolataSemiBold", GrenzeGotisch = "GrenzeGotischSemibold",
        Kalam = "KalamSemiBold", NotoSans = "NotoSansSemibold",
    }
    return FontMap[semiMap[base]] or FontMap[base] or Enum.Font.GothamSemibold
end

function GenesisX:GetFontBlack()
    local base = self.Font or "Gotham"
    local blackMap = {
        Gotham = "GothamBlack", SourceSans = "SourceSansBold", BuilderSans = "BuilderSansExtraBold",
        Montserrat = "MontserratBold", Inter = "InterBold", Ubuntu = "UbuntuBold",
        Roboto = "RobotoBold", RobotoMono = "RobotoMonoBold", Merriweather = "MerriweatherBold",
        Cinzel = "CinzelBold", Sarpanch = "SarpanchBlack", Saira = "SairaBlack",
        Nunito = "NunitoBlack", Oswald = "OswaldExtraBold", Poppins = "PoppinsBlack",
        TitilliumWeb = "TitilliumWebBlack", Jura = "JuraBlack",
        Inconsolata = "InconsolataBlack", GrenzeGotisch = "GrenzeGotischBlack",
        Kalam = "KalamBlack", NotoSans = "NotoSansBlack",
    }
    return FontMap[blackMap[base]] or FontMap[base] or Enum.Font.GothamBlack
end



-- ─── THEME SYSTEM ─────────────────────────────────────────────────────────────
GenesisX.Themes = {
    Dark = {
        Background = Color3.fromRGB(8, 8, 8),
        Header = Color3.fromRGB(12, 12, 12),
        Sidebar = Color3.fromRGB(10, 10, 10),
        Card = Color3.fromRGB(16, 16, 16),
        CardHover = Color3.fromRGB(24, 24, 24),
        Input = Color3.fromRGB(22, 22, 22),
        InputHover = Color3.fromRGB(30, 30, 30),
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

GenesisX.Theme = GenesisX.Themes.Dark

-- ─── CONFIGURAÇÕES ────────────────────────────────────────────────────────────
GenesisX.Config = {
    AnimationSpeed = 0.2,
    CornerRadius = 8,
    ShadowEnabled = true,
    ShadowIntensity = 0.7,
}

-- ─── ESCALA RESPONSIVA ────────────────────────────────────────────────────────
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

-- ─── UTILITÁRIOS BÁSICOS ──────────────────────────────────────────────────────
function GenesisX:Tween(obj, props, time, style, direction)
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

function GenesisX:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, self.Config.CornerRadius)
    corner.Parent = parent
    return corner
end

function GenesisX:CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or self.Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function GenesisX:CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1 or Color3.new(1,1,1), color2 or Color3.new(0,0,0))
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

-- ─── SISTEMA DE SOMBRAS ───────────────────────────────────────────────────────
function GenesisX:CreateShadow(parent, size, intensity)
    if not self.Config.ShadowEnabled then return nil end
    size = size or 20
    intensity = intensity or self.Config.ShadowIntensity
    local shadowFolder = Instance.new("Folder")
    shadowFolder.Name = "Shadow"
    shadowFolder.Parent = parent
    local layers = 4
    for i = 1, layers do
        local layer = Instance.new("Frame")
        layer.Name = "Layer" .. i
        layer.AnchorPoint = Vector2.new(0.5, 0.5)
        layer.BackgroundColor3 = Color3.new(0, 0, 0)
        layer.BackgroundTransparency = intensity + ((1 - intensity) * (i / layers) * 0.5)
        layer.BorderSizePixel = 0
        layer.Position = UDim2.new(0.5, 0, 0.5, 0)
        layer.Size = UDim2.new(1, size + (i * 3), 1, size + (i * 3))
        layer.ZIndex = math.max(0, parent.ZIndex - 1)
        layer.Parent = shadowFolder
        self:CreateCorner(layer, UDim.new(0, (self.Config.CornerRadius or 8) + i))
    end
    return shadowFolder
end

function GenesisX:CreateSimpleShadow(parent, size, transparency)
    if not self.Config.ShadowEnabled then return nil end
    local shadow = Instance.new("Frame")
    shadow.Name = "SimpleShadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = transparency or 0.75
    shadow.BorderSizePixel = 0
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, size or 16, 1, size or 16)
    shadow.ZIndex = math.max(0, parent.ZIndex - 1)
    shadow.Parent = parent
    self:CreateCorner(shadow)
    return shadow
end

-- ─── DRAGGABLE ────────────────────────────────────────────────────────────────
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

-- ─── RIPPLE EFFECT ────────────────────────────────────────────────────────────
function GenesisX:CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = Color3.new(1, 1, 1)
    ripple.BackgroundTransparency = 0.8
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

-- ─── HELPERS DE ÍCONE ─────────────────────────────────────────────────────────
function GenesisX:IsAssetId(value)
    if type(value) ~= "string" and type(value) ~= "number" then return false end
    local s = tostring(value)
    if s:match("^rbxassetid://") ~= nil or s:match("^%d+$") ~= nil then return true end
    -- Também aceita nomes de ícones registrados
    if LucideAssets and LucideAssets[s] then return true end
    return false
end

function GenesisX:FormatAssetId(value)
    if type(value) == "number" then
        return "rbxassetid://" .. value
    elseif type(value) == "string" then
        -- Prioridade: nome de ícone Lucide registrado
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

-- ─── REGISTRO DE DROPDOWNS ────────────────────────────────────────────────────
function GenesisX:_RegisterDropdown(list, button, closeFunction)
    if not self._dropdowns then self._dropdowns = {} end
    table.insert(self._dropdowns, { List = list, Button = button, Close = closeFunction })
    if not self.Dropdowns then self.Dropdowns = {} end
    table.insert(self.Dropdowns, list)
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

-- ─── CREATE WINDOW ────────────────────────────────────────────────────────────
function GenesisX:CreateWindow(config)
    config = config or {}
    local window = setmetatable({}, self)
    self:UpdateScale()
    -- Theme & Font setup with safety
    if not self.Themes then
        self.Themes = { Dark = { Background = Color3.fromRGB(8,8,8), Header = Color3.fromRGB(12,12,12), Sidebar = Color3.fromRGB(10,10,10), Card = Color3.fromRGB(16,16,16), CardHover = Color3.fromRGB(24,24,24), Input = Color3.fromRGB(22,22,22), InputHover = Color3.fromRGB(30,30,30), Accent = Color3.fromRGB(150,80,230), AccentHover = Color3.fromRGB(180,110,255), AccentSecondary = Color3.fromRGB(210,160,255), AccentDark = Color3.fromRGB(90,40,160), Text = Color3.fromRGB(255,255,255), TextSecondary = Color3.fromRGB(190,190,190), TextMuted = Color3.fromRGB(120,120,120), Success = Color3.fromRGB(220,190,255), Warning = Color3.fromRGB(190,130,255), Info = Color3.fromRGB(140,90,220), Error = Color3.fromRGB(80,40,140), Border = Color3.fromRGB(40,35,50), BorderBright = Color3.fromRGB(75,65,90), ToggleOff = Color3.fromRGB(35,30,45), ToggleOn = Color3.fromRGB(150,80,230) } }
    end
    if not self.Theme then
        self.Theme = self.Themes.Dark
    end
    local themeName = config.Theme or "Dark"
    if themeName == "Light" then
        self.Theme = self.Themes.Light
    else
        self.Theme = self.Themes.Dark
    end
    self.Font = config.Font or self.Font or "Gotham"


    if PlayerGui:FindFirstChild("GenesisX") then
        PlayerGui.GenesisX:Destroy()
    end

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "GenesisX"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.DisplayOrder = 999999

    -- Parent no CoreGui se possível (fica por cima da UI do Roblox)
    local parentSuccess = pcall(function()
        self.ScreenGui.Parent = CoreGui
    end)

    -- Se falhar (executor não permite), usa PlayerGui
    if not parentSuccess then
        self.ScreenGui.Parent = PlayerGui
    end

    self._notifications = {}
    self.Dropdowns = {}
    self._dropdowns = {}
    self.Tabs = {}
    self.CurrentTab = nil

    local windowWidth = ScaleData.IsMobile and self:S(440) or self:S(700)
    local windowHeight = ScaleData.IsMobile and self:S(580) or self:S(460)

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Position = config.Position or UDim2.new(0.5, -windowWidth/2, 0.5, -windowHeight/2)
    self.MainFrame.Size = config.Size or UDim2.new(0, windowWidth, 0, windowHeight)
    self.MainFrame.Active = true
    self.MainFrame.Visible = true
    self.MainFrame.ZIndex = 10
    self.MainFrame.Parent = self.ScreenGui
    self:CreateCorner(self.MainFrame, UDim.new(0, 12))
    self:CreateStroke(self.MainFrame, self.Theme.Accent, 1.5, 0)

    -- ─── HEADER ─────────────────────────────────────────────────────────────────
    local headerHeight = self:S(56)

    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.BackgroundColor3 = self.Theme.Header
    self.Header.BorderSizePixel = 0
    self.Header.Size = UDim2.new(1, 0, 0, headerHeight)
    self.Header.ZIndex = 12
    self.Header.Parent = self.MainFrame
    self:CreateCorner(self.Header, UDim.new(0, 10))

    local iconX = self:S(16)
    -- FIX: Detectar asset ID corretamente para o ícone do header (agora inclui nomes Lucide)
    local headerIconAsset = config.IconAssetId and self:FormatAssetId(config.IconAssetId)
                         or (config.Icon and self:FormatAssetId(config.Icon))

    if headerIconAsset then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "HeaderIcon"
        iconImg.BackgroundTransparency = 1
        iconImg.Position = UDim2.new(0, iconX, 0.5, -self:S(16))
        iconImg.Size = UDim2.new(0, self:S(32), 0, self:S(32))
        iconImg.Image = headerIconAsset
        iconImg.ScaleType = Enum.ScaleType.Stretch
        iconImg.ZIndex = 14
        iconImg.Parent = self.Header
    else
        local iconBg = Instance.new("Frame")
        iconBg.Name = "IconBg"
        iconBg.BackgroundColor3 = self.Theme.Accent
        iconBg.Position = UDim2.new(0, iconX, 0.5, -self:S(15))
        iconBg.Size = UDim2.new(0, self:S(30), 0, self:S(30))
        iconBg.ZIndex = 14
        iconBg.Parent = self.Header
        self:CreateCorner(iconBg, UDim.new(0, 6))

        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "IconLabel"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBlack()
        iconLabel.Text = config.Icon or "S"
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.TextSize = self:S(16)
        iconLabel.ZIndex = 15
        iconLabel.Parent = iconBg
    end

    local titleX = iconX + self:S(44)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, titleX, 0, 0)
    titleLabel.Size = UDim2.new(0, self:S(300), 1, 0)
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = config.Title or "GenesisX"
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = self:S(18)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 14
    titleLabel.Parent = self.Header
    self:CreateGradient(titleLabel, self.Theme.Text, self.Theme.AccentSecondary, 0)

    if config.Subtitle then
        titleLabel.Size = UDim2.new(0, self:S(300), 0, self:S(28))
        titleLabel.Position = UDim2.new(0, titleX, 0, self:S(6))
        local subtitleLabel = Instance.new("TextLabel")
        subtitleLabel.Name = "Subtitle"
        subtitleLabel.BackgroundTransparency = 1
        subtitleLabel.Position = UDim2.new(0, titleX, 0, self:S(30))
        subtitleLabel.Size = UDim2.new(0, self:S(300), 0, self:S(16))
        subtitleLabel.Font = self:GetFont()
        subtitleLabel.Text = config.Subtitle
        subtitleLabel.TextColor3 = self.Theme.TextMuted
        subtitleLabel.TextSize = self:S(10)
        subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        subtitleLabel.ZIndex = 14
        subtitleLabel.Parent = self.Header
    end

    local minBtn = Instance.new("TextButton")
    minBtn.Name = "MinimizeBtn"
    minBtn.BackgroundColor3 = self.Theme.Input
    minBtn.Position = UDim2.new(1, -self:S(42), 0.5, -self:S(12))
    minBtn.Size = UDim2.new(0, self:S(28), 0, self:S(24))
    minBtn.Font = self:GetFontBold()
    minBtn.Text = "—"
    minBtn.TextColor3 = self.Theme.TextMuted
    minBtn.TextSize = self:S(13)
    minBtn.AutoButtonColor = false
    minBtn.ZIndex = 14
    minBtn.Parent = self.Header
    self:CreateCorner(minBtn, UDim.new(0, 6))

    minBtn.MouseEnter:Connect(function()
        self:Tween(minBtn, {BackgroundColor3 = self.Theme.Accent, TextColor3 = Color3.new(1,1,1)}, 0.15)
    end)
    minBtn.MouseLeave:Connect(function()
        self:Tween(minBtn, {BackgroundColor3 = Color3.fromRGB(35,35,35), TextColor3 = self.Theme.TextMuted}, 0.15)
    end)
    minBtn.MouseButton1Click:Connect(function()
        self.MainFrame.Visible = false
    end)

    -- ─── SIDEBAR ────────────────────────────────────────────────────────────────
    local sidebarWidth = self:S(64)

    local sidebarWrap = Instance.new("Frame")
    sidebarWrap.Name = "SidebarWrap"
    sidebarWrap.BackgroundColor3 = self.Theme.Sidebar
    sidebarWrap.BorderSizePixel = 0
    sidebarWrap.Position = UDim2.new(0, 0, 0, headerHeight + 2)
    sidebarWrap.Size = UDim2.new(0, sidebarWidth, 1, -(headerHeight + 2))
    sidebarWrap.ClipsDescendants = true
    sidebarWrap.ZIndex = 11
    sidebarWrap.Parent = self.MainFrame
    self:CreateCorner(sidebarWrap, UDim.new(0, 10))

    local sidebarLine = Instance.new("Frame")
    sidebarLine.Name = "SidebarLine"
    sidebarLine.BackgroundColor3 = self.Theme.Border
    sidebarLine.BorderSizePixel = 0
    sidebarLine.Position = UDim2.new(1, -1, 0, 0)
    sidebarLine.Size = UDim2.new(0, 1, 1, 0)
    sidebarLine.ZIndex = 12
    sidebarLine.Parent = sidebarWrap

    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.BackgroundTransparency = 1
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.Position = UDim2.new(0, 0, 0, 0)
    self.Sidebar.Size = UDim2.new(1, 0, 1, 0)
    self.Sidebar.ScrollBarThickness = 2
    self.Sidebar.ScrollBarImageColor3 = self.Theme.Accent
    self.Sidebar.ScrollBarImageTransparency = 0.6
    self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Sidebar.ZIndex = 11
    self.Sidebar.Parent = sidebarWrap

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, self:S(8))
    sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sidebarLayout.Parent = self.Sidebar

    local sidebarPadding = Instance.new("UIPadding")
    sidebarPadding.PaddingTop = UDim.new(0, self:S(12))
    sidebarPadding.PaddingBottom = UDim.new(0, self:S(12))
    sidebarPadding.Parent = self.Sidebar

    sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarLayout.AbsoluteContentSize.Y + self:S(24))
    end)

    -- ─── CONTENT AREA ───────────────────────────────────────────────────────────
    local contentX = sidebarWidth + self:S(10)

    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.Position = UDim2.new(0, contentX, 0, headerHeight + self:S(10))
    self.ContentArea.Size = UDim2.new(1, -(contentX + self:S(10)), 1, -(headerHeight + self:S(16)))
    self.ContentArea.ZIndex = 11
    self.ContentArea.Parent = self.MainFrame

    self:_CreateFloatingButton(config)

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            self:_CloseDropdownsOnClick(input.Position)
        end
    end)

    local success, camera = pcall(function() return workspace.CurrentCamera end)
    if success and camera then
        camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            self:UpdateScale()
        end)
    end

    self:MakeDraggable(self.MainFrame, self.Header)
    return window
end

-- ─── FLOATING BUTTON ──────────────────────────────────────────────────────────
function GenesisX:_CreateFloatingButton(config)
    config = config or {}
    local btnSize = self:S(52)

    self.FloatBtn = Instance.new("ImageButton")
    self.FloatBtn.Name = "FloatBtn"
    self.FloatBtn.BackgroundColor3 = self.Theme.Accent
    self.FloatBtn.Position = UDim2.new(0, 20, 0.5, 0)
    self.FloatBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    self.FloatBtn.Image = ""
    self.FloatBtn.AutoButtonColor = false
    self.FloatBtn.ZIndex = 100
    self.FloatBtn.Parent = self.ScreenGui
    self:CreateCorner(self.FloatBtn, UDim.new(0, 14))

    -- FIX: Detectar asset ID para ícone do botão flutuante (agora suporta nomes Lucide)
    local floatIconRaw = config.FloatIconAssetId or config.FloatIcon or config.IconAssetId or config.Icon or "S"
    local floatIconAsset = self:FormatAssetId(floatIconRaw)

    if floatIconAsset then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "Icon"
        iconImg.BackgroundTransparency = 1
        iconImg.Size = UDim2.new(0.7, 0, 0.7, 0)
        iconImg.Position = UDim2.new(0.15, 0, 0.15, 0)
        iconImg.Image = floatIconAsset
        iconImg.ScaleType = Enum.ScaleType.Stretch
        iconImg.ZIndex = 102
        iconImg.Parent = self.FloatBtn
    else
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "Icon"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBlack()
        iconLabel.Text = tostring(floatIconRaw)
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.TextSize = self:S(22)
        iconLabel.ZIndex = 102
        iconLabel.Parent = self.FloatBtn
    end

    self.FloatBtn.MouseEnter:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.AccentHover}, 0.15)
    end)
    self.FloatBtn.MouseLeave:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.Accent}, 0.15)
    end)

    local dragging = false
    local dragInput = nil
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
    self.FloatBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            self.FloatBtn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    self.FloatBtn.MouseButton1Click:Connect(function()
        if not dragging then
            local visible = not self.MainFrame.Visible
            self.MainFrame.Visible = visible
            if visible then
                self.MainFrame.BackgroundTransparency = 1
                self:Tween(self.MainFrame, {BackgroundTransparency = 0}, 0.25)
            end
        end
    end)
end

-- ─── CREATE TAB ───────────────────────────────────────────────────────────────
function GenesisX:CreateTab(config)
    config = config or {}
    local tabId = config.Name or "Tab"
    local btnSize = self:S(46)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabId .. "Tab"
    tabBtn.BackgroundColor3 = self.Theme.Card
    tabBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.ZIndex = 13
    tabBtn.Parent = self.Sidebar
    self:CreateCorner(tabBtn, UDim.new(0, 10))

    -- FIX: Detectar corretamente se Icon é asset ID ou nome Lucide
    local iconRaw = config.Icon or config.IconAssetId
    local iconAssetId = iconRaw and self:FormatAssetId(iconRaw)

    if iconAssetId then
        -- É um asset ID ou nome Lucide válido — renderizar como ImageLabel
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "Icon"
        iconImg.BackgroundTransparency = 1
        iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
        iconImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        iconImg.Size = UDim2.new(0, self:S(24), 0, self:S(24))
        iconImg.Image = iconAssetId
        iconImg.ImageColor3 = self.Theme.TextMuted
        iconImg.ScaleType = Enum.ScaleType.Stretch
        iconImg.ZIndex = 14
        iconImg.Parent = tabBtn
    else
        -- É texto/emoji — renderizar como TextLabel
        local fallback = iconRaw or tabId:sub(1, 1)
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "Icon"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBold()
        iconLabel.Text = tostring(fallback)
        iconLabel.TextColor3 = self.Theme.TextMuted
        iconLabel.TextSize = self:S(16)
        iconLabel.ZIndex = 14
        iconLabel.Parent = tabBtn
    end

    -- Tooltip
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.BackgroundColor3 = self.Theme.Card
    tooltip.BorderSizePixel = 0
    tooltip.Position = UDim2.new(1, self:S(10), 0.5, -self:S(11))
    tooltip.Size = UDim2.new(0, 0, 0, self:S(22))
    tooltip.AutomaticSize = Enum.AutomaticSize.X
    tooltip.Font = self:GetFontSemibold()
    tooltip.Text = "  " .. tabId .. "  "
    tooltip.TextColor3 = self.Theme.Text
    tooltip.TextSize = self:S(11)
    tooltip.Visible = false
    tooltip.ZIndex = 1000
    tooltip.Parent = tabBtn
    self:CreateCorner(tooltip, UDim.new(0, 5))
    self:CreateStroke(tooltip, self.Theme.Border, 1, 0.3)

    tabBtn.MouseEnter:Connect(function()
        if self.CurrentTab ~= tabId then
            self:Tween(tabBtn, {BackgroundColor3 = self.Theme.CardHover}, 0.15)
        end
        tooltip.Visible = true
    end)
    tabBtn.MouseLeave:Connect(function()
        if self.CurrentTab ~= tabId then
            self:Tween(tabBtn, {BackgroundColor3 = self.Theme.Card}, 0.15)
        end
        tooltip.Visible = false
    end)

    local page = Instance.new("Frame")
    page.Name = tabId .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.ZIndex = 11
    page.Parent = self.ContentArea

    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.BackgroundColor3 = self.Theme.Border
    divider.BorderSizePixel = 0
    divider.Position = UDim2.new(0.5, -1, 0, 0)
    divider.Size = UDim2.new(0, 1, 1, 0)
    divider.ZIndex = 11
    divider.Parent = page

    local function createSide(position, size, name)
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Name = name
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.Position = position
        scrollFrame.Size = size
        scrollFrame.ScrollBarThickness = 3
        scrollFrame.ScrollBarImageColor3 = self.Theme.Accent
        scrollFrame.ScrollBarImageTransparency = 0.5
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrollFrame.ZIndex = 11
        scrollFrame.Parent = page

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, self:S(8))
        layout.Parent = scrollFrame

        local padding = Instance.new("UIPadding")
        padding.PaddingBottom = UDim.new(0, self:S(10))
        padding.Parent = scrollFrame

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + self:S(20))
        end)

        return scrollFrame
    end

    local left = createSide(UDim2.new(0, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Left")
    local right = createSide(UDim2.new(0.51, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Right")

    local tabData = { Button = tabBtn, Container = page, Left = left, Right = right, Id = tabId }
    self.Tabs[tabId] = tabData

    tabBtn.MouseButton1Click:Connect(function()
        self:SelectTab(tabId)
    end)

    if not self.CurrentTab then
        self:SelectTab(tabId)
    end

    return tabData
end

-- ─── SELECT TAB ───────────────────────────────────────────────────────────────
function GenesisX:SelectTab(tabId)
    for id, data in pairs(self.Tabs) do
        local icon = data.Button:FindFirstChild("Icon")
        if id == tabId then
            data.Container.Visible = true
            self:Tween(data.Button, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            if icon then
                if icon:IsA("TextLabel") then
                    self:Tween(icon, {TextColor3 = Color3.new(1, 1, 1)}, 0.2)
                elseif icon:IsA("ImageLabel") then
                    self:Tween(icon, {ImageColor3 = Color3.new(1, 1, 1)}, 0.2)
                end
            end
        else
            data.Container.Visible = false
            self:Tween(data.Button, {BackgroundColor3 = self.Theme.Card}, 0.2)
            if icon then
                if icon:IsA("TextLabel") then
                    self:Tween(icon, {TextColor3 = self.Theme.TextMuted}, 0.2)
                elseif icon:IsA("ImageLabel") then
                    self:Tween(icon, {ImageColor3 = self.Theme.TextMuted}, 0.2)
                end
            end
        end
    end
    self.CurrentTab = tabId
end

-- ─── CREATE SECTION ───────────────────────────────────────────────────────────
function GenesisX:CreateSection(parent, text, color, icon)
    -- icon: nome Lucide opcional, ex: "lucide-sword"
    color = color or self.Theme.Accent
    local iconSize = self:S(16)
    local height   = self:S(28)

    local wrap = Instance.new("Frame")
    wrap.Name = "Section_" .. text
    wrap.BackgroundTransparency = 1
    wrap.Size = UDim2.new(1, 0, 0, height)
    wrap.ZIndex = 12
    wrap.Parent = parent

    -- Linha de fundo
    local line = Instance.new("Frame")
    line.Name = "Line"
    line.BackgroundColor3 = color
    line.BackgroundTransparency = 0.7
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.ZIndex = 11
    line.Parent = wrap

    -- Container do label (ícone + texto, fundo igual ao pai p/ "cortar" a linha)
    local labelBg = Instance.new("Frame")
    labelBg.Name = "LabelBg"
    labelBg.BackgroundColor3 = self.Theme.Background
    labelBg.BorderSizePixel = 0
    labelBg.AutomaticSize = Enum.AutomaticSize.X
    labelBg.Position = UDim2.new(0, self:S(6), 0, 0)
    labelBg.Size = UDim2.new(0, 0, 1, 0)
    labelBg.ZIndex = 13
    labelBg.Parent = wrap

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, self:S(5))
    layout.Parent = labelBg

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft  = UDim.new(0, self:S(4))
    pad.PaddingRight = UDim.new(0, self:S(6))
    pad.Parent = labelBg

    -- Ícone (se fornecido)
    if icon then
        local assetId = self:FormatAssetId(icon)
        if assetId then
            local img = Instance.new("ImageLabel")
            img.Name = "Icon"
            img.BackgroundTransparency = 1
            img.Size = UDim2.fromOffset(iconSize, iconSize)
            img.Image = assetId
            img.ImageColor3 = color
            img.ZIndex = 14
            img.Parent = labelBg
        end
    end

    -- Texto
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Font = self:GetFontBold()
    label.Text = text
    label.TextColor3 = color
    label.TextSize = self:S(11)
    label.ZIndex = 14
    label.Parent = labelBg

    return wrap
end

-- ─── CREATE TOGGLE ────────────────────────────────────────────────────────────
function GenesisX:CreateToggle(parent, config)
    config = config or {}
    local text = config.Text or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local height = self:S(46)

    local frame = Instance.new("Frame")
    frame.Name = "Toggle_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.5)

    local hoverFill = Instance.new("Frame")
    hoverFill.Name = "HoverFill"
    hoverFill.BackgroundColor3 = Color3.new(1, 1, 1)
    hoverFill.BackgroundTransparency = 1
    hoverFill.BorderSizePixel = 0
    hoverFill.Size = UDim2.new(1, 0, 1, 0)
    hoverFill.ZIndex = 0
    hoverFill.Parent = frame
    self:CreateCorner(hoverFill)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, 0)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(13)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 13
    label.Parent = frame

    local trackWidth, trackHeight = self:S(46), self:S(24)
    local track = Instance.new("TextButton")
    track.Name = "Track"
    track.AutoButtonColor = false
    track.BackgroundColor3 = default and self.Theme.ToggleOn or self.Theme.ToggleOff
    track.Position = UDim2.new(1, -trackWidth - self:S(14), 0.5, -trackHeight/2)
    track.Size = UDim2.new(0, trackWidth, 0, trackHeight)
    track.Text = ""
    track.ZIndex = 14
    track.Parent = frame
    self:CreateCorner(track, UDim.new(1, 0))
    self:CreateStroke(track, default and self.Theme.Accent or self.Theme.Border, 1, default and 0.2 or 0.5)

    local trackStroke = track:FindFirstChildOfClass("UIStroke")
    local knobSize = self:S(18)

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Position = default and UDim2.new(1, -knobSize - self:S(3), 0.5, -knobSize/2)
                              or UDim2.new(0, self:S(3), 0.5, -knobSize/2)
    knob.Size = UDim2.new(0, knobSize, 0, knobSize)
    knob.ZIndex = 15
    knob.Parent = track
    self:CreateCorner(knob, UDim.new(1, 0))
    self:CreateStroke(knob, Color3.fromRGB(200, 200, 200), 1, 0.3)

    local state = default

    local function update(newState, animated)
        local time = animated == false and 0 or 0.2
        state = newState
        if state then
            self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOn}, time)
            if trackStroke then self:Tween(trackStroke, {Color = self.Theme.Accent, Transparency = 0.2}, time) end
            self:Tween(knob, {Position = UDim2.new(1, -knobSize - self:S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        else
            self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOff}, time)
            if trackStroke then self:Tween(trackStroke, {Color = self.Theme.Border, Transparency = 0.5}, time) end
            self:Tween(knob, {Position = UDim2.new(0, self:S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end
    end

    track.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        update(state)
    end)
    frame.MouseEnter:Connect(function() self:Tween(hoverFill, {BackgroundTransparency = 0.97}, 0.15) end)
    frame.MouseLeave:Connect(function() self:Tween(hoverFill, {BackgroundTransparency = 1}, 0.15) end)

    return {
        Frame = frame,
        GetState = function() return state end,
        SetState = function(s) state = s; callback(state); update(state) end,
    }
end

-- ─── CREATE BUTTON ────────────────────────────────────────────────────────────
function GenesisX:CreateButton(parent, config)
    config = config or {}
    local text     = config.Text     or "Button"
    local style    = config.Style    or "default"
    local callback = config.Callback or function() end
    local height   = self:S(40)

    local frame = Instance.new("Frame")
    frame.Name = "Button_" .. text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent

    -- padding pra não cortar nas laterais
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft  = UDim.new(0, self:S(4))
    pad.PaddingRight = UDim.new(0, self:S(4))
    pad.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Name = "Button"
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Font = self:GetFontBold()
    btn.Text = text
    btn.TextSize = self:S(13)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.ZIndex = 13
    btn.Parent = frame
    self:CreateCorner(btn)

    local bgColor, bgHover, strokeColor
    if style == "accent" then
        bgColor     = Color3.fromRGB(40, 20, 65)
        bgHover     = Color3.fromRGB(55, 30, 90)
        strokeColor = self.Theme.Accent
    elseif style == "warning" then
        bgColor     = Color3.fromRGB(40, 25, 5)
        bgHover     = Color3.fromRGB(55, 35, 8)
        strokeColor = Color3.fromRGB(200, 130, 30)
    elseif style == "info" then
        bgColor     = Color3.fromRGB(10, 20, 45)
        bgHover     = Color3.fromRGB(15, 28, 60)
        strokeColor = Color3.fromRGB(80, 140, 230)
    elseif style == "danger" then
        bgColor     = Color3.fromRGB(45, 10, 10)
        bgHover     = Color3.fromRGB(60, 15, 15)
        strokeColor = Color3.fromRGB(210, 60, 60)
    elseif style == "success" then
        bgColor     = Color3.fromRGB(10, 40, 20)
        bgHover     = Color3.fromRGB(15, 55, 28)
        strokeColor = Color3.fromRGB(60, 200, 100)
    else
        bgColor     = Color3.fromRGB(22, 22, 22)
        bgHover     = Color3.fromRGB(32, 32, 32)
        strokeColor = self.Theme.BorderBright
    end

    btn.BackgroundColor3 = bgColor
    self:CreateStroke(btn, strokeColor, 1.2, 0.2)

    local rippleHolder = Instance.new("Frame")
    rippleHolder.Name = "RippleHolder"
    rippleHolder.BackgroundTransparency = 1
    rippleHolder.BorderSizePixel = 0
    rippleHolder.Size = UDim2.new(1, 0, 1, 0)
    rippleHolder.ClipsDescendants = true
    rippleHolder.ZIndex = btn.ZIndex + 1
    rippleHolder.Parent = btn
    self:CreateCorner(rippleHolder)

    btn.MouseEnter:Connect(function()
        self:Tween(btn, {BackgroundColor3 = bgHover}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        self:Tween(btn, {BackgroundColor3 = bgColor}, 0.15)
    end)
    btn.MouseButton1Click:Connect(function()
        self:CreateRipple(btn, UserInputService:GetMouseLocation())
        callback()
    end)

    return {
        Frame  = frame,
        Button = btn,
        SetText     = function(t)  btn.Text = t end,
        SetCallback = function(cb) callback  = cb end,
    }
end

-- ─── CREATE INPUT ─────────────────────────────────────────────────────────────
function GenesisX:CreateInput(parent, config)
    config = config or {}
    local labelText = config.Label or "Input"
    local default = config.Default or ""
    local placeholder = config.Placeholder or "Digite aqui..."
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Input_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    local stroke = self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(16))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.BackgroundColor3 = self.Theme.Input
    textBox.Position = UDim2.new(0, self:S(12), 0, self:S(28))
    textBox.Size = UDim2.new(1, -self:S(24), 0, self:S(26))
    textBox.Font = self:GetFont()
    textBox.Text = tostring(default)
    textBox.PlaceholderText = placeholder
    textBox.PlaceholderColor3 = self.Theme.TextMuted
    textBox.TextColor3 = self.Theme.Text
    textBox.TextSize = self:S(13)
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = 14
    textBox.Parent = frame
    self:CreateCorner(textBox, UDim.new(0, 6))

    textBox.Focused:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Accent, Transparency = 0.1}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.Accent}, 0.2)
    end)
    textBox.FocusLost:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.TextMuted}, 0.2)
        callback(textBox.Text)
    end)

    return {
        Frame = frame,
        TextBox = textBox,
        GetText = function() return textBox.Text end,
        SetText = function(t) textBox.Text = t end,
    }
end

-- ─── CREATE NUMBER INPUT ──────────────────────────────────────────────────────
function GenesisX:CreateNumberInput(parent, config)
    config = config or {}
    local labelText = config.Label or "Number"
    local default = config.Default or 0
    local min = config.Min or -math.huge
    local max = config.Max or math.huge
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "NumberInput_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    local stroke = self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(16))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.BackgroundColor3 = self.Theme.Input
    textBox.Position = UDim2.new(0, self:S(12), 0, self:S(28))
    textBox.Size = UDim2.new(1, -self:S(24), 0, self:S(26))
    textBox.Font = self:GetFontBold()
    textBox.Text = tostring(default)
    textBox.TextColor3 = self.Theme.Text
    textBox.TextSize = self:S(13)
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = 14
    textBox.Parent = frame
    self:CreateCorner(textBox, UDim.new(0, 6))

    textBox.Focused:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Accent, Transparency = 0.1}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.Accent}, 0.2)
    end)
    textBox.FocusLost:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.TextMuted}, 0.2)
        local value = tonumber(textBox.Text)
        if value then
            value = math.clamp(value, min, max)
            textBox.Text = tostring(value)
            callback(value)
        else
            textBox.Text = tostring(default)
        end
    end)

    return {
        Frame = frame,
        TextBox = textBox,
        GetValue = function() return tonumber(textBox.Text) end,
        SetValue = function(v)
            v = math.clamp(v, min, max)
            textBox.Text = tostring(v)
        end,
    }
end

-- ─── CREATE SLIDER ────────────────────────────────────────────────────────────
function GenesisX:CreateSlider(parent, config)
    config = config or {}
    local text     = config.Text      or "Slider"
    local min      = config.Min       or 0
    local max      = config.Max       or 100
    local default  = config.Default   or min
    local increment = config.Increment or nil
    local callback = config.Callback  or function() end
    local height   = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Slider_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(0.6, 0, 0, self:S(18))
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(12)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    -- ── Valor clicável (vira TextBox ao clicar) ────────────────────────────
    local valueBg = Instance.new("Frame")
    valueBg.Name = "ValueBg"
    valueBg.BackgroundColor3 = self.Theme.Accent
    valueBg.Position = UDim2.new(1, -self:S(42), 0, self:S(8))
    valueBg.Size = UDim2.new(0, self:S(36), 0, self:S(22))
    valueBg.ZIndex = 14
    valueBg.Parent = frame
    self:CreateCorner(valueBg, UDim.new(0, 5))

    -- Label de display (visível normalmente)
    local valueLabel = Instance.new("TextButton")
    valueLabel.Name = "ValueLabel"
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(1, 0, 1, 0)
    valueLabel.Font = self:GetFontBold()
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.new(1, 1, 1)
    valueLabel.TextSize = self:S(11)
    valueLabel.AutoButtonColor = false
    valueLabel.ZIndex = 16
    valueLabel.Parent = valueBg

    -- TextBox de input (invisível por padrão)
    local valueInput = Instance.new("TextBox")
    valueInput.Name = "ValueInput"
    valueInput.BackgroundTransparency = 1
    valueInput.Size = UDim2.new(1, 0, 1, 0)
    valueInput.Font = self:GetFontBold()
    valueInput.Text = ""
    valueInput.PlaceholderText = ""
    valueInput.TextColor3 = Color3.new(1, 1, 1)
    valueInput.TextSize = self:S(11)
    valueInput.ClearTextOnFocus = true
    valueInput.Visible = false
    valueInput.ZIndex = 17
    valueInput.Parent = valueBg

    -- ── Track ──────────────────────────────────────────────────────────────
    local trackHeight = self:S(6)
    local trackBg = Instance.new("Frame")
    trackBg.Name = "TrackBg"
    trackBg.BackgroundColor3 = self.Theme.Input
    trackBg.Position = UDim2.new(0, self:S(14), 1, -self:S(20))
    trackBg.Size = UDim2.new(1, -self:S(28), 0, trackHeight)
    trackBg.ZIndex = 13
    trackBg.Parent = frame
    self:CreateCorner(trackBg, UDim.new(1, 0))

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.BackgroundColor3 = self.Theme.Accent
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.ZIndex = 14
    fill.Parent = trackBg
    self:CreateCorner(fill, UDim.new(1, 0))

    local knobSize = self:S(16)
    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Position = UDim2.new((default - min) / (max - min), -knobSize/2, 0.5, -knobSize/2)
    knob.Size = UDim2.new(0, knobSize, 0, knobSize)
    knob.ZIndex = 15
    knob.Parent = trackBg
    self:CreateCorner(knob, UDim.new(1, 0))
    self:CreateStroke(knob, self.Theme.Accent, 2, 0)

    local dragging = false
    local currentValue = default

    local function snapValue(v)
        if increment then
            v = math.floor((v - min) / increment + 0.5) * increment + min
        end
        return math.floor(math.clamp(v, min, max) * 100) / 100
    end

    local function applyValue(v)
        currentValue = snapValue(v)
        local percent = (currentValue - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -knobSize/2, 0.5, -knobSize/2)
        valueLabel.Text = tostring(currentValue)
        callback(currentValue)
    end

    local function updateFromDrag(input)
        local percent = math.clamp(
            (input.Position.X - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1
        )
        applyValue(min + (max - min) * percent)
    end

    trackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromDrag(input)
        end
    end)
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch) then
            updateFromDrag(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- ── Clique no valor → vira input ───────────────────────────────────────
    valueLabel.MouseButton1Click:Connect(function()
        valueLabel.Visible = false
        valueInput.Visible = true
        valueInput.Text = tostring(currentValue)
        valueInput:CaptureFocus()
    end)

    valueInput.FocusLost:Connect(function(enterPressed)
        local typed = tonumber(valueInput.Text)
        if typed then
            applyValue(typed)
        end
        valueInput.Visible = false
        valueLabel.Visible = true
        valueLabel.Text = tostring(currentValue)
    end)

    -- highlight ao hover no valor
    valueBg.MouseEnter:Connect(function()
        self:Tween(valueBg, {BackgroundColor3 = self.Theme.AccentHover}, 0.15)
    end)
    valueBg.MouseLeave:Connect(function()
        self:Tween(valueBg, {BackgroundColor3 = self.Theme.Accent}, 0.15)
    end)

    return {
        Frame    = frame,
        GetValue = function() return currentValue end,
        SetValue = function(v) applyValue(v) end,
    }
end

-- ─── HELPER: POSIÇÃO DO DROPDOWN ──────────────────────────────────────────────
local function getDropdownPosition(button, layout, maxHeight)
    local btnPos = button.AbsolutePosition
    local btnSize = button.AbsoluteSize
    local contentHeight = layout.AbsoluteContentSize.Y + 12
    local targetHeight = math.min(contentHeight, maxHeight)
    local success, camera = pcall(function() return workspace.CurrentCamera end)
    local screenHeight = (success and camera) and camera.ViewportSize.Y or 768
    local targetY = btnPos.Y + btnSize.Y + 4
    if targetY + targetHeight > screenHeight then
        targetY = btnPos.Y - targetHeight - 4
    end
    return UDim2.fromOffset(btnPos.X, targetY), targetHeight, contentHeight
end

-- ─── CREATE DROPDOWN ──────────────────────────────────────────────────────────
function GenesisX:CreateDropdown(parent, config)
    config = config or {}
    local labelText = config.Label or "Dropdown"
    local options = config.Options or {}
    local default = config.Default
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Dropdown_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = false
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(14))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local dropBtn = Instance.new("TextButton")
    dropBtn.Name = "DropBtn"
    dropBtn.BackgroundColor3 = self.Theme.Input
    dropBtn.AutoButtonColor = false
    dropBtn.Position = UDim2.new(0, self:S(12), 0, self:S(26))
    dropBtn.Size = UDim2.new(1, -self:S(24), 0, self:S(28))
    dropBtn.Font = self:GetFontSemibold()
    dropBtn.Text = "  " .. (default or "Selecionar...")
    dropBtn.TextColor3 = default and self.Theme.Text or self.Theme.TextMuted
    dropBtn.TextSize = self:S(12)
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.ZIndex = 14
    dropBtn.Parent = frame
    self:CreateCorner(dropBtn, UDim.new(0, 6))
    local dropStroke = self:CreateStroke(dropBtn, self.Theme.Border, 1, 0.4)

    -- SETA LUCIDE (chevron-down)
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "Arrow"
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -self:S(28), 0, 0)
    arrow.Size = UDim2.new(0, self:S(26), 1, 0)
    arrow.Image = self:FormatAssetId("lucide-chevron-down") or ""
    arrow.ImageColor3 = self.Theme.Accent
    arrow.ZIndex = 15
    arrow.Parent = dropBtn

    local selected = default
    local isOpen = false

    local overlay = Instance.new("Frame")
    overlay.Name = "DropdownOverlay"
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 500
    overlay.Visible = false
    overlay.Parent = self.ScreenGui

    local listContainer = Instance.new("Frame")
    listContainer.Name = "ListContainer"
    listContainer.BackgroundColor3 = self.Theme.Card
    listContainer.BorderSizePixel = 0
    listContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    listContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    listContainer.Size = UDim2.new(0, 0, 0, 0)
    listContainer.ZIndex = 501
    listContainer.Visible = false
    listContainer.Parent = overlay
    self:CreateCorner(listContainer, UDim.new(0, 12))
    self:CreateStroke(listContainer, self.Theme.Accent, 1.5, 0.3)

    local listTitle = Instance.new("TextLabel")
    listTitle.Name = "Title"
    listTitle.BackgroundTransparency = 1
    listTitle.Position = UDim2.new(0, self:S(16), 0, self:S(12))
    listTitle.Size = UDim2.new(1, -self:S(32), 0, self:S(22))
    listTitle.Font = self:GetFontBold()
    listTitle.Text = labelText
    listTitle.TextColor3 = self.Theme.Text
    listTitle.TextSize = self:S(14)
    listTitle.TextXAlignment = Enum.TextXAlignment.Left
    listTitle.ZIndex = 502
    listTitle.Parent = listContainer

    local dropList = Instance.new("ScrollingFrame")
    dropList.Name = "DropList"
    dropList.BackgroundTransparency = 1
    dropList.BorderSizePixel = 0
    dropList.Position = UDim2.new(0, self:S(12), 0, self:S(40))
    dropList.Size = UDim2.new(1, -self:S(24), 1, -self:S(52))
    dropList.ScrollBarThickness = 4
    dropList.ScrollBarImageColor3 = self.Theme.Accent
    dropList.ScrollBarImageTransparency = 0.4
    dropList.ZIndex = 502
    dropList.Parent = listContainer

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, self:S(4))
    listLayout.Parent = dropList

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop    = UDim.new(0, self:S(4))
    listPadding.PaddingBottom = UDim.new(0, self:S(4))
    listPadding.PaddingLeft   = UDim.new(0, self:S(4))
    listPadding.PaddingRight  = UDim.new(0, self:S(4))
    listPadding.Parent = dropList

    local function closeDropdown()
        if not isOpen then return end
        isOpen = false
        self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
        self:Tween(listContainer, {Size = UDim2.new(0, self:S(320), 0, 0)}, 0.2)
        self:Tween(arrow, {Rotation = 0}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        end
        task.wait(0.2)
        overlay.Visible = false
        listContainer.Visible = false
    end

    local function populate()
        for _, child in ipairs(dropList:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for _, option in ipairs(options) do
            local isSelected = option == selected

            local row = Instance.new("Frame")
            row.BackgroundColor3 = isSelected and self.Theme.AccentDark or self.Theme.Input
            row.Size = UDim2.new(1, 0, 0, self:S(36))
            row.ZIndex = 503
            row.Parent = dropList
            self:CreateCorner(row, UDim.new(0, 8))

            if isSelected then
                self:CreateStroke(row, self.Theme.Accent, 1, 0.2)
                -- CHECKMARK LUCIDE (check)
                local check = Instance.new("ImageLabel")
                check.Name = "Check"
                check.BackgroundTransparency = 1
                check.Position = UDim2.new(0, self:S(10), 0, 0)
                check.Size = UDim2.new(0, self:S(24), 1, 0)
                check.Image = self:FormatAssetId("lucide-check") or ""
                check.ImageColor3 = self.Theme.AccentSecondary
                check.ZIndex = 504
                check.Parent = row
            end

            local rowBtn = Instance.new("TextButton")
            rowBtn.BackgroundTransparency = 1
            rowBtn.Size = UDim2.new(1, 0, 1, 0)
            rowBtn.Font = self:GetFontSemibold()
            rowBtn.Text = (isSelected and "    " or "  ") .. option
            rowBtn.TextColor3 = isSelected and self.Theme.AccentSecondary or self.Theme.Text
            rowBtn.TextSize = self:S(12)
            rowBtn.TextXAlignment = Enum.TextXAlignment.Left
            rowBtn.ZIndex = 504
            rowBtn.Parent = row

            local rowPad = Instance.new("UIPadding")
            rowPad.PaddingLeft = UDim.new(0, isSelected and self:S(32) or self:S(12))
            rowPad.Parent = rowBtn

            rowBtn.MouseButton1Click:Connect(function()
                selected = option
                dropBtn.Text = "  " .. option
                dropBtn.TextColor3 = self.Theme.Text
                callback(option)
                closeDropdown()
            end)
            rowBtn.MouseEnter:Connect(function()
                if not isSelected then
                    self:Tween(row, {BackgroundColor3 = self.Theme.CardHover}, 0.1)
                end
            end)
            rowBtn.MouseLeave:Connect(function()
                if not isSelected then
                    self:Tween(row, {BackgroundColor3 = self.Theme.Input}, 0.1)
                end
            end)
        end
    end

    dropBtn.MouseEnter:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.InputHover}, 0.15)
    end)
    dropBtn.MouseLeave:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.Input}, 0.15)
    end)

    dropBtn.MouseButton1Click:Connect(function()
        if isOpen then closeDropdown(); return end
        populate()
        local contentHeight = listLayout.AbsoluteContentSize.Y + self:S(60)
        local targetHeight = math.min(contentHeight, self:S(360))
        local targetWidth = self:S(320)
        overlay.Visible = true
        listContainer.Visible = true
        overlay.BackgroundTransparency = 1
        listContainer.Size = UDim2.new(0, targetWidth, 0, 0)
        self:Tween(overlay, {BackgroundTransparency = 0.45}, 0.25)
        self:Tween(listContainer, {
            Size = UDim2.new(0, targetWidth, 0, targetHeight)
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        self:Tween(arrow, {Rotation = 180}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2)
        end
        dropList.CanvasSize = UDim2.new(0, 0, 0,
            listLayout.AbsoluteContentSize.Y + self:S(16))
        isOpen = true
    end)

    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position
            local listPos = listContainer.AbsolutePosition
            local listSize = listContainer.AbsoluteSize
            local inList = pos.X >= listPos.X and pos.X <= listPos.X + listSize.X
                       and pos.Y >= listPos.Y and pos.Y <= listPos.Y + listSize.Y
            if not inList then closeDropdown() end
        end
    end)

    return {
        Frame    = frame,
        GetValue = function() return selected end,
        SetValue = function(v)
            selected = v
            dropBtn.Text = "  " .. (v or "Selecionar...")
            dropBtn.TextColor3 = v and self.Theme.Text or self.Theme.TextMuted
        end,
        SetOptions = function(newOptions) options = newOptions end,
    }
end

function GenesisX:CreateMultiDropdown(parent, config)
    config = config or {}
    local labelText = config.Label or "Multi Select"
    local options = config.Options or {}
    local default = config.Default or {}
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "MultiDropdown_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = false
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(14))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local dropBtn = Instance.new("TextButton")
    dropBtn.Name = "DropBtn"
    dropBtn.BackgroundColor3 = self.Theme.Input
    dropBtn.AutoButtonColor = false
    dropBtn.Position = UDim2.new(0, self:S(12), 0, self:S(26))
    dropBtn.Size = UDim2.new(1, -self:S(24), 0, self:S(28))
    dropBtn.Font = self:GetFontSemibold()
    dropBtn.Text = "  Selecionar..."
    dropBtn.TextColor3 = self.Theme.TextMuted
    dropBtn.TextSize = self:S(12)
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.ZIndex = 14
    dropBtn.Parent = frame
    self:CreateCorner(dropBtn, UDim.new(0, 6))
    local dropStroke = self:CreateStroke(dropBtn, self.Theme.Border, 1, 0.4)

    -- SETA LUCIDE (chevron-down)
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "Arrow"
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -self:S(28), 0, 0)
    arrow.Size = UDim2.new(0, self:S(26), 1, 0)
    arrow.Image = self:FormatAssetId("lucide-chevron-down") or ""
    arrow.ImageColor3 = self.Theme.Accent
    arrow.ZIndex = 15
    arrow.Parent = dropBtn

    local selected = {}
    for _, v in ipairs(default) do table.insert(selected, v) end
    local isOpen = false

    local overlay = Instance.new("Frame")
    overlay.Name = "MultiDropdownOverlay"
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 500
    overlay.Visible = false
    overlay.Parent = self.ScreenGui

    local listContainer = Instance.new("Frame")
    listContainer.Name = "ListContainer"
    listContainer.BackgroundColor3 = self.Theme.Card
    listContainer.BorderSizePixel = 0
    listContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    listContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    listContainer.Size = UDim2.new(0, 0, 0, 0)
    listContainer.ZIndex = 501
    listContainer.Visible = false
    listContainer.Parent = overlay
    self:CreateCorner(listContainer, UDim.new(0, 12))
    self:CreateStroke(listContainer, self.Theme.Accent, 1.5, 0.3)

    local listTitle = Instance.new("TextLabel")
    listTitle.Name = "Title"
    listTitle.BackgroundTransparency = 1
    listTitle.Position = UDim2.new(0, self:S(16), 0, self:S(12))
    listTitle.Size = UDim2.new(0.6, 0, 0, self:S(22))
    listTitle.Font = self:GetFontBold()
    listTitle.Text = labelText
    listTitle.TextColor3 = self.Theme.Text
    listTitle.TextSize = self:S(14)
    listTitle.TextXAlignment = Enum.TextXAlignment.Left
    listTitle.ZIndex = 502
    listTitle.Parent = listContainer

    local countBadge = Instance.new("TextLabel")
    countBadge.Name = "CountBadge"
    countBadge.BackgroundColor3 = self.Theme.Accent
    countBadge.Position = UDim2.new(1, -self:S(48), 0, self:S(10))
    countBadge.Size = UDim2.new(0, self:S(36), 0, self:S(22))
    countBadge.Font = self:GetFontBold()
    countBadge.Text = "0"
    countBadge.TextColor3 = Color3.new(1, 1, 1)
    countBadge.TextSize = self:S(11)
    countBadge.ZIndex = 502
    countBadge.Parent = listContainer
    self:CreateCorner(countBadge, UDim.new(0, 6))

    local dropList = Instance.new("ScrollingFrame")
    dropList.Name = "DropList"
    dropList.BackgroundTransparency = 1
    dropList.BorderSizePixel = 0
    dropList.Position = UDim2.new(0, self:S(12), 0, self:S(42))
    dropList.Size = UDim2.new(1, -self:S(24), 1, -self:S(56))
    dropList.ScrollBarThickness = 4
    dropList.ScrollBarImageColor3 = self.Theme.Accent
    dropList.ScrollBarImageTransparency = 0.4
    dropList.ZIndex = 502
    dropList.Parent = listContainer

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, self:S(4))
    listLayout.Parent = dropList

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop    = UDim.new(0, self:S(4))
    listPadding.PaddingBottom = UDim.new(0, self:S(4))
    listPadding.PaddingLeft   = UDim.new(0, self:S(4))
    listPadding.PaddingRight  = UDim.new(0, self:S(4))
    listPadding.Parent = dropList

    local function updateText()
        if #selected == 0 then
            dropBtn.Text = "  Selecionar..."
            dropBtn.TextColor3 = self.Theme.TextMuted
        elseif #selected == 1 then
            dropBtn.Text = "  " .. selected[1]
            dropBtn.TextColor3 = self.Theme.Text
        else
            dropBtn.Text = "  " .. #selected .. " selecionados"
            dropBtn.TextColor3 = self.Theme.Text
        end
        countBadge.Text = tostring(#selected)
    end

    local function closeDropdown()
        if not isOpen then return end
        isOpen = false
        self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
        self:Tween(listContainer, {Size = UDim2.new(0, self:S(320), 0, 0)}, 0.2)
        self:Tween(arrow, {Rotation = 0}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        end
        task.wait(0.2)
        overlay.Visible = false
        listContainer.Visible = false
    end

    local function isSelectedFn(name)
        for _, v in ipairs(selected) do
            if v == name then return true end
        end
        return false
    end

    local function toggle(name)
        for i, v in ipairs(selected) do
            if v == name then
                table.remove(selected, i)
                return false
            end
        end
        table.insert(selected, name)
        return true
    end

    local function populate()
        for _, child in ipairs(dropList:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for _, option in ipairs(options) do
            local sel = isSelectedFn(option)

            local row = Instance.new("Frame")
            row.BackgroundColor3 = sel and self.Theme.AccentDark or self.Theme.Input
            row.Size = UDim2.new(1, 0, 0, self:S(38))
            row.ZIndex = 503
            row.Parent = dropList
            self:CreateCorner(row, UDim.new(0, 8))

            local cbSize = self:S(18)
            local checkbox = Instance.new("Frame")
            checkbox.Name = "Checkbox"
            checkbox.BackgroundColor3 = sel and self.Theme.Accent or self.Theme.Border
            checkbox.Position = UDim2.new(0, self:S(10), 0.5, -cbSize/2)
            checkbox.Size = UDim2.new(0, cbSize, 0, cbSize)
            checkbox.ZIndex = 504
            checkbox.Parent = row
            self:CreateCorner(checkbox, UDim.new(0, 4))

            if sel then
                -- CHECKMARK LUCIDE (check)
                local check = Instance.new("ImageLabel")
                check.Name = "Check"
                check.BackgroundTransparency = 1
                check.Size = UDim2.new(1, 0, 1, 0)
                check.Image = self:FormatAssetId("lucide-check") or ""
                check.ImageColor3 = Color3.new(1, 1, 1)
                check.ZIndex = 505
                check.Parent = checkbox
            end

            local rowBtn = Instance.new("TextButton")
            rowBtn.BackgroundTransparency = 1
            rowBtn.Size = UDim2.new(1, 0, 1, 0)
            rowBtn.Font = self:GetFontSemibold()
            rowBtn.Text = "      " .. option
            rowBtn.TextColor3 = sel and self.Theme.AccentSecondary or self.Theme.Text
            rowBtn.TextSize = self:S(12)
            rowBtn.TextXAlignment = Enum.TextXAlignment.Left
            rowBtn.ZIndex = 504
            rowBtn.Parent = row

            local rowPad = Instance.new("UIPadding")
            rowPad.PaddingLeft = UDim.new(0, self:S(12))
            rowPad.Parent = rowBtn

            rowBtn.MouseButton1Click:Connect(function()
                toggle(option)
                callback(selected)
                updateText()
                populate()
            end)
            rowBtn.MouseEnter:Connect(function()
                if not sel then
                    self:Tween(row, {BackgroundColor3 = self.Theme.CardHover}, 0.1)
                end
            end)
            rowBtn.MouseLeave:Connect(function()
                if not sel then
                    self:Tween(row, {BackgroundColor3 = self.Theme.Input}, 0.1)
                end
            end)
        end
    end

    dropBtn.MouseEnter:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.InputHover}, 0.15)
    end)
    dropBtn.MouseLeave:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.Input}, 0.15)
    end)

    dropBtn.MouseButton1Click:Connect(function()
        if isOpen then closeDropdown(); return end
        populate()
        local contentHeight = listLayout.AbsoluteContentSize.Y + self:S(64)
        local targetHeight = math.min(contentHeight, self:S(360))
        local targetWidth = self:S(320)
        overlay.Visible = true
        listContainer.Visible = true
        overlay.BackgroundTransparency = 1
        listContainer.Size = UDim2.new(0, targetWidth, 0, 0)
        self:Tween(overlay, {BackgroundTransparency = 0.45}, 0.25)
        self:Tween(listContainer, {
            Size = UDim2.new(0, targetWidth, 0, targetHeight)
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        self:Tween(arrow, {Rotation = 180}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2)
        end
        dropList.CanvasSize = UDim2.new(0, 0, 0,
            listLayout.AbsoluteContentSize.Y + self:S(16))
        isOpen = true
    end)

    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position
            local listPos = listContainer.AbsolutePosition
            local listSize = listContainer.AbsoluteSize
            local inList = pos.X >= listPos.X and pos.X <= listPos.X + listSize.X
                       and pos.Y >= listPos.Y and pos.Y <= listPos.Y + listSize.Y
            if not inList then closeDropdown() end
        end
    end)

    updateText()

    return {
        Frame     = frame,
        GetValues = function() return selected end,
        SetValues = function(v)
            selected = {}
            for _, val in ipairs(v) do table.insert(selected, val) end
            updateText()
        end,
        SetOptions = function(newOptions) options = newOptions end,
    }
end

-- ─── CREATE CHECKBOX ──────────────────────────────────────────────────────────
function GenesisX:CreateCheckbox(parent, config)
    config = config or {}
    local text = config.Text or "Checkbox"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local height = self:S(42)

    local frame = Instance.new("Frame")
    frame.Name = "Checkbox_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local cbSize = self:S(20)
    local checkbox = Instance.new("ImageButton")
    checkbox.Name = "Checkbox"
    checkbox.BackgroundColor3 = default and self.Theme.Accent or self.Theme.Input
    checkbox.AutoButtonColor = false
    checkbox.Position = UDim2.new(0, self:S(14), 0.5, -cbSize/2)
    checkbox.Size = UDim2.new(0, cbSize, 0, cbSize)
    checkbox.Image = default and (self:FormatAssetId("lucide-check") or "") or ""
    checkbox.ImageColor3 = Color3.new(1, 1, 1)
    checkbox.ZIndex = 14
    checkbox.Parent = frame
    self:CreateCorner(checkbox, UDim.new(0, 5))
    self:CreateStroke(checkbox, default and self.Theme.Accent or self.Theme.Border, 1.5, default and 0.2 or 0.4)

    local cbStroke = checkbox:FindFirstChildOfClass("UIStroke")

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(42), 0, 0)
    label.Size = UDim2.new(1, -self:S(56), 1, 0)
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(13)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 13
    label.Parent = frame

    local state = default

    checkbox.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            self:Tween(checkbox, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            if cbStroke then self:Tween(cbStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2) end
            checkbox.Image = self:FormatAssetId("lucide-check") or ""
        else
            self:Tween(checkbox, {BackgroundColor3 = self.Theme.Input}, 0.2)
            if cbStroke then self:Tween(cbStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2) end
            checkbox.Image = ""
        end
    end)

    return {
        Frame = frame,
        GetState = function() return state end,
        SetState = function(s)
            state = s
            callback(state)
            self:Tween(checkbox, {BackgroundColor3 = state and self.Theme.Accent or self.Theme.Input}, 0.2)
            checkbox.Image = state and (self:FormatAssetId("lucide-check") or "") or ""
        end,
    }
end


-- ─── CREATE LABEL ─────────────────────────────────────────────────────────────
function GenesisX:CreateLabel(parent, config)
    config = config or {}
    local text      = config.Text    or "Label"
    local color     = config.Color   or self.Theme.TextSecondary
    local wrapped   = config.Wrapped ~= false
    local padV      = self:S(10)
    local padH      = self:S(14)
    local minHeight = self:S(36)

    local frame = Instance.new("Frame")
    frame.Name = "Label_" .. text:sub(1, 10)
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, minHeight)
    frame.ClipsDescendants = false   -- não corta o conteúdo
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.5)

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft   = UDim.new(0, padH)
    pad.PaddingRight  = UDim.new(0, padH)
    pad.PaddingTop    = UDim.new(0, padV)
    pad.PaddingBottom = UDim.new(0, padV)
    pad.Parent = frame

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 0)           -- altura começa 0
    label.AutomaticSize = Enum.AutomaticSize.Y    -- cresce com o texto
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = color
    label.TextSize = self:S(12)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = wrapped
    label.ZIndex = 13
    label.Parent = frame

    -- frame acompanha o label com padding
    local function updateHeight()
        if not label or not label.Parent then return end
        local textH = label.TextBounds.Y
        if textH <= 0 then textH = self:S(16) end
        frame.Size = UDim2.new(1, 0, 0, math.max(minHeight, textH + padV * 2))
    end

    label:GetPropertyChangedSignal("TextBounds"):Connect(updateHeight)
    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHeight)
    task.delay(0.1, updateHeight)

    return {
        Frame    = frame,
        Label    = label,
        SetText  = function(t)
            label.Text = t
            task.defer(updateHeight)
        end,
        SetColor = function(c) label.TextColor3 = c end,
    }
end

-- ─── CREATE LABEL TOGGLE SUBTITLE ─────────────────────────────────────────────
function GenesisX:CreateLabelToggleSubTitle(parent, config)
    config = config or {}
    local titleText = config.Title or "Title"
    local subtitles = config.Subtitles or {}
    local buttons = config.Buttons or {}
    local titleColor = config.TitleColor or self.Theme.Accent

    local subtitleCount = #subtitles
    local buttonCount = #buttons
    local baseHeight = self:S(46)
    local extraHeight = (subtitleCount * self:S(18)) + (buttonCount * self:S(34)) + self:S(16)
    local totalHeight = baseHeight + extraHeight

    local frame = Instance.new("Frame")
    frame.Name = "LabelToggleSubTitle_" .. titleText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, totalHeight)
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    titleLabel.Size = UDim2.new(1, -self:S(28), 0, self:S(20))
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = titleText
    titleLabel.TextColor3 = titleColor
    titleLabel.TextSize = self:S(13)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 13
    titleLabel.Parent = frame

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.BackgroundTransparency = 1
    contentFrame.Position = UDim2.new(0, self:S(14), 0, self:S(32))
    contentFrame.Size = UDim2.new(1, -self:S(28), 1, -self:S(40))
    contentFrame.ZIndex = 13
    contentFrame.Parent = frame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, self:S(6))
    contentLayout.Parent = contentFrame

    local subtitleLabels = {}
    for i, subText in ipairs(subtitles) do
        local subLabel = Instance.new("TextLabel")
        subLabel.Name = "Subtitle_" .. i
        subLabel.BackgroundTransparency = 1
        subLabel.Size = UDim2.new(1, 0, 0, self:S(16))
        subLabel.Font = self:GetFont()
        subLabel.Text = subText
        subLabel.TextColor3 = self.Theme.TextSecondary
        subLabel.TextSize = self:S(11)
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        subLabel.ZIndex = 14
        subLabel.Parent = contentFrame
        table.insert(subtitleLabels, subLabel)
    end

    local buttonObjects = {}
    for i, btnConfig in ipairs(buttons) do
        local btnText     = btnConfig.Text     or "Button"
        local btnCallback = btnConfig.Callback or function() end
        local btnStyle    = btnConfig.Style    or "default"

        local btnFrame = Instance.new("Frame")
        btnFrame.Name = "ButtonFrame_" .. i
        btnFrame.BackgroundTransparency = 1
        btnFrame.Size = UDim2.new(1, 0, 0, self:S(32))
        btnFrame.ZIndex = 14
        btnFrame.Parent = contentFrame

        local btn = Instance.new("TextButton")
        btn.Name = "Button"
        btn.AutoButtonColor = false
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.Font = self:GetFontBold()
        btn.Text = btnText
        btn.TextSize = self:S(12)
        btn.ZIndex = 15
        btn.Parent = btnFrame
        self:CreateCorner(btn, UDim.new(0, 6))

        -- Cor sólida, sem borda, sem gradiente
        local bgColor, hoverColor, textColor
        if btnStyle == "accent" then
            bgColor    = self.Theme.Accent
            hoverColor = self.Theme.AccentHover
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "danger" then
            bgColor    = Color3.fromRGB(120, 30, 30)
            hoverColor = Color3.fromRGB(150, 40, 40)
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "warning" then
            bgColor    = Color3.fromRGB(120, 70, 0)
            hoverColor = Color3.fromRGB(150, 90, 0)
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "info" then
            bgColor    = Color3.fromRGB(30, 60, 120)
            hoverColor = Color3.fromRGB(40, 80, 150)
            textColor  = Color3.new(1, 1, 1)
        else
            bgColor    = self.Theme.Card
            hoverColor = self.Theme.CardHover
            textColor  = self.Theme.Text
        end

        btn.BackgroundColor3 = bgColor
        btn.TextColor3 = textColor

        local rippleHolder = Instance.new("Frame")
        rippleHolder.Name = "RippleHolder"
        rippleHolder.BackgroundTransparency = 1
        rippleHolder.BorderSizePixel = 0
        rippleHolder.Size = UDim2.new(1, 0, 1, 0)
        rippleHolder.ClipsDescendants = true
        rippleHolder.ZIndex = btn.ZIndex + 1
        rippleHolder.Parent = btn
        self:CreateCorner(rippleHolder, UDim.new(0, 6))

        local btnData = {
            Button          = btn,
            Frame           = btnFrame,
            CurrentCallback = btnCallback,
            CurrentStyle    = btnStyle,
            CurrentBg       = bgColor,
            CurrentHover    = hoverColor,
            CurrentText     = textColor,
        }

        btn.MouseEnter:Connect(function()
            self:Tween(btn, {BackgroundColor3 = btnData.CurrentHover}, 0.15)
        end)
        btn.MouseLeave:Connect(function()
            self:Tween(btn, {BackgroundColor3 = btnData.CurrentBg}, 0.15)
        end)
        btn.MouseButton1Click:Connect(function()
            self:CreateRipple(btn, UserInputService:GetMouseLocation())
            btnData.CurrentCallback()
        end)

        table.insert(buttonObjects, btnData)
    end

    return {
        Frame = frame,
        Title = titleLabel,

        SetTitle = function(t) titleLabel.Text = t end,
        SetTitleColor = function(c) titleLabel.TextColor3 = c end,

        SetSubtitles = function(newSubtitles)
            for i, subLabel in ipairs(subtitleLabels) do
                subLabel.Text = newSubtitles[i] or ""
            end
        end,

        SetSubtitle = function(index, text)
            if subtitleLabels[index] then
                subtitleLabels[index].Text = text or ""
            end
        end,

        SetButtonText = function(index, text)
            local bd = buttonObjects[index]
            if bd then bd.Button.Text = text or "" end
        end,

        SetButtonCallback = function(index, callback)
            local bd = buttonObjects[index]
            if bd then bd.CurrentCallback = callback or function() end end
        end,

        SetButtonStyle = function(index, style)
            local bd = buttonObjects[index]
            if not bd then return end

            local newBg, newHover, newText
            if style == "accent" then
                newBg    = self.Theme.Accent
                newHover = self.Theme.AccentHover
                newText  = Color3.new(1, 1, 1)
            elseif style == "danger" then
                newBg    = Color3.fromRGB(120, 30, 30)
                newHover = Color3.fromRGB(150, 40, 40)
                newText  = Color3.new(1, 1, 1)
            elseif style == "warning" then
                newBg    = Color3.fromRGB(120, 70, 0)
                newHover = Color3.fromRGB(150, 90, 0)
                newText  = Color3.new(1, 1, 1)
            elseif style == "info" then
                newBg    = Color3.fromRGB(30, 60, 120)
                newHover = Color3.fromRGB(40, 80, 150)
                newText  = Color3.new(1, 1, 1)
            else
                newBg    = self.Theme.Card
                newHover = self.Theme.CardHover
                newText  = self.Theme.Text
            end

            bd.CurrentStyle = style
            bd.CurrentBg    = newBg
            bd.CurrentHover = newHover
            bd.CurrentText  = newText

            bd.Button.BackgroundColor3 = newBg
            bd.Button.TextColor3       = newText
        end,

        SetVisible = function(visible)
            frame.Visible = visible
        end,

        Subtitles = subtitleLabels,
        Buttons   = buttonObjects,
    }
end

-- ─── CREATE SEPARATOR ─────────────────────────────────────────────────────────
function GenesisX:CreateSeparator(parent)
    local wrap = Instance.new("Frame")
    wrap.Name = "Separator"
    wrap.BackgroundTransparency = 1
    wrap.Size = UDim2.new(1, 0, 0, self:S(12))
    wrap.ZIndex = 12
    wrap.Parent = parent

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.BackgroundColor3 = self.Theme.Border
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.ZIndex = 12
    line.Parent = wrap
    self:CreateGradient(line, Color3.new(0, 0, 0), self.Theme.BorderBright, 0)

    return wrap
end

-- ─── CREATE STATUS CARD ───────────────────────────────────────────────────────
function GenesisX:CreateStatusCard(parent, config)
    config = config or {}
    local title = config.Title or "Status"
    local height = self:S(110)

    local frame = Instance.new("Frame")
    frame.Name = "StatusCard"
    frame.BackgroundColor3 = self.Theme.Card
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.Active = true
    frame.ZIndex = 12
    frame.Parent = parent
    self:CreateCorner(frame, UDim.new(0, 10))

    local stroke = self:CreateStroke(frame, self.Theme.Accent, 1.5, 0)
    spawn(function()
        while frame and frame.Parent do
            self:Tween(stroke, {Transparency = 0.1}, 1)
            task.wait(1)
            if not frame or not frame.Parent then break end
            self:Tween(stroke, {Transparency = 0.6}, 1)
            task.wait(1)
        end
    end)

    local leftBar = Instance.new("Frame")
    leftBar.Name = "LeftBar"
    leftBar.BackgroundColor3 = self.Theme.Accent
    leftBar.BorderSizePixel = 0
    leftBar.Position = UDim2.new(0, 0, 0, 0)
    leftBar.Size = UDim2.new(0, 3, 1, 0)
    leftBar.ZIndex = 13
    leftBar.Parent = frame
    self:CreateCorner(leftBar, UDim.new(0, 10))

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = self.Theme.Header
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, self:S(34))
    header.Parent = frame
    self:CreateCorner(header, UDim.new(0, 10))

    local headerCover = Instance.new("Frame")
    headerCover.BackgroundColor3 = self.Theme.Header
    headerCover.BorderSizePixel = 0
    headerCover.Size = UDim2.new(1, 0, 0, 10)
    headerCover.Position = UDim2.new(0, 0, 1, -10)
    headerCover.Parent = header

    local headerTitle = Instance.new("TextLabel")
    headerTitle.Name = "Title"
    headerTitle.BackgroundTransparency = 1
    headerTitle.Position = UDim2.new(0, self:S(16), 0, 0)
    headerTitle.Size = UDim2.new(1, -self:S(16), 1, 0)
    headerTitle.Font = self:GetFontBold()
    headerTitle.Text = title
    headerTitle.TextColor3 = self.Theme.Text
    headerTitle.TextSize = self:S(12)
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.ZIndex = 14
    headerTitle.Parent = header

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, self:S(14), 0, self:S(38))
    content.Size = UDim2.new(1, -self:S(28), 1, -self:S(48))
    content.ZIndex = 13
    content.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.BackgroundTransparency = 1
    statusLabel.Size = UDim2.new(1, 0, 0, self:S(20))
    statusLabel.Font = self:GetFontSemibold()
    statusLabel.Text = "● Idle"
    statusLabel.TextColor3 = self.Theme.TextMuted
    statusLabel.TextSize = self:S(12)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 14
    statusLabel.Parent = content

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "Info"
    infoLabel.BackgroundTransparency = 1
    infoLabel.Position = UDim2.new(0, 0, 0, self:S(22))
    infoLabel.Size = UDim2.new(1, 0, 0, self:S(16))
    infoLabel.Font = self:GetFont()
    infoLabel.Text = "Aguardando..."
    infoLabel.TextColor3 = self.Theme.TextMuted
    infoLabel.TextSize = self:S(10)
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.ZIndex = 14
    infoLabel.Parent = content

    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.BackgroundColor3 = self.Theme.Input
    barBg.Position = UDim2.new(0, 0, 1, -self:S(6))
    barBg.Size = UDim2.new(1, 0, 0, self:S(5))
    barBg.ClipsDescendants = true
    barBg.ZIndex = 13
    barBg.Parent = content
    self:CreateCorner(barBg, UDim.new(1, 0))

    local bar = Instance.new("Frame")
    bar.Name = "Bar"
    bar.BackgroundColor3 = self.Theme.Accent
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BorderSizePixel = 0
    bar.ZIndex = 14
    bar.Parent = barBg
    self:CreateCorner(bar, UDim.new(1, 0))
    self:CreateGradient(bar, self.Theme.Accent, self.Theme.AccentDark, 0)

    self:MakeDraggable(frame, header)

    return {
        Frame = frame,
        SetStatus = function(status, color)
            statusLabel.Text = "● " .. status
            statusLabel.TextColor3 = color or self.Theme.TextMuted
        end,
        SetInfo = function(info) infoLabel.Text = info end,
        SetProgress = function(percent) bar.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0) end,
        AnimateLoading = function(active, duration)
            if active then
                spawn(function()
                    while active and frame and frame.Parent do
                        bar.Size = UDim2.new(0, 0, 1, 0)
                        local tween = self:Tween(bar, {Size = UDim2.new(1, 0, 1, 0)}, duration or 1.5)
                        tween.Completed:Wait()
                        task.wait(0.1)
                    end
                end)
            else
                bar.Size = UDim2.new(0, 0, 1, 0)
            end
        end,
    }
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- ─── NOTIFICATIONS — REDESIGN GENESISX ───────────────────────────────────────
-- ═══════════════════════════════════════════════════════════════════════════════
function GenesisX:Notify(config)
    config = config or {}
    local message   = config.Text     or "Notificação"
    local title     = config.Title    or nil
    local subtitle  = config.Subtitle or nil
    local subtitles = config.Subtitles or nil
    local ntype     = config.Type     or "info"
    local duration  = config.Duration or 4

    self:UpdateScale()

    -- ── Dimensões ──────────────────────────────────────────────────────────────
    local W  = self:S(ScaleData.IsMobile and 320 or 380)
    local PAD_RIGHT  = self:S(16)
    local PAD_BOTTOM = self:S(16)
    local GAP        = self:S(10)

    -- ── Cores do tipo ─────────────────────────────────────────────────────────
    local typeColors = {
        success = self.Theme.Success,
        warning = self.Theme.Warning,
        error   = self.Theme.Error,
        info    = self.Theme.Info,
        genesis = self.Theme.Accent,
    }
    local typeIcons = {
        success = "lucide-check-circle",
        warning = "lucide-alert-triangle",
        error   = "lucide-x-circle",
        info    = "lucide-info",
        genesis = "lucide-genesis-hub",
    }
    local accentColor = typeColors[ntype] or self.Theme.Info
    local iconName    = typeIcons[ntype]  or "lucide-info"

    -- ── Viewport helper ───────────────────────────────────────────────────────
    local function viewport()
        local ok, cam = pcall(function() return workspace.CurrentCamera end)
        return (ok and cam) and cam.ViewportSize or Vector2.new(1366, 768)
    end

    -- ── Calcular altura dinâmica ──────────────────────────────────────────────
    local iconAreaW = self:S(70)
    local contentX = iconAreaW + self:S(12)
    local contentW = W - contentX - self:S(36) -- espaço pro X
    local baseH = self:S(72)
    local totalH = baseH

    -- Se tiver subtitles array, calcular altura extra
    if subtitles and #subtitles > 0 then
        totalH = baseH + (#subtitles * self:S(18))
    elseif subtitle then
        totalH = baseH + self:S(18)
    end

    -- ── Criar frame principal ─────────────────────────────────────────────────
    local notif = Instance.new("Frame")
    notif.Name               = "GX_Notification"
    notif.BackgroundColor3   = self.Theme.Background
    notif.BorderSizePixel    = 0
    notif.Size               = UDim2.fromOffset(W, totalH)
    notif.ClipsDescendants   = true
    notif.ZIndex             = 5000
    notif.Parent             = self.ScreenGui
    self:CreateCorner(notif, UDim.new(0, self:S(14)))
    self:CreateStroke(notif, accentColor, 1.5, 0.3)

    -- ── Área do ícone (esquerda) ──────────────────────────────────────────────
    local iconArea = Instance.new("Frame")
    iconArea.Name             = "IconArea"
    iconArea.BackgroundTransparency = 1
    iconArea.Size             = UDim2.new(0, iconAreaW, 1, -self:S(4))
    iconArea.Position         = UDim2.new(0, 0, 0, 0)
    iconArea.ZIndex           = 5001
    iconArea.Parent           = notif

    -- Background do ícone com glow sutil
    local iconBg = Instance.new("Frame")
    iconBg.Name             = "IconBg"
    iconBg.BackgroundColor3 = accentColor
    iconBg.BackgroundTransparency = 0.85
    iconBg.BorderSizePixel  = 0
    iconBg.Size             = UDim2.fromOffset(self:S(46), self:S(46))
    iconBg.Position         = UDim2.new(0.5, 0, 0.5, 0)
    iconBg.AnchorPoint      = Vector2.new(0.5, 0.5)
    iconBg.ZIndex           = 5001
    iconBg.Parent           = iconArea
    self:CreateCorner(iconBg, UDim.new(1, 0))

    -- Glow mais forte atrás
    local iconGlow = Instance.new("Frame")
    iconGlow.Name             = "IconGlow"
    iconGlow.BackgroundColor3 = accentColor
    iconGlow.BackgroundTransparency = 0.92
    iconGlow.BorderSizePixel  = 0
    iconGlow.Size             = UDim2.fromOffset(self:S(56), self:S(56))
    iconGlow.Position         = UDim2.new(0.5, 0, 0.5, 0)
    iconGlow.AnchorPoint      = Vector2.new(0.5, 0.5)
    iconGlow.ZIndex           = 5000
    iconGlow.Parent           = iconArea
    self:CreateCorner(iconGlow, UDim.new(1, 0))

    -- Ícone Lucide
    local iconImg = Instance.new("ImageLabel")
    iconImg.Name                = "Icon"
    iconImg.BackgroundTransparency = 1
    iconImg.Size                = UDim2.new(0.55, 0, 0.55, 0)
    iconImg.Position            = UDim2.new(0.225, 0, 0.225, 0)
    iconImg.Image               = self:FormatAssetId(iconName) or ""
    iconImg.ImageColor3         = accentColor
    iconImg.ZIndex              = 5002
    iconImg.Parent              = iconBg

    -- ── Separador vertical ───────────────────────────────────────────────────
    local separator = Instance.new("Frame")
    separator.Name             = "Separator"
    separator.BackgroundColor3 = accentColor
    separator.BackgroundTransparency = 0.4
    separator.BorderSizePixel  = 0
    separator.Size             = UDim2.new(0, self:S(2), 0.7, 0)
    separator.Position         = UDim2.new(0, iconAreaW, 0.5, 0)
    separator.AnchorPoint      = Vector2.new(0, 0.5)
    separator.ZIndex           = 5001
    separator.Parent           = notif

    -- ── Área de conteúdo (texto) ─────────────────────────────────────────────
    local contentArea = Instance.new("Frame")
    contentArea.Name             = "ContentArea"
    contentArea.BackgroundTransparency = 1
    contentArea.Position         = UDim2.new(0, contentX, 0, self:S(10))
    contentArea.Size             = UDim2.new(0, contentW, 1, -self:S(14))
    contentArea.ZIndex           = 5001
    contentArea.Parent           = notif

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name             = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size             = UDim2.new(1, 0, 0, self:S(20))
    titleLabel.Font             = self:GetFontBold()
    titleLabel.Text             = title or message
    titleLabel.TextColor3       = accentColor
    titleLabel.TextSize         = self:S(13)
    titleLabel.TextXAlignment   = Enum.TextXAlignment.Left
    titleLabel.TextTruncate     = Enum.TextTruncate.AtEnd
    titleLabel.ZIndex           = 5002
    titleLabel.Parent           = contentArea

    -- Subtitles container
    local subtitleY = self:S(22)
    local subtitleTexts = {}

    if subtitles and #subtitles > 0 then
        for i, subText in ipairs(subtitles) do
            local subLabel = Instance.new("TextLabel")
            subLabel.Name             = "Subtitle_" .. i
            subLabel.BackgroundTransparency = 1
            subLabel.Position         = UDim2.new(0, 0, 0, subtitleY + ((i-1) * self:S(18)))
            subLabel.Size             = UDim2.new(1, 0, 0, self:S(16))
            subLabel.Font             = self:GetFont()
            subLabel.Text             = subText
            subLabel.TextColor3       = self.Theme.TextSecondary
            subLabel.TextSize         = self:S(11)
            subLabel.TextXAlignment   = Enum.TextXAlignment.Left
            subLabel.TextTruncate     = Enum.TextTruncate.AtEnd
            subLabel.ZIndex           = 5002
            subLabel.Parent           = contentArea
            table.insert(subtitleTexts, subLabel)
        end
    elseif subtitle then
        local subLabel = Instance.new("TextLabel")
        subLabel.Name             = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position         = UDim2.new(0, 0, 0, subtitleY)
        subLabel.Size             = UDim2.new(1, 0, 0, self:S(16))
        subLabel.Font             = self:GetFont()
        subLabel.Text             = subtitle
        subLabel.TextColor3       = self.Theme.TextSecondary
        subLabel.TextSize         = self:S(11)
        subLabel.TextXAlignment   = Enum.TextXAlignment.Left
        subLabel.TextTruncate     = Enum.TextTruncate.AtEnd
        subLabel.ZIndex           = 5002
        subLabel.Parent           = contentArea
    elseif not title then
        -- Se não tiver title, a mensagem é o title (já setado acima)
        -- e não precisa de subtitle
    else
        -- Se tiver title mas não subtitle, usar message como subtitle
        local subLabel = Instance.new("TextLabel")
        subLabel.Name             = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position         = UDim2.new(0, 0, 0, subtitleY)
        subLabel.Size             = UDim2.new(1, 0, 0, self:S(16))
        subLabel.Font             = self:GetFont()
        subLabel.Text             = message
        subLabel.TextColor3       = self.Theme.TextSecondary
        subLabel.TextSize         = self:S(11)
        subLabel.TextXAlignment   = Enum.TextXAlignment.Left
        subLabel.TextTruncate     = Enum.TextTruncate.AtEnd
        subLabel.ZIndex           = 5002
        subLabel.Parent           = contentArea
    end

    -- ── Botão fechar (X) ───────────────────────────────────────────────────────
    local closeSize = self:S(18)
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name               = "CloseBtn"
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position           = UDim2.new(1, -self:S(26), 0, self:S(10))
    closeBtn.Size               = UDim2.fromOffset(closeSize, closeSize)
    closeBtn.Image              = self:FormatAssetId("lucide-x") or ""
    closeBtn.ImageColor3        = self.Theme.TextMuted
    closeBtn.ImageTransparency  = 0
    closeBtn.ZIndex             = 5003
    closeBtn.AutoButtonColor    = false
    closeBtn.Parent             = notif

    closeBtn.MouseEnter:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = Color3.new(1, 1, 1)}, 0.1)
    end)
    closeBtn.MouseLeave:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = self.Theme.TextMuted}, 0.1)
    end)

    -- ── Barra de progresso (timer) na base ───────────────────────────────────
    local timerBg = Instance.new("Frame")
    timerBg.Name                = "TimerBg"
    timerBg.BackgroundColor3    = self.Theme.Card
    timerBg.BorderSizePixel     = 0
    timerBg.Size                = UDim2.new(1, 0, 0, self:S(3))
    timerBg.Position            = UDim2.new(0, 0, 1, -self:S(3))
    timerBg.ZIndex              = 5001
    timerBg.Parent              = notif

    local timerBar = Instance.new("Frame")
    timerBar.Name               = "TimerBar"
    timerBar.BackgroundColor3   = accentColor
    timerBar.BorderSizePixel    = 0
    timerBar.Size               = UDim2.new(1, 0, 1, 0)
    timerBar.ZIndex             = 5002
    timerBar.Parent             = timerBg

    -- ── Registrar e posicionar ───────────────────────────────────────────────
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
                    self:Tween(self._notifications[i], {Position = UDim2.fromOffset(xPos, yPos)}, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                else
                    self._notifications[i].Position = UDim2.fromOffset(xPos, yPos)
                end
            end
        end
    end

    -- Posição inicial (fora da tela à direita)
    do
        local yPos = bottomY(#self._notifications)
        notif.Position = UDim2.fromOffset(offscreenX(), yPos)
    end

    -- Animação de entrada
    self:Tween(notif, {
        Position = UDim2.fromOffset(targetX(), bottomY(#self._notifications))
    }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    restack(true)

    -- ── Timer bar shrink ─────────────────────────────────────────────────────
    self:Tween(timerBar, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)

    -- ── Dismiss ───────────────────────────────────────────────────────────────
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

        self:Tween(notif, {
            Position = UDim2.fromOffset(offscreenX(), notif.AbsolutePosition.Y),
        }, 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

        task.delay(0.05, function() restack(true) end)

        task.delay(0.32, function()
            if notif and notif.Parent then notif:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)

    -- Click no corpo também descarta
    notif.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            if not dismissed then dismiss() end
        end
    end)

    -- Auto-dismiss
    task.delay(duration, function()
        if not dismissed then dismiss() end
    end)

    -- API de retorno
    return {
        Destroy = dismiss,
        SetTitle = function(t)
            if titleLabel then titleLabel.Text = t end
        end,
        SetSubtitle = function(index, text)
            if subtitleTexts[index] then
                subtitleTexts[index].Text = text
            end
        end,
        SetSubtitles = function(newSubs)
            for i, lbl in ipairs(subtitleTexts) do
                lbl.Text = newSubs[i] or ""
            end
        end,
    }
end

-- ─── DESTROY ──────────────────────────────────────────────────────────────────
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

function GenesisX:SetFont(fontName)
    self.Font = fontName or "Gotham"
end

function GenesisX:SetTheme(newTheme)
    if type(newTheme) == "string" then
        if newTheme == "Light" and self.Themes and self.Themes.Light then
            self.Theme = self.Themes.Light
        elseif self.Themes and self.Themes.Dark then
            self.Theme = self.Themes.Dark
        end
    elseif type(newTheme) == "table" then
        for key, value in pairs(newTheme) do
            if self.Theme[key] ~= nil then self.Theme[key] = value end
        end
    end
end

-- ─── ALIASES / COMPATIBILIDADE ────────────────────────────────────────────────
-- Permite usar GenesisX:Notify, SpectrumX:Notify, ou Notify() diretamente
local env = (getgenv and getgenv()) or _G or {}
env.SpectrumX = GenesisX
env.Notify = function(...) return GenesisX:Notify(...) end

return GenesisX
