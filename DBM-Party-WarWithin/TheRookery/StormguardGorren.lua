local mod	= DBM:NewMod(2567, "DBM-Party-WarWithin", 3, 1268)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(207205)
mod:SetEncounterID(2861)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 424737 425048 424958",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 424739",
	"SPELL_AURA_REMOVED 424739",
	"SPELL_PERIODIC_DAMAGE 424966",
	"SPELL_PERIODIC_MISSED 424966"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnSomeChaoticCorruption				= mod:NewTargetNoFilterAnnounce(424737, 3)

local specWarnChaoticCorruption				= mod:NewSpecialWarningYou(424737, nil, nil, nil, 1, 2)
local yellChaoticCorruption					= mod:NewYell(424737)
local yellChaoticCorruptionFades			= mod:NewShortFadesYell(424737, nil, false)
local specWarnDarkGravity					= mod:NewSpecialWarningRunCount(425048, nil, nil, nil, 4, 13)
local specWarnCrushReality					= mod:NewSpecialWarningDodgeCount(424958, nil, nil, nil, 2, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(424966, nil, nil, nil, 1, 8)

local timerChaoticCorruptionCD				= mod:NewAITimer(33.9, 424737, nil, nil, nil, 3)
local timerDarkGravityCD					= mod:NewAITimer(33.9, 425048, nil, nil, nil, 2)
local timerCrushRealityCD					= mod:NewAITimer(33.9, 424958, nil, nil, nil, 3)

mod:AddInfoFrameOption(424797)

mod.vb.chaoticCount = 0
mod.vb.gravityCount = 0
mod.vb.crushCount = 0

--local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.chaoticCount = 0
	self.vb.gravityCount = 0
	self.vb.crushCount = 0
	timerChaoticCorruptionCD:Start(1)
	timerDarkGravityCD:Start(1)
	timerCrushRealityCD:Start(1)
	if self.Options.InfoFrame and self:IsMythic() then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(424797))
		DBM.InfoFrame:Show(5, "playerdebuffremaining", 424797)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 424737 then
		self.vb.chaoticCount = self.vb.chaoticCount + 1
		timerChaoticCorruptionCD:Start()
	elseif spellId == 425048 then
		self.vb.gravityCount = self.vb.gravityCount + 1
		specWarnDarkGravity:Show(self.vb.gravityCount)
		specWarnDarkGravity:Play("pullin")
		specWarnDarkGravity:ScheduleVoice(1.5, "justrun")
		timerDarkGravityCD:Start()
	elseif spellId == 424958 then
		self.vb.crushCount = self.vb.crushCount + 1
		specWarnCrushReality:Show(self.vb.crushCount)
		specWarnCrushReality:Play("watchwave")
		timerCrushRealityCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 372858 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 424739 then
		if args:IsPlayer() then
			specWarnChaoticCorruption:Show()
			specWarnChaoticCorruption:Play("targetyou")
			yellChaoticCorruption:Yell()
			yellChaoticCorruptionFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 424739 then
		if args:IsPlayer() then
			yellChaoticCorruptionFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 424966 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 193435 then

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]