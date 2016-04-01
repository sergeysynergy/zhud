local function tooltipHandler()
    local realm, name
    --print(GameTooltip:NumLines())
    for i=1, GameTooltip:NumLines() do
        local line = _G["GameTooltipTextLeft"..i]
        local text = line:GetText()
        --print(text)
        if string.find(text, "Leader") then
            local i, j = string.find(text, "Leader: ")
            local slag = string.sub(text,j+1,string.len(text)-2)
            local len = string.len(slag)
            --print('slag > '..slag)
            local m,n = string.find(slag, '-')
            if m then
                realm = string.sub(slag, m+1)
                name = string.sub(slag, 1, m-1)
            else
                realm = GetRealmName()
                name = slag
            end
            local k,v = string.find(realm, '%u', 2)
            if k then
                realm = string.sub(realm, 1, k-1) .. '-' .. string.sub(realm, k)
            end
            --print('realm>',realm)
            zname = string.sub(name,11)
            --print(zname)
            --local name = string.sub(slag, 2, i-2)
            local link = 'https://eu.api.battle.net/wow/character/' .. realm .. '/' .. zname .. '?fields=pvp&locale=en_GB&apikey=maffghvxysjbf2epy5c5nzxtdwkbhmsz'
            --local link = 'https://eu.api.battle.net/wow/character/' .. name
            --print(realm..'/'..name)
            --print(link)
            --local link = tostring(realm..'/'..name)
            --SendChatMessage(realm, "SAY")
            SendChatMessage(link, "SAY")
            local tname = UnitName("target")
            --SendChatMessage(link, "WHISPER", nil, tname)
        end
    end
end


local LFGFrame_OnClick = function( self, button)
    --print(self:GetName())
    tooltipHandler()
end


for i = 1, 19 do
    local fd = _G["LFGListSearchPanelScrollFrameButton"..i]
    if fd ~= nil then
        fd:HookScript("OnClick", LFGFrame_OnClick)
        --fd:HookScript("OnEnter", LFGFrame_OnClick)
    end
end


local function tooltipMasterHandler()
    local realm, name
    local line = _G["GameTooltipTextLeft1"]
    local slag = line:GetText()
    local len = string.len(slag)
    local m,n = string.find(slag, '-')
    if m then
        realm = string.sub(slag, m+1)
        name = string.sub(slag, 1, m-1)
    else
        realm = GetRealmName()
        name = slag
    end
    local k,v = string.find(realm, '%u', 2)
    if k then
        realm = string.sub(realm, 1, k-1) .. '-' .. string.sub(realm, k)
    end
    if realm == 'ЧерныйШрам' then
        realm = 'Черный-Шрам'
    end
    local link = 'https://eu.api.battle.net/wow/character/' .. realm .. '/' .. name .. '?fields=pvp&locale=en_GB&apikey=maffghvxysjbf2epy5c5nzxtdwkbhmsz'
    SendChatMessage(link, "SAY")
    local tname = UnitName("target")
    --SendChatMessage(link, "WHISPER", nil, tname)
end


local LFGMasterOnClick = function( self, button)
    --print(self:GetName())
    if button == 'LeftButton' then
        tooltipMasterHandler()
    end
end


for i = 1, 9 do
    local fm = _G["LFGListApplicationViewerScrollFrameButton"..i].Member1
    if fm ~= nil then
        fm:HookScript("OnMouseDown", LFGMasterOnClick)
    end
end

