local C = LibStub("AceAddon-3.0"):NewAddon("BFTargetFrame","AceHook-3.0")

C.config = {
	self = 23,
	other = 17,
	row = 3,
	rowWidth = 125
}

function AdjustBuffSize(isMine, size)
	if isMine then 
		C.config.self = size  or C.config.self 
		BFCH_MYBUFF_SIZE = size
	else
		C.config.other = size or C.config.other
		BFCH_OTHERBUFF_SIZE = size
	end
	TargetFrame_UpdateAuras(TargetFrame)
end
