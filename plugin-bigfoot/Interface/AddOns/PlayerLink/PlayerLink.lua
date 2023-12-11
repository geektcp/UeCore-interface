local PlayerLink_3b370ebf3ed541e39961bc311976be8c = function()
end
PlayerLinkPopupButtons = {};
PlayerLink = {};
if (GetLocale() == "zhCN") then
    PlayerLinkPopupButtons["TELE"] = { text = "传送到玩家位置", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_FRIEND"] = { text = "加为好友", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["REMOVE_FRIEND"] = { text = "移除好友", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["SET_NOTE"] = { text = "设置备注", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["IGNORE"] = { text = "加入黑名单", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COMPLAIN"] = { text = "举报骚扰", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["WHO"] = { text = "查看玩家信息", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ARMORY"] = { text = "查看英雄榜", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COPY"] = { text = "复制玩家名字", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_GUILD"] = { text = "邀请公会", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["TITLE"] = { text = "玩家链接", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, isTitle = 1, };
    PLAYER_LINK_COPY_MESSAGE = "|cff00adef<玩家链接>|r 玩家<|cff00ff00%s|r>的名字已经被复制，你可以通过在输入框键入|cffffff00<ALT+上>|r来获取。";
    PLAYER_LINK_CLIENT_TIP = "|cff00adef<玩家链接>|r 你必须通过KK魔兽更新客户端启动游戏，才能查看英雄榜。";
elseif (GetLocale() == "zhTW") then
    PlayerLinkPopupButtons["TELE"] = { text = "传送到玩家位置", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_FRIEND"] = { text = "加為好友", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["REMOVE_FRIEND"] = { text = "移除好友", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["SET_NOTE"] = { text = "設置備註", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["IGNORE"] = { text = "加入黑名單", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COMPLAIN"] = { text = "舉報騷擾", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_GUILD"] = { text = "邀請公會", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ARMORY"] = { text = "查看英雄榜", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["WHO"] = { text = "查看玩家信息", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COPY"] = { text = "複製玩家名字", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["TITLE"] = { text = "玩家鏈接", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, isTitle = 1 };
    PLAYER_LINK_COPY_MESSAGE = "|cff00adef<玩家鏈結>|r 玩家<|cff00ff00%s|r>的名字已經被複製，你可以通過在輸入框鍵入|cffffff00<ALT+上>|r來獲取。";
    PLAYER_LINK_CLIENT_TIP = "|cff00adef<玩家連結>|r 你必須通過大腳更新用戶端啟動遊戲，才能查看英雄榜。";
else
    PlayerLinkPopupButtons["TELE"] = { text = "Tele Player", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_FRIEND"] = { text = "Add Friend", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["REMOVE_FRIEND"] = { text = "Remove Friend", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["SET_NOTE"] = { text = "Set Note", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["IGNORE"] = { text = IGNORE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COMPLAIN"] = { text = "Complain", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ADD_GUILD"] = { text = "Add Guild", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["ARMORY"] = { text = "View Armory", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["WHO"] = { text = "Player Dsetail", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["COPY"] = { text = "Name Copy", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
    PlayerLinkPopupButtons["TITLE"] = { text = "Player Link", func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, isTitle = 1, };
    PLAYER_LINK_COPY_MESSAGE = "|cff00adef<PlayerLink>|r The name of player <%s> has been logged, you can get it by pressing |cffffff00<ALT+Up>|r.";
    PLAYER_LINK_CLIENT_TIP = "|cff00adef<PlayerLink>|r To view armory, you mus run game via BigFoot Client.";
end
PlayerLinkPopupButtons["CANCEL"] = { text = CANCEL, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["TARGET"] = { text = TARGET, isSecure = 1, macro = "/targetexact %s" };
PlayerLinkPopupButtons["GUILD_PROMOTE"] = { text = GUILD_PROMOTE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["GUILD_LEAVE"] = { text = GUILD_LEAVE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["REPORT_SPAM"] = { text = REPORT_SPAM, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["WHISPER"] = { text = WHISPER, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["INVITE"] = { text = PARTY_INVITE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["RAID_LEADER"] = { text = SET_RAID_LEADER, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["RAID_PROMOTE"] = { text = SET_RAID_ASSISTANT, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["RAID_MAINTANK"] = { text = SET_MAIN_TANK, isSecure = 1, macro = "/mt %s", };
PlayerLinkPopupButtons["RAID_MAINASSIST"] = { text = SET_MAIN_ASSIST, isSecure = 1, macro = "/ma %s", };
PlayerLinkPopupButtons["LOOT_PROMOTE"] = { text = LOOT_PROMOTE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["RAID_DEMOTE"] = { text = DEMOTE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLinkPopupButtons["RAID_REMOVE"] = { text = REMOVE, func = PlayerLink_3b370ebf3ed541e39961bc311976be8c, };
PlayerLink["FRIEND"] = { "TELE", "WHISPER", "INVITE", "TARGET", "ADD_FRIEND", "REMOVE_FRIEND", "SET_NOTE", "WHO", "COPY", "ADD_GUILD", "GUILD_PROMOTE", "GUILD_LEAVE", "CANCEL" };
PlayerLink["RAID"] = { "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "CANCEL" };
local PlayerLink_6657fdc1899c35bd51c6456c68f2e35f = 0;
local PlayerLink_5194b26eb01eaa84cf889814c78708e6 = nil;
local PlayerLink_fd9dd5c274fa1dc245d34ae070f7e65b = nil;
local PlayerLink_1e21bf09480ac08a0f6dbe8c4d7f00d1 = nil;
local PlayerLink_22a7405c1aecfe352eeedee5430d679d = 0;
local PlayerLink_c2fd2fc4e9d2bb89690ad4b03bfa8bcc = true;
function PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa)
    if (type(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa) ~= "table") then
        return ;
    end
    local PlayerLink_de474c4a74251c7e8e966e2325faad9c, PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5;
    if (PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.isSecure) then
        if (UnitAffectingCombat("player") or PlayerLink_1e21bf09480ac08a0f6dbe8c4d7f00d1) then
            return
        end
        PlayerLink_de474c4a74251c7e8e966e2325faad9c = "PlayerLinkSecureButton" .. PlayerLink_6657fdc1899c35bd51c6456c68f2e35f;
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal(PlayerLink_de474c4a74251c7e8e966e2325faad9c) or CreateFrame("Button", PlayerLink_de474c4a74251c7e8e966e2325faad9c, PlayerLinkList, "PlayerLinkButtonTemplate, SecureActionButtonTemplate");
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("*type1", "macro");
    else
        PlayerLink_de474c4a74251c7e8e966e2325faad9c = "PlayerLinkButton" .. PlayerLink_6657fdc1899c35bd51c6456c68f2e35f;
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal(PlayerLink_de474c4a74251c7e8e966e2325faad9c) or CreateFrame("Button", PlayerLink_de474c4a74251c7e8e966e2325faad9c, PlayerLinkList, "PlayerLinkButtonTemplate");
    end
    PlayerLink_6657fdc1899c35bd51c6456c68f2e35f = PlayerLink_6657fdc1899c35bd51c6456c68f2e35f + 1;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:RegisterForClicks("AnyDown");
    local PlayerLink_e151eac943d92953d454467f268750b7 = 1.0;
    if (GetCVar("useUiScale") == "1") then
        PlayerLink_e151eac943d92953d454467f268750b7 = tonumber(GetCVar("uiscale"));
    end
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetID(PlayerLink_6657fdc1899c35bd51c6456c68f2e35f);
    local PlayerLink_ad99aba3ccefb4bbbc2274e93d78bd34 = getglobal(PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:GetName() .. "NormalText");
    PlayerLink_ad99aba3ccefb4bbbc2274e93d78bd34:ClearAllPoints();
    PlayerLink_ad99aba3ccefb4bbbc2274e93d78bd34:SetPoint("LEFT", PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5, "LEFT", 0, 0);
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetNormalFontObject(GameFontHighlightSmallLeft);
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetHighlightFontObject(GameFontHighlightSmallLeft);
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.func = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.func;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.onshow = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.onshow;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.text = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.text;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.arg1 = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg1;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.arg2 = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg2;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.value = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.value;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.tooltipTitle = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.tooltipTitle;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.tooltipText = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.tooltipText;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.isTitle = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.isTitle;
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.macro = PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.macro;
    if (PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.text) then
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetText(PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.text);
    else
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetText("");
    end
    if (PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.isTitle) then
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetDisabledFontObject(GameFontNormalSmallLeft);
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Disable();
    else
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetDisabledFontObject(GameFontDisableSmallLeft);
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Enable();
    end
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:ClearAllPoints();
    if (PlayerLink_5194b26eb01eaa84cf889814c78708e6) then
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetPoint("TOPLEFT", PlayerLink_5194b26eb01eaa84cf889814c78708e6, "BOTTOMLEFT", 0, 0);
    else
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetPoint("TOPLEFT", PlayerLinkList, "TOPLEFT", 14, -15);
    end
    PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Show();
    PlayerLink_5194b26eb01eaa84cf889814c78708e6 = PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5;
end
local function PlayerLink_8d991efc18cbd4ffc96fba8c9ebd51ac()
    if (PlayerLink_5194b26eb01eaa84cf889814c78708e6 and PlayerLink_fd9dd5c274fa1dc245d34ae070f7e65b) then
        local PlayerLink_d867bec337da2376b766f2e8b64f6c76 = DropDownList1:GetHeight();
        local PlayerLink_1df9dbe4b793594e43d35dbec9cdedd1 = DropDownList1:GetWidth();
        if (PlayerLink_1df9dbe4b793594e43d35dbec9cdedd1 > 126) then
            PlayerLinkList:SetWidth(PlayerLink_1df9dbe4b793594e43d35dbec9cdedd1);
        else
            PlayerLinkList:SetWidth(126);
            DropDownList1:SetWidth(126);
        end
        local PlayerLink_b254e387cf58e982ba24fcb3e8a63995, PlayerLink_a0f453fd098c0b0fda780f69cda6ffbf = GetCursorPosition();
        local PlayerLink_6230e23f021dec637edabaa368556c06 = UIParent:GetScale();
        PlayerLink_b254e387cf58e982ba24fcb3e8a63995, PlayerLink_a0f453fd098c0b0fda780f69cda6ffbf = PlayerLink_b254e387cf58e982ba24fcb3e8a63995 / PlayerLink_6230e23f021dec637edabaa368556c06, PlayerLink_a0f453fd098c0b0fda780f69cda6ffbf / PlayerLink_6230e23f021dec637edabaa368556c06;
        PlayerLinkList:ClearAllPoints();
        PlayerLinkList:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", PlayerLink_b254e387cf58e982ba24fcb3e8a63995, PlayerLink_a0f453fd098c0b0fda780f69cda6ffbf);
        PlayerLinkList:SetHeight(16 * PlayerLink_6657fdc1899c35bd51c6456c68f2e35f + 30);
        PlayerLink_StartCount();
        PlayerLinkList:Show();
    end
    if (not PlayerLink_1e21bf09480ac08a0f6dbe8c4d7f00d1) then
        CloseDropDownMenus();
    end
end
local function PlayerLink_2e0d5572b169bb7c352ae79c67a3f42e(PlayerLink_8983c60d66c8593ec7165ea9dbedb584, PlayerLink_b0011e6b4adaadef5bf2c10729e0d080, PlayerLink_ad6677e70fc056ed190a0f8febb76e72)
    PlayerLink_Hide();
    PlayerLinkList.time = 3;
    for PlayerLink_63a9ce6f1eeac72ef41293b7d0303335, PlayerLink_8d0644c92128c1ff68223fd74ba63b56 in ipairs(PlayerLink["FRIEND"]) do
        local PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa = PlayerLinkPopupButtons[PlayerLink_8d0644c92128c1ff68223fd74ba63b56];
        PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg1 = PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
        PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg2 = PlayerLink_ad6677e70fc056ed190a0f8febb76e72;
        if (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "ADD_GUILD") then
            if (CanGuildInvite()) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "GUILD_PROMOTE") then
            if (IsGuildLeader() and PlayerLink_8983c60d66c8593ec7165ea9dbedb584 ~= UnitName("player") and GuildFrame:IsShown()) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "GUILD_LEAVE") then
            if (PlayerLink_8983c60d66c8593ec7165ea9dbedb584 == UnitName("player") and GuildFrame:IsShown()) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "REPORT_SPAM") then
            if (PlayerLink_ad6677e70fc056ed190a0f8febb76e72 and CanComplainChat(PlayerLink_ad6677e70fc056ed190a0f8febb76e72)) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        else
            PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
        end
    end
    PlayerLink_8d991efc18cbd4ffc96fba8c9ebd51ac();
end
local function PlayerLink_697ac1ed1e9425244619bdd3f84a9ab6(self)
    PlayerLink_Hide();
    PlayerLinkList.time = 3;
    for PlayerLink_63a9ce6f1eeac72ef41293b7d0303335, PlayerLink_8d0644c92128c1ff68223fd74ba63b56 in ipairs(PlayerLink["RAID"]) do
        local PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa = PlayerLinkPopupButtons[PlayerLink_8d0644c92128c1ff68223fd74ba63b56];
        PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg1 = self.name;
        PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa.arg2 = self.unit;
        if (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_LEADER") then
            if (IsPartyLeader() and UnitIsPartyLeader(self.unit) and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_PROMOTE") then
            if (IsPartyLeader() and not UnitIsRaidOfficer(self.unit)) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_MAINTANK") then
            if (IsPartyLeader() and IsRaidOfficer() and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_MAINASSIST") then
            if (IsPartyLeader() and IsRaidOfficer() and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_DEMOTE") then
            if (IsPartyLeader() and IsRaidOfficer() and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "RAID_REMOVE") then
            if (IsPartyLeader() and IsRaidOfficer() and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        elseif (PlayerLink_8d0644c92128c1ff68223fd74ba63b56 == "LOOT_PROMOTE") then
            if (IsPartyLeader() and IsRaidOfficer() and self.name) then
                PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
            end
        else
            PlayerLink_AddButton(PlayerLink_a44ecbf575d7f2eca081a0592e8d84fa);
        end
    end
    PlayerLink_8d991efc18cbd4ffc96fba8c9ebd51ac();
end
function PlayerLink_Hide()
    local PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5, PlayerLink_57902cfaee33348e476f69e1e2776af7;
    for PlayerLink_e914904fab9d05d3f54d52bfc31a0f3f = 1, PlayerLink_6657fdc1899c35bd51c6456c68f2e35f do
        PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 = getglobal("PlayerLinkButton" .. PlayerLink_e914904fab9d05d3f54d52bfc31a0f3f)
        PlayerLink_57902cfaee33348e476f69e1e2776af7 = getglobal("PlayerLinkSecureButton" .. PlayerLink_e914904fab9d05d3f54d52bfc31a0f3f);
        if (PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5) then
            PlayerLink_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:Hide()
        end
        if (PlayerLink_57902cfaee33348e476f69e1e2776af7) then
            PlayerLink_57902cfaee33348e476f69e1e2776af7:Hide()
        end
    end
    PlayerLink_6657fdc1899c35bd51c6456c68f2e35f = 0;
    PlayerLink_5194b26eb01eaa84cf889814c78708e6 = nil;
    PlayerLinkList:Hide();
    PlayerLink_c2fd2fc4e9d2bb89690ad4b03bfa8bcc = true;
end
local RaidUI_Eventer = BLibrary("BEvent");
RaidUI_Eventer:Init { PlayerLink_8983c60d66c8593ec7165ea9dbedb584 = "Blizzard_RaidUI", func = function()
    hooksecurefunc("RaidGroupButton_ShowMenu", PlayerLink_697ac1ed1e9425244619bdd3f84a9ab6);
end };
function PlayerLinkPopupButtons.ADD_FRIEND.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    AddFriend(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.SET_NOTE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    FriendsFrame.NotesID = PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
    StaticPopup_Show("SET_FRIENDNOTE", PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
    PlaySound("igCharacterInfoClose");
end
function PlayerLinkPopupButtons.REMOVE_FRIEND.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    RemoveFriend(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.WHO.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    SendWho("n-" .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.COPY.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    if (ChatFrameEditBox:IsVisible()) then
        ChatFrameEditBox:Insert(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
    else
        ChatFrameEditBox:AddHistoryLine(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
        BigFoot_Print(string.format(PLAYER_LINK_COPY_MESSAGE, PlayerLink_8983c60d66c8593ec7165ea9dbedb584));
    end
end
function PlayerLinkPopupButtons.TELE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    SendChatMessage(".goto " .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
end
function PlayerLinkPopupButtons.ARMORY.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    local PlayerLink_86f176ad313c87e2e12fa1a570d9d226;
    local PlayerLink_2e2dc31c924679d8084c8b90a57309c9 = GetCVar("realmList");
    if (string.find(PlayerLink_2e2dc31c924679d8084c8b90a57309c9, "wowchina")) then
        PlayerLink_86f176ad313c87e2e12fa1a570d9d226 = "http://cn.wowarmory.com/character-sheet.xml?r=" .. GetCVar("realmName") .. "&n=" .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
    elseif (string.find(PlayerLink_2e2dc31c924679d8084c8b90a57309c9, "tw.")) then
        PlayerLink_86f176ad313c87e2e12fa1a570d9d226 = "http://tw.wowarmory.com/character-sheet.xml?r=" .. GetCVar("realmName") .. "&n=" .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
    elseif (string.find(PlayerLink_2e2dc31c924679d8084c8b90a57309c9, "eu.")) then
        PlayerLink_86f176ad313c87e2e12fa1a570d9d226 = "http://eu.wowarmory.com/character-sheet.xml?r=" .. GetCVar("realmName") .. "&n=" .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
    else
        PlayerLink_86f176ad313c87e2e12fa1a570d9d226 = "http://www.wowarmory.com/character-sheet.xml?r=" .. GetCVar("realmName") .. "&n=" .. PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
    end
    if (BigFoot_IsClientRunning()) then
        BigFoot_LaunchURL(PlayerLinkPopupButtons["ARMORY"].text, PlayerLink_86f176ad313c87e2e12fa1a570d9d226);
    else
        BigFoot_Print(PLAYER_LINK_CLIENT_TIP);
    end
end
function PlayerLinkPopupButtons.ADD_GUILD.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    GuildInvite(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.IGNORE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    AddOrDelIgnore(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.COMPLAIN.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    ComplainChat(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.REPORT_SPAM.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584, PlayerLink_ad6677e70fc056ed190a0f8febb76e72)
    local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
    if (dialog) then
        dialog.data = PlayerLink_ad6677e70fc056ed190a0f8febb76e72;
    end
end
function PlayerLinkPopupButtons.GUILD_PROMOTE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    local dialog = StaticPopup_Show("CONFIRM_GUILD_PROMOTE", PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
    dialog.data = PlayerLink_8983c60d66c8593ec7165ea9dbedb584;
end
function PlayerLinkPopupButtons.GUILD_LEAVE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    StaticPopup_Show("CONFIRM_GUILD_LEAVE", GetGuildInfo("player"));
end
function PlayerLinkPopupButtons.CANCEL.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
end
function PlayerLinkPopupButtons.WHISPER.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    ChatFrame_SendTell(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.INVITE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    InviteUnit(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLinkPopupButtons.RAID_LEADER.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    PromoteToLeader(PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
end
function PlayerLinkPopupButtons.RAID_PROMOTE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    PromoteToAssistant(PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
end
function PlayerLinkPopupButtons.LOOT_PROMOTE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    SetLootMethod("master", PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
end
function PlayerLinkPopupButtons.RAID_DEMOTE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584, unit)
    if (IsPartyLeader() and UnitIsRaidOfficer(unit)) then
        DemoteAssistant(PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
    end
    if (GetPartyAssignment("MAINTANK", PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1)) then
        ClearPartyAssignment("MAINTANK", PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
    elseif (GetPartyAssignment("MAINASSIST", PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1)) then
        ClearPartyAssignment("MAINASSIST", PlayerLink_8983c60d66c8593ec7165ea9dbedb584, 1);
    end
end
function PlayerLinkPopupButtons.RAID_REMOVE.func(arg1, PlayerLink_8983c60d66c8593ec7165ea9dbedb584)
    UninviteUnit(PlayerLink_8983c60d66c8593ec7165ea9dbedb584);
end
function PlayerLink_StartCount()
    PlayerLink_22a7405c1aecfe352eeedee5430d679d = 3;
    PlayerLink_c2fd2fc4e9d2bb89690ad4b03bfa8bcc = nil;
end
function PlayerLink_StopCount()
    PlayerLink_22a7405c1aecfe352eeedee5430d679d = 0;
    PlayerLink_c2fd2fc4e9d2bb89690ad4b03bfa8bcc = true;
end
local PlayerLink_Eventer = BLibrary("BEvent");
local frame = CreateFrame("Frame");
frame:Show();
frame:SetScript("OnUpdate", function(self, arg1)
    if (PlayerLink_c2fd2fc4e9d2bb89690ad4b03bfa8bcc) then
        return ;
    end
    PlayerLinkList.time = PlayerLinkList.time - arg1;
    if (PlayerLinkList.time <= 0) then
        PlayerLink_Hide();
    end
end);
function PlayerLink_Eventer.PLAYER_REGEN_ENABLED()
    PlayerLink_1e21bf09480ac08a0f6dbe8c4d7f00d1 = nil;
end
function PlayerLink_Eventer.PLAYER_REGEN_DISABLED()
    PlayerLink_1e21bf09480ac08a0f6dbe8c4d7f00d1 = 1;
    if (PlayerLinkList:IsShown()) then
        PlayerLink_Hide();
    end
end
function PlayerLink_Toggle(enable)
    if (enable) then
        PlayerLink_fd9dd5c274fa1dc245d34ae070f7e65b = true;
        PlayerLink_Eventer:RegisterEvent("PLAYER_REGEN_ENABLED");
        PlayerLink_Eventer:RegisterEvent("PLAYER_REGEN_DISABLED");
        PlayerLinkList:SetClampedToScreen(1);
    else
        PlayerLink_fd9dd5c274fa1dc245d34ae070f7e65b = nil;
        PlayerLink_Eventer:UnregisterEvent("PLAYER_REGEN_DISABLED")
        PlayerLink_Hide();
    end
end
PlayerLink_Eventer:Init { name = "PlayerLink", func = function()
    hooksecurefunc("FriendsFrame_ShowDropdown", PlayerLink_2e0d5572b169bb7c352ae79c67a3f42e);
end };
tinsert(UISpecialFrames, "PlayerLinkList");
