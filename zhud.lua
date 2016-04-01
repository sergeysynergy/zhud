function rPrint(s, l, i) -- recursive Print (structure, limit, indent)
    l = (l) or 100; i = i or "";    -- default item limit, indent string
    if (l<1) then print "ERROR: Item limit reached."; return l-1 end;
    local ts = type(s);
    if (ts ~= "table") then print (i,ts,s); return l-1 end
    print (i,ts);           -- print "table"
    for k,v in pairs(s) do  -- print "[KEY] VALUE"
        l = rPrint(v, l, i.."\t["..tostring(k).."]");
        if (l < 0) then break end
    end
    return l
end 


local BackdropLayout = { bgFile = "Interface\\ChatFrame\\ChatFrameBackground", insets = { left = 0, right = 0, top = 0, bottom = 0 } }

-- Debug frame
---------------------------------------------------------------------------------------
local Debug = CreateFrame("Frame",nil,UIParent)
Debug:SetFrameStrata("BACKGROUND")
Debug:SetSize(600, 100)
Debug:SetBackdrop(BackdropLayout)
Debug:SetBackdropColor(0, 0, 0, .8)
Debug:SetClampedToScreen(true)
Debug:EnableMouse(true)
Debug:SetMovable(true)
Debug:RegisterForDrag("LeftButton")

--[[
Debug.Title = Debug:CreateFontString(nil, "BACKGROUND")
Debug.Title:SetFontObject("GameFontHighlight")
Debug.Title:SetText(" (Debug frame)")
Debug.Title:SetPoint("TOP", 0, 10)
--]]

local ztext = "Debug: "
Debug.Text = Debug:CreateFontString(nil, "BACKGROUND")
Debug.Text:SetFontObject("GameFontHighlight")
Debug.Text:SetText(ztext)
--Debug.Text:SetPoint("LEFT",  0, -10)
Debug.Text:SetAllPoints(true)
Debug.Text:SetJustifyH("LEFT")
Debug.Text:SetJustifyV("TOP")

Debug:SetPoint("TOP",0,20)
Debug:Hide()
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

-- f1 frame
---------------------------------------------------------------------------------------
local f1 = CreateFrame("Frame",nil,UIParent)
f1:SetFrameStrata("BACKGROUND")
f1:SetSize(20,20)
f1:SetBackdrop(BackdropLayout)
f1:SetBackdropColor(0, 0, 0, .8)
f1:SetClampedToScreen(true)
f1:EnableMouse(true)
f1:SetMovable(true)
f1:RegisterForDrag("LeftButton")

--[[
local f1Texture = f1:CreateTexture(nil,"BACKGROUND")
f1Texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
f1Texture:SetAllPoints(f1)

f1:SetScript("OnClick", function(self, arg1)
    print(arg1)
end)
f1:Click("foo bar") -- will print "foo bar" in the chat frame.
f1:Click("blah blah") -- will print "blah blah" in the chat frame.
--]]
f1:SetPoint("LEFT",0,0)
f1:Hide()
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

--LFGListFrame
--LFGListSearchPanelScrollFrameButton1.DataDisplay
LFGListSearchPanelScrollFrameButton1:Hide()


local b1 = CreateFrame("Button")
b1:SetSize(20,20)
b1:SetPoint("TOPLEFT",0,0)
b1:SetBackdrop(BackdropLayout)
b1:SetBackdropColor(0, 0, 0, .8)
b1:SetScript("OnClick", function(self, arg1)
    print(arg1)
end)
--b1:Click("blah blah") -- will print "blah blah" in the chat frame.
--b1:Hide()


local function ZInfo(self, button, down)
    print('info:')
    --NotifyInspect("target")
    --local data = GetInspectArenaTeamData()
    --print('data'..data)
end
--PlayerFrame:HookScript("OnClick", ZInfo)

for k,v in pairs(_G) do
    if string.find(k, "GameTooltip") then
        --print(k)
    end
end

local function EnumerateTooltipLines_helper(...)
    for i = 1, select("#", ...) do
        local region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText() -- string or nil
            if text then
                print(text)
            end
        end
    end
end

function EnumerateTooltipLines(tooltip) -- good for script handlers that pass the tooltip as the first argument.
    EnumerateTooltipLines_helper(tooltip:GetRegions())
end


local gt = _G["GameTooltip"]
local function gtEventHandler(self)
   --print(' Local Event:')
   --tooltipHandler()
   EnumerateTooltipLines(self)
   --local text = _G[self:GetName().."Text"]
   --local line = _G[self:GetName().."HeaderText"]
   --local text = line:GetText() or ""
   --local text = self:GetHeight()
   --print(line)
   --self:SetText(getglobal(self:GetName().."Text"):GetText())
   --rPrint(_G["GameTooltipText"])
   --text = _G["GameTooltipText"]
   --print(text)
end

--gt:HookScript("OnShow", gtEventHandler)



--[[
function ParseGUID(guid)
   local first3 = tonumber("0x"..strsub(guid, 3,5))
   local unitType = bit.band(first3,0x00f)

   if (unitType == 0x000) then
      print("Player, ID #", strsub(guid,6))
   elseif (unitType == 0x003) then
      local creatureID = tonumber("0x"..strsub(guid,7,10))
      local spawnCounter = tonumber("0x"..strsub(guid,11))
      print("NPC, ID #",creatureID,"spawn #",spawnCounter)
   elseif (unitType == 0x004) then
      local petID = tonumber("0x"..strsub(guid,7,10))
      local spawnCounter = tonumber("0x"..strsub(guid,11))
      print("Pet, ID #",petID,"spawn #",spawnCounter)
   elseif (unitType == 0x005) then
      local creatureID = tonumber("0x"..strsub(guid,7,10))
      local spawnCounter = tonumber("0x"..strsub(guid,11))
      print("Vehicle, ID #",creatureID,"spawn #",spawnCounter)
   end
end


local http=require'socket.http'
body,c,l,h = http.request('http://w3.impa.br/~diego/software/luasocket/http.html')
print('status line',l)
print('body',body)
]]

function getCurrentRate(link)
end
--getCurrentRate('http://eu.battle.net/wow/en/character/sylvanas/Parisgiana/advanced')

