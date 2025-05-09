local mod	= DBM:NewMod("PlaguemawtheRotting", "DBM-Party-Vanilla", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(7356)
--mod:SetEncounterID(585)
mod:SetZone(129)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12946",
	"SPELL_AURA_APPLIED 12946 11442"
)

local warningWitheredTouch			= mod:NewTargetNoFilterAnnounce(11442, 2, nil, "RemoveDisease")

local specWarnPutridStench			= mod:NewSpecialWarningDispel(12946, "RemoveDisease", nil, nil, 1, 2)

local timerPutridStenchCD			= mod:NewAITimer(180, 12946, nil, nil, nil, 5, nil, DBM_COMMON_L.DISEASE_ICON)

function mod:OnCombatStart(delay)
	timerPutridStenchCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(12946) then
		timerPutridStenchCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(12946) and self:CheckDispelFilter("disease") then
		specWarnPutridStench:Show(args.destName)
		specWarnPutridStench:Play("helpdispel")
	elseif args:IsSpell(11442) and self:CheckDispelFilter("disease") then
		warningWitheredTouch:Show(args.destName)
	end
end
