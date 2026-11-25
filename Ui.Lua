-- LENN HUB | 2-COLUMN UI ENGINE (ui.lua)
local Players, TS = game:GetService("Players"), game:GetService("TweenService")
local genv = (getgenv and getgenv()) or _G
genv.Config = genv.Config or {}

local host = (gethui and gethui()) or game:GetService("CoreGui")
if host:IsA("ScreenGui") then host = host.Parent or game:GetService("CoreGui") end
if host:FindFirstChild("LennHubUI") then host.LennHubUI:Destroy() end

local Gui = Instance.new("ScreenGui", host); Gui.Name = "LennHubUI"; Gui.ResetOnSpawn = false; Gui.DisplayOrder = 999

local FBtn = Instance.new("TextButton", Gui)
FBtn.Size = UDim2.fromOffset(46, 46); FBtn.Position = UDim2.new(0.04, 0, 0.25, 0)
FBtn.BackgroundColor3 = Color3.fromRGB(22, 12, 15); FBtn.Text = "L"; FBtn.TextColor3 = Color3.fromRGB(235, 45, 65)
FBtn.Font = Enum.Font.GothamBlack; FBtn.TextSize = 23; FBtn.Draggable = true
Instance.new("UICorner", FBtn).CornerRadius = UDim.new(0, 12)
local FS = Instance.new("UIStroke", FBtn); FS.Color = Color3.fromRGB(220, 35, 55); FS.Thickness = 2

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(535, 330); Main.Position = UDim2.fromScale(0.5, 0.5); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(13, 13, 16); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MS = Instance.new("UIStroke", Main); MS.Color = Color3.fromRGB(200, 35, 55); MS.Thickness = 1.5
FBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local Hdr = Instance.new("Frame", Main); Hdr.Size = UDim2.new(1, 0, 0, 34); Hdr.BackgroundColor3 = Color3.fromRGB(19, 15, 18)
Instance.new("UICorner", Hdr).CornerRadius = UDim.new(0, 10)
local Ttl = Instance.new("TextLabel", Hdr); Ttl.Size = UDim2.new(1, -20, 1, 0); Ttl.Position = UDim2.fromOffset(14, 0)
Ttl.BackgroundTransparency = 1; Ttl.Text = "LENN HUB  <font color='#E62E45'>|  Attack on Titan: Revolution</font>"; Ttl.RichText = true
Ttl.TextColor3 = Color3.new(1, 1, 1); Ttl.Font = Enum.Font.GothamBold; Ttl.TextSize = 14; Ttl.TextXAlignment = Enum.TextXAlignment.Left

local Side = Instance.new("ScrollingFrame", Main)
Side.Size = UDim2.new(0, 118, 1, -42); Side.Position = UDim2.fromOffset(8, 38); Side.BackgroundColor3 = Color3.fromRGB(17, 17, 21)
Side.ScrollBarThickness = 2; Side.CanvasSize = UDim2.new(); Side.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 8)
Instance.new("UIListLayout", Side).Padding = UDim.new(0, 4)
local SP = Instance.new("UIPadding", Side); SP.PaddingTop = UDim.new(0, 5); SP.PaddingLeft = UDim.new(0, 5); SP.PaddingRight = UDim.new(0, 5)

local Holder = Instance.new("Frame", Main); Holder.Size = UDim2.new(1, -138, 1, -42); Holder.Position = UDim2.fromOffset(132, 38); Holder.BackgroundTransparency = 1
local Pages, Btns = {}, {}

local Lib = {}
function Lib:Tab(name)
    local B = Instance.new("TextButton", Side); B.Size = UDim2.new(1, 0, 0, 24); B.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
    B.Text = name; B.TextColor3 = Color3.fromRGB(175, 175, 185); B.Font = Enum.Font.GothamSemibold; B.TextSize = 11
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)

    local P = Instance.new("ScrollingFrame", Holder); P.Size = UDim2.new(1, 0, 1, 0); P.BackgroundTransparency = 1
    P.ScrollBarThickness = 2; P.ScrollBarImageColor3 = Color3.fromRGB(220, 35, 55); P.CanvasSize = UDim2.new(); P.AutomaticCanvasSize = Enum.AutomaticSize.Y; P.Visible = false

    local LCol = Instance.new("Frame", P); LCol.Size = UDim2.new(0.49, 0, 0, 0); LCol.AutomaticSize = Enum.AutomaticSize.Y; LCol.BackgroundTransparency = 1
    Instance.new("UIListLayout", LCol).Padding = UDim.new(0, 6)
    local RCol = Instance.new("Frame", P); RCol.Size = UDim2.new(0.49, 0, 0, 0); RCol.Position = UDim2.new(0.51, 0, 0, 0); RCol.AutomaticSize = Enum.AutomaticSize.Y; RCol.BackgroundTransparency = 1
    Instance.new("UIListLayout", RCol).Padding = UDim.new(0, 6)

    table.insert(Pages, P); table.insert(Btns, B)
    B.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        for _, b in ipairs(Btns) do b.BackgroundColor3 = Color3.fromRGB(24, 24, 29); b.TextColor3 = Color3.fromRGB(175, 175, 185) end
        P.Visible = true; B.BackgroundColor3 = Color3.fromRGB(210, 35, 55); B.TextColor3 = Color3.new(1, 1, 1)
    end)

    local function Group(parent, title)
        local Box = Instance.new("Frame", parent); Box.Size = UDim2.new(1, 0, 0, 0); Box.AutomaticSize = Enum.AutomaticSize.Y
        Box.BackgroundColor3 = Color3.fromRGB(18, 18, 23); Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 7)
        local BS = Instance.new("UIStroke", Box); BS.Color = Color3.fromRGB(45, 25, 30); BS.Thickness = 1
        Instance.new("UIListLayout", Box).Padding = UDim.new(0, 4)
        local BP = Instance.new("UIPadding", Box); BP.PaddingTop = UDim.new(0, 5); BP.PaddingBottom = UDim.new(0, 6); BP.PaddingLeft = UDim.new(0, 6); BP.PaddingRight = UDim.new(0, 6)

        local H = Instance.new("TextLabel", Box); H.Size = UDim2.new(1, 0, 0, 15); H.BackgroundTransparency = 1
        H.Text = string.upper(title); H.TextColor3 = Color3.fromRGB(235, 55, 75); H.Font = Enum.Font.GothamBold; H.TextSize = 10; H.TextXAlignment = Enum.TextXAlignment.Left

        local E = {}
        function E:Tog(t, k, cb)
            local R = Instance.new("TextButton", Box); R.Size = UDim2.new(1, 0, 0, 25); R.BackgroundColor3 = Color3.fromRGB(24, 24, 30); R.Text = ""
            Instance.new("UICorner", R).CornerRadius = UDim.new(0, 5)
            local L = Instance.new("TextLabel", R); L.Size = UDim2.new(1, -36, 1, 0); L.Position = UDim2.fromOffset(7, 0); L.BackgroundTransparency = 1
            L.Text = t; L.TextColor3 = Color3.fromRGB(225, 225, 230); L.Font = Enum.Font.Gotham; L.TextSize = 10; L.TextXAlignment = Enum.TextXAlignment.Left; L.TextTruncate = Enum.TextTruncate.AtEnd
            local Bx = Instance.new("Frame", R); Bx.Size = UDim2.fromOffset(26, 13); Bx.Position = UDim2.new(1, -31, 0.5, -6); Bx.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
            Instance.new("UICorner", Bx).CornerRadius = UDim.new(1, 0)
            local Dt = Instance.new("Frame", Bx); Dt.Size = UDim2.fromOffset(9, 9); Dt.Position = UDim2.fromOffset(2, 2); Dt.BackgroundColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", Dt).CornerRadius = UDim.new(1, 0)
            local st = false
            R.MouseButton1Click:Connect(function()
                st = not st; if k then genv.Config[k] = st end
                TS:Create(Bx, TweenInfo.new(0.15), {BackgroundColor3 = st and Color3.fromRGB(220, 35, 55) or Color3.fromRGB(45, 45, 52)}):Play()
                TS:Create(Dt, TweenInfo.new(0.15), {Position = st and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2)}):Play()
                if cb then cb(st) end
            end)
        end
        function E:Btn(t, cb)
            local Bn = Instance.new("TextButton", Box); Bn.Size = UDim2.new(1, 0, 0, 23); Bn.BackgroundColor3 = Color3.fromRGB(35, 20, 24); Bn.Text = t
            Bn.TextColor3 = Color3.fromRGB(255, 220, 225); Bn.Font = Enum.Font.GothamSemibold; Bn.TextSize = 10; Instance.new("UICorner", Bn).CornerRadius = UDim.new(0, 5)
            Bn.MouseButton1Click:Connect(function() if cb then cb() end end)
        end
        function E:Inp(ph, k)
            local Bx = Instance.new("TextBox", Box); Bx.Size = UDim2.new(1, 0, 0, 23); Bx.BackgroundColor3 = Color3.fromRGB(24, 24, 30); Bx.PlaceholderText = ph
            Bx.Text = ""; Bx.TextColor3 = Color3.new(1, 1, 1); Bx.Font = Enum.Font.Gotham; Bx.TextSize = 10; Bx.ClearTextOnFocus = false; Instance.new("UICorner", Bx).CornerRadius = UDim.new(0, 5)
            Bx.FocusLost:Connect(function() if k then genv.Config[k] = Bx.Text end end)
        end
        function E:Drp(t, opts, k)
            local i = 1; local Bn = Instance.new("TextButton", Box); Bn.Size = UDim2.new(1, 0, 0, 23); Bn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
            Bn.Text = " " .. t .. ": " .. opts; Bn.TextColor3 = Color3.fromRGB(225, 225, 230); Bn.Font = Enum.Font.Gotham; Bn.TextSize = 10; Bn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", Bn).CornerRadius = UDim.new(0, 5); if k then genv.Config[k] = opts end
            Bn.MouseButton1Click:Connect(function() i = (i % #opts) + 1; Bn.Text = " " .. t .. ": " .. opts[i]; if k then genv.Config[k] = opts[i] end end)
        end
        function E:Lbl(t)
            local L = Instance.new("TextLabel", Box); L.Size = UDim2.new(1, 0, 0, 18); L.BackgroundTransparency = 1; L.Text = t
            L.TextColor3 = Color3.fromRGB(190, 190, 200); L.Font = Enum.Font.Gotham; L.TextSize = 10; L.TextXAlignment = Enum.TextXAlignment.Left
            return L
        end
        return E
    end
    return { Left = function(t) return Group(LCol, t) end, Right = function(t) return Group(RCol, t) end }
end

function Lib:Init()
    if Pages then Pages.Visible = true end
    if Btns then Btns.BackgroundColor3 = Color3.fromRGB(210, 35, 55); Btns.TextColor3 = Color3.new(1, 1, 1) end
end
return Lib
