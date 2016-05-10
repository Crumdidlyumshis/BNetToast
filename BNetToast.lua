local pattern1 = ERR_FRIEND_ONLINE_SS:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");
local pattern2 = ERR_FRIEND_OFFLINE_S:gsub("%%s", "(%.+)"):gsub("%[", "%%["):gsub("%]","%%]");

local function BNToastShow()
	local topLine = BNToastFrameTopLine;
	local bottomLine = BNToastFrameBottomLine;
	BNToastFrameIconTexture:SetTexCoord(0, 0.25, 0.5, 1);
	topLine:Show();
	topLine:SetTextColor(FRIENDS_BNET_NAME_COLOR.r, FRIENDS_BNET_NAME_COLOR.g, FRIENDS_BNET_NAME_COLOR.b);
	bottomLine:Show();
	bottomLine:SetTextColor(FRIENDS_GRAY_COLOR.r, FRIENDS_GRAY_COLOR.g, FRIENDS_GRAY_COLOR.b);
	BNToastFrameDoubleLine:Hide();
	local frame = BNToastFrame;
	frame:Show();
	PlaySound(18019);
	frame.animIn:Play();
	BNToastFrameGlowFrame.glow.animIn:Play();
	frame.waitAndAnimOut:Stop();
	if(frame:IsMouseOver()) then
		frame.waitAndAnimOut.animOut:SetStartDelay(1);
	else
		frame.waitAndAnimOut.animOut:SetStartDelay(frame.duration);
		frame.waitAndAnimOut:Play();
	end
end

local test = CreateFrame("Frame");
test:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local name = arg1:gmatch(pattern1)();
	if(name) then
		BNToastShow();
		BNToastFrameTopLine:SetFormattedText(BATTLENET_NAME_FORMAT, name, "");
		BNToastFrameBottomLine:SetText(BN_TOAST_ONLINE);
		return;
	end
	name = arg1:gmatch(pattern2)();
	if(not name) then return; end
	BNToastShow();
	BNToastFrameTopLine:SetFormattedText(BATTLENET_NAME_FORMAT, name, "");
	BNToastFrameBottomLine:SetText(BN_TOAST_OFFLINE);
end);
test:RegisterEvent("CHAT_MSG_SYSTEM");
