local gsub = string.gsub
local gmatch = string.gmatch
local CreateFrame = CreateFrame

local pattern1 = ERR_FRIEND_ONLINE_SS:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");
local pattern2 = ERR_FRIEND_OFFLINE_S:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");

function BNGetFriendInfoByID(name)
	return nil, name, "";
end

local function BNToastFrame_OnClick(self, btn, ...)
	local toastType = BNToastFrame.toastType;
	local toastData = BNToastFrame.toastData;
	local presenceID, givenName, surname = BNGetFriendInfoByID(toastData);
	if(btn == "LeftButton") then
		BNToastFrame:Hide();
		DropDownList1:Hide();
		if(toastType == 1) then
			ChatFrame_SendTell(givenName);
		end
	elseif(btn == "RightButton") then
		local name, level, class, area, connected = GetFriendInfo(givenName);
		if(name) then
			PlaySound("igMainMenuOptionCheckBoxOn");
			FriendsFrame_ShowDropdown(name, connected, nil, nil, nil, 1);
		end
	end
end
BNToastFrameClickFrame:RegisterForClicks("AnyUp", "AnyDown");
BNToastFrameClickFrame:SetScript("OnClick", BNToastFrame_OnClick);

local BNetFrame = CreateFrame("Frame");
BNetFrame:SetScript("OnEvent", function(self, event, arg1, ...)
	local name = arg1:gmatch(pattern1)();
	if(name) then
		BNToastFrame_AddToast(1, name);
		return;
	end
	name = arg1:gmatch(pattern2)();
	if(not name) then return; end
	BNToastFrame_AddToast(2, name);
end);
BNetFrame:RegisterEvent("CHAT_MSG_SYSTEM");

local function filter(self, event, arg1, ...)
	local name = arg1:gmatch(pattern1)() or arg1:gmatch(pattern2)();
	if(name) then
		return true;
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filter);
