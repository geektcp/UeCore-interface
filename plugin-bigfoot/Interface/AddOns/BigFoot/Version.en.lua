if GetLocale()~='{locale}' then return end
local main= "{versionmain}."
local minor = "{versionminor}"
BIGFOOT_VERSION = "{locale}"..main..minor;

function GetMinorVersion()
	return minor
end

BigFootChangelog_ah();

	BigFootChangelog_at("2010/10/28 (4.0.0.229)")
	BigFootChangelog_ar("BFCooldown","BFCooldown is compatible with 4.0 after fix.")


BigFootChangelog_af();


BF_VERSION_CHECKSUM = "{versionchecksum}"