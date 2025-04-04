local mod	= DBM:NewMod("BazilThredd", "DBM-Party-Vanilla", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(1716)
mod:SetZone(34)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7964"
)

local warningSmokeBomb			= mod:NewSpellAnnounce(7964, 2)

local timerSmokeBombCD			= mod:NewCDTimer(15.8, 7964, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerSmokeBombCD:Start(8-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(7964) and args:IsSrcTypeHostile() then
		warningSmokeBomb:Show()
		timerSmokeBombCD:Start()
	end
end
