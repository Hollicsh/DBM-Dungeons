local mod	= DBM:NewMod(527, "DBM-Party-BC", 1, 248)
local L		= mod:GetLocalizedStrings()

if mod:IsRetail() then
	mod.statTypes = "normal,heroic,duos"
end

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(17306)
mod:SetEncounterID(1893)
mod:SetZone(248, 2849)--Hellfire ramparts, Duos

mod:SetModelID(18236)
mod:SetModelOffset(-0.2, 0, -0.3)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(
--)
