local gsub = string.gsub
local gmatch = string.gmatch
local CreateFrame = CreateFrame

local pattern1 = ERR_FRIEND_ONLINE_SS:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");
local pattern2 = ERR_FRIEND_OFFLINE_S:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");

function BNGetFriendInfoByID(name)
    return nil, name, "";
end

local test = CreateFrame("Frame");
test:SetScript("OnEvent", function(self, event, arg1, ...)
    local name = arg1:gmatch(pattern1)();
    if(name) then
        BNToastFrame_AddToast(1, name);
        BNToastFrameClickFrame:SetScript("OnClick", function(self, btn)
            ChatFrame1EditBox:SetAttribute("chatType", "WHISPER");
            ChatFrame1EditBox:SetAttribute("tellTarget", name);
            ChatEdit_ActivateChat(ChatFrame1EditBox);
        end);
        return;
    end
    name = arg1:gmatch(pattern2)();
    if(not name) then return; end
    BNToastFrame_AddToast(2, name);
end);
test:RegisterEvent("CHAT_MSG_SYSTEM");

local function filter(self, event, arg1, ...)
    local name = arg1:gmatch(pattern1)() or arg1:gmatch(pattern2)();
    if(name) then
        return true;
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filter);
