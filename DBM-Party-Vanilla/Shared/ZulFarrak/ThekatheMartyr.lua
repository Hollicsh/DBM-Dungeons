local mod	= DBM:NewMod(485, "DBM-Party-Vanilla", DBM:IsPostCata() and 15 or 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(7272)
mod:SetEncounterID(596)
mod:SetZone(209)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 11089",
	"SPELL_AURA_APPLIED 8600"
)

local warningFeveredPlague			= mod:NewTargetNoFilterAnnounce(8600, 2, nil, "RemoveDisease")
local warningThekaTransoform		= mod:NewSpellAnnounce(11089, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(11089) then
		warningThekaTransoform:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(8600) and args:IsDestTypePlayer() and self:CheckDispelFilter("disease") then
		warningFeveredPlague:Show(args.destName)
	end
end
