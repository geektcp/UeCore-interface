local charMapping={
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九",
	"十",
	"十一",
	"十二",
	"十三",
	"十四",
	"十五",
	"十六",
	"十七",
	"十八",
	"十九",
	"二十",	
}

local AKchannelTable ={
	["一区一组"] ={
		Alliance = {
			name = "无影联盟战场国际频道",
			akID = 200,
		}
	},
	["一区八组"] = {
		Horde = {
			name = "6688部落战场同盟",
			akID = 6688,
		}
	},
	["五区十组"] = {
		Horde ={
			name = "国际联盟奥山战团",
			akID = 288,
		}
	},
}

if (GetLocale() == "zhCN") then
	MOD_AKAD = {"战场语音", "zhanchangyuyin",2};
	MOD_AKAD_TEXT1 = "本组战场语音交流频道如下:";
	MOD_AKAD_FRAMETEXT1 = "战场组:  %s  \n\n地址:  AK语音\n\n频道号:  %s  \n\n名称:  %s\n\n阵营:  %s";
	MOD_AKAD_FRAMETEXT2 = "暂无战场团登记,如欲登记\n请联系akgh@178.com";
	MOD_AKAD_FOOTER = "AK语音下载地址: ak.178.com";
elseif (GetLocale() == "zhTW") then
	MOD_AKAD = {"战场语音", "zhanchangyuyin",2};
	MOD_AKAD_TEXT1 = "本组战场语音交流频道如下:";
	MOD_AKAD_FRAMETEXT1 = "战场组: %s  \n地址: AK语音\n频道号:%s  \n名称:%s\n阵营:%s";
	MOD_AKAD_FRAMETEXT2 = "暂无战场团登记,如欲登记\n请联系akgh@178.com";
	MOD_AKAD_FOOTER = "AK语音下载地址: ak.178.com";
else
	MOD_AKAD = ""
	MOD_AKAD_TEXT1 = "";
	MOD_AKAD_FRAMETEXT1 = "";
	MOD_AKAD_FRAMETEXT2 = "";
	MOD_AKAD_FOOTER = "";
end

local function __FormatGroupName(regionNumber,bgNumber)
	if regionNumber and bgNumber then
		return charMapping[regionNumber].."区"..charMapping[bgNumber].."组"
	end
end

local function GetBGroupText()
	local regionNumber = BFU_GetRegion();
	local bgNumber = BFU_GetBGGroup();
	if not bgNumber then return end
	local groupName = __FormatGroupName(regionNumber,bgNumber)
	
	local akInfo = AKchannelTable[groupName];
	local faction,localeName = BFU_GetFaction()
	if akInfo and akInfo[faction] then
		local info = akInfo[faction];
		return string.format(MOD_AKAD_FRAMETEXT1,groupName,info.akID,info.name,localeName);
	end
	return ;
end

local __bgGroupText =  GetBGroupText()

if not __bgGroupText then return end
ModManagement_RegisterMod(
	"AKAD",
	"Interface\\Icons\\INV_Jewelry_Necklace_14",
	MOD_AKAD,
	nil,
	nil,
	nil,
	{[2]=true,[4]=true}
);

ModManagement_RegisterStatic("AKAD",MOD_AKAD_TEXT1,1);

ModManagement_RegisterStatic("AKAD"," ");
ModManagement_RegisterStatic("AKAD",__bgGroupText,1,true);

ModManagement_RegisterStatic("AKAD",MOD_AKAD_FOOTER,1);