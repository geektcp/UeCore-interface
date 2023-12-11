 local BigFootLocal_dbdf11f5b07258936fb1c5a31eaa969c = 1; 
 local BigFootLocal_1b5523f0adb45c4b8ee51f89ebf6f2b2 = 0; 
 local BLocalClass = {}; 
 BLocalClass.localizations = {}; 
 local function BigFootLocal_43b36898bdc494f6064fc3eefeb72205(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335) 
	assert(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335 and type(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335) == "string", format("%s -=> The localization key (%s) must be a string value!", tostring(rawget(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, "_NAME")), tostring(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335))); 
	
	return BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335; 
end 

local function BigFootLocal_f4b0f2c66a3cd295596843deeb474a3d(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335, BigFootLocal_8d0644c92128c1ff68223fd74ba63b56) 
	assert(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335 and type(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335) == "string", format("%s -=> The localization key (%s) must be a string value!", tostring(rawget(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, "_NAME")), tostring(BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335))); 
	
	if (not BigFootLocal_8d0644c92128c1ff68223fd74ba63b56 or tostring(BigFootLocal_8d0644c92128c1ff68223fd74ba63b56) == "true") then 
		rawset(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335, BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335); 
	else 
		rawset(BigFootLocal_6c5560108ad7aaf47e811081394a00b4, BigFootLocal_63a9ce6f1eeac72ef41293b7d0303335, BigFootLocal_8d0644c92128c1ff68223fd74ba63b56); 
	end 
end 

BLocalClass.mt = {__index = BigFootLocal_43b36898bdc494f6064fc3eefeb72205, __newindex = BigFootLocal_f4b0f2c66a3cd295596843deeb474a3d}; 

local function BigFootLocal_fc61281b1dd2a45e88952efdbef780e6(self, BigFootLocal_8983c60d66c8593ec7165ea9dbedb584) 
	assert(BigFootLocal_8983c60d66c8593ec7165ea9dbedb584 and type(BigFootLocal_8983c60d66c8593ec7165ea9dbedb584) == "string", "BLocal -=> The parameter must be a string value!"); 
	
	if (not BLocalClass.localizations[BigFootLocal_8983c60d66c8593ec7165ea9dbedb584]) then 
		BLocalClass.localizations[BigFootLocal_8983c60d66c8593ec7165ea9dbedb584] = setmetatable({}, BLocalClass.mt); 
		BLocalClass.localizations[BigFootLocal_8983c60d66c8593ec7165ea9dbedb584]._NAME = BigFootLocal_8983c60d66c8593ec7165ea9dbedb584; 
	end 
	return BLocalClass.localizations[BigFootLocal_8983c60d66c8593ec7165ea9dbedb584];
end 

BLocalClass.GetLocal = BigFootLocal_fc61281b1dd2a45e88952efdbef780e6; 

function BLocalClass:constructor() 
end 

BLibrary:Register(BLocalClass,"BLocalClass",BigFootLocal_dbdf11f5b07258936fb1c5a31eaa969c,BigFootLocal_1b5523f0adb45c4b8ee51f89ebf6f2b2); 

BLocal = BLibrary("BLocalClass"); 
getmetatable(BLocal).__call = BigFootLocal_fc61281b1dd2a45e88952efdbef780e6; 
--[[ local L = BLocal("BigFoot"); L["hello world!"] = "hello bigfoot"; ChatFrame1:AddMessage(L["hello world!"]); L["hello world!"] = true; ChatFrame1:AddMessage(L["hello world!"]); L["hello wow!"] = nil; ChatFrame1:AddMessage(L["hello wow!"]); ChatFrame1:AddMessage(L["你好KK魔兽"]); ChatFrame1:AddMessage(L[1]); ]]
