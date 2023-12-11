
if (GetLocale() == "zhCN") then
	BF_FINDING_MINING = "寻找矿物";
	BF_FINDING_HERBS = "寻找草药";
elseif (GetLocale() == "zhTW") then
	BF_FINDING_MINING = "尋找礦物";
	BF_FINDING_HERBS = "尋找草藥";
else
	BF_FINDING_MINING = "Find Minerals";
	BF_FINDING_HERBS = "Find Herbs";
end

local df_tracking_enabled,df_tracking_time,df_tracking_count,df_fmi,df_fmh

local function GetDualFindIndex()
	local df_fmi,df_fmh = nil,nil
	local count = GetNumTrackingTypes();
	for i = 1, count, 1 do
		local name = GetTrackingInfo(i);
		if (name == BF_FINDING_MINING) then
			df_fmi = i;
		elseif (name == BF_FINDING_HERBS) then
			df_fmh = i;
		end
	end
	return df_fmi,df_fmh
end

function BigFoot_ToggleDualFinding(checked)
	if (checked) then
		df_tracking_enabled = true;
	else
		df_tracking_enabled = false;
	end
	df_fmi,df_fmh = GetDualFindIndex()
end

function BigFoot_IsDualFidingEnabled()
	return df_tracking_enabled
end


local function __OnUpdate(self,__arg1)
	if (df_tracking_enabled) then
		if (not df_tracking_time) then
			df_tracking_time = 0;
		end

		df_tracking_time = df_tracking_time + __arg1;
		if (df_tracking_time > 3) and not UnitIsDead("player") then
			if not( df_fmi and df_fmh) then return end

			df_tracking_time = 0;
			local sound = GetCVar("Sound_EnableSFX")
			SetCVar("Sound_EnableSFX", "0");
			if (finding_mining) then
				local start, duration, enabled = GetSpellCooldown(BF_FINDING_MINING);
				local spell = UnitCastingInfo("player");
				local combat = UnitAffectingCombat("player");
				if (combat or spell or (start and duration and start > 0 and duration > 0)) then
				else
					SetTracking(df_fmi);
					finding_mining = false;
				end
			else
				local start, duration, enabled = GetSpellCooldown(BF_FINDING_HERBS);
				local spell = UnitCastingInfo("player");
				local combat = UnitAffectingCombat("player");
				if (combat or spell or (start and duration and start > 0 and duration > 0)) then
				else
					SetTracking(df_fmh);
					finding_mining = true;
				end
			end
			SetCVar("Sound_EnableSFX", sound);
		end
	end
end

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate",__OnUpdate)
