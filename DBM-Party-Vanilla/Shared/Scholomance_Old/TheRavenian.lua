local mod	= DBM:NewMod("TheRavenian", "DBM-Party-Vanilla", DBM:IsRetail() and 16 or 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(10507)

mod:RegisterCombat("combat")