-- Перемещение основных фреймов
local f = CreateFrame("Frame")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("PLAYER_FOCUS_CHANGED")
f:RegisterEvent("UNIT_FACTION")

f:SetScript("OnEvent", function(self, event)
    if PlayerFrame:IsShown() then
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 0)
        PlayerFrame:SetUserPlaced(false)
        PlayerFrame:SetClampedToScreen(false)
        PlayerFrame_SetLocked(true)

        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 330, -150)
        TargetFrame:SetUserPlaced(false)
        TargetFrame:SetClampedToScreen(false)
        TargetFrame_SetLocked(true)

        FocusFrame:ClearAllPoints()
        FocusFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 330, -505)
        FocusFrame:SetUserPlaced(false)
        FocusFrame:SetClampedToScreen(false)
    end
end)
-- /Перемещение основных фреймов


-- Visible buff on frame macro
local indicators = {} 
local buffs = {} 
local_, class = UnitClass("player"); 

if ( class == "DRUID" ) then 
buffs = {
    ["Mark of the Wild"] = true,
    ["Знак дикой природы"] = true,
} 
end 
if (class == "PRIEST" ) then 
buffs = {
    ["Power Word: Fortitude"] = true,
    ["Слово силы: Стойкость"] = true,
} 
end 
if (class == "MAGE" ) then 
buffs = {["Arcane Brilliance"] = true} 
end 
if (class == "MONK" ) then 
buffs = { 
["Legacy of the White Tiger"] = true, 
["Legacy of the Emperor"] = true 
} 
end 
if (class == "DEATHKNIGHT" ) then 
buffs = {["Horn of Winter"] = true} 
end 
if (class == "PALADIN" ) then 
buffs = { 
["Blessing of Kings"] = true, 
["Blessing of Might"] = true 
} 
end 
if (class == "WARLOCK" ) then 
buffs = {["Dark Intent"] = true} 
end 
if (class == "WARRIOR" ) then 
buffs = { 
["Battle Shout"] = true, 
["Commanding Shout"] = true 
} 
end 


local function getIndicator(frame) 
local indicator = indicators[frame:GetName()] 
if not indicator then 
indicator = CreateFrame("Button", nil, frame, "CompactAuraTemplate") 
indicator:ClearAllPoints() 
indicator:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -2) 
indicator:SetSize(22, 22) 
indicator:SetAlpha(0.6) 
indicators[frame:GetName()] = indicator 
end 
return indicator 
end 

local function updateBuffs(frame) 
if not frame:IsVisible() then return end 

local indicator = getIndicator(frame) 
local buffName = nil 
for i = 1, 40 do 
local _, _, _, _, _, d, _, ut, _, sc, s, c = UnitBuff(frame.displayedUnit, i); 
buffName = UnitBuff(frame.displayedUnit, i); 
if not buffName then break end 
if buffs[buffName] and ( ut == "player" or ut == "pet" ) then 
indicator:SetSize(frame.buffFrames[1]:GetSize()) -- scale 
CompactUnitFrame_UtilSetBuff(indicator, frame.displayedUnit, i, nil); 
return 
end 
end 
indicator:Hide() 
end 
hooksecurefunc("CompactUnitFrame_UpdateBuffs", updateBuffs)
-- /Visible buff on frame macro


-- Class colored frames
local function colour(statusbar, unit)
        local _, class, c
        if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
                _, class = UnitClass(unit)
                c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
                statusbar:SetStatusBarColor(c.r, c.g, c.b)
             
        end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
        colour(self, self.unit)
end)

local frame = CreateFrame("FRAME")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")

local function eventHandler(self, event, ...)
    if UnitIsPlayer("target") then
        c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
        TargetFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
    end
    if UnitIsPlayer("focus") then
        c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
        FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
    end
    if PlayerFrame:IsShown() and not PlayerFrame.bg then
        c = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
        bg=PlayerFrame:CreateTexture()
        bg:SetPoint("TOPLEFT",PlayerFrameBackground)
        bg:SetPoint("BOTTOMRIGHT",PlayerFrameBackground,0,22)
        bg:SetTexture(TargetFrameNameBackground:GetTexture())
        bg:SetVertexColor(c.r,c.g,c.b)
        PlayerFrame.bg=true
    end
end

frame:SetScript("OnEvent", eventHandler)

for _, BarTextures in pairs({TargetFrameNameBackground, FocusFrameNameBackground}) do
    BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
end
-- /Class colored frames
