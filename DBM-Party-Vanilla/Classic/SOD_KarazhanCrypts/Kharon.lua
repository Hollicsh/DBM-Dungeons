if not DBM:IsSeasonal("SeasonOfDiscovery") then return end
local mod	= DBM:NewMod("Kharon", "DBM-Party-Vanilla", 22)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetEncounterID(3143)
--mod:SetCreatureID()
mod:SetZone(2875)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)

function mod:OnCombatStart()
	self:AddMsg("This DBM mod is a placeholder for new content, there are no timers or warnings yet.")
	self:AddMsg("If you see this message well after the new content release consider updating the DBM Dungeon module to the latest version.")
end
