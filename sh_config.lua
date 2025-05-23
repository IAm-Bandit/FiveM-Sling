Config = {}

-- https://docs.fivem.net/docs/game-references/text-formatting/
Config.Prefix = "~p~[GCRP]"

Config.Sling = "You have slung your weapon."
Config.Unsling = "You don't have a weapon to unsling."
Config.Warn = "Hey! This weapon can only be taken out of a car or a dufflebag."

Config.SlingCommand = "sling"
Config.SlingDefaultKey = "J"

Config.EnableSling = true
Config.Weapons = {
	-- ARs --
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_CARBINERIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_HEAVYRIFLE",
	"WEAPON_TACTICALRIFLE",
	-- SHOTGUNS --
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_COMBATSHOTGUN",
	-- SMGs --
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	-- SNIPER RIFLES --
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_SNIPERRIFLE"
}

Config.Models = {
	-- ARs --
    ["WEAPON_ADVANCEDRIFLE"] = "W_AR_ADVANCEDRIFLE",
    ["WEAPON_ASSAULTRIFLE"] = "W_AR_ASSAULTRIFLE",
    ["WEAPON_CARBINERIFLE"] = "W_AR_CARBINERIFLE",
    ["WEAPON_COMPACTRIFLE"] = "w_ar_assaultrifle_smg",
    ["WEAPON_SPECIALCARBINE"] = "w_ar_specialcarbine",
    ["WEAPON_HEAVYRIFLE"] = "w_ar_heavyrifle",
    ["WEAPON_TACTICALRIFLE"] = "W_AR_CARBINERIFLE_REH",
    -- SHOTGUNS --
    ["WEAPON_ASSAULTSHOTGUN"] = "w_sg_assaultshotgun",
    ["WEAPON_HEAVYSHOTGUN"] = "w_sg_heavyshotgun",
    ["WEAPON_PUMPSHOTGUN"] = "w_sg_pumpshotgun",
    ["WEAPON_COMBATSHOTGUN"] = "w_sg_pumpshotgunh4",
    -- SMGs --
    ["WEAPON_ASSAULTSMG"] = "w_sb_assaultsmg",
    ["WEAPON_GUSENBERG"] = "w_sb_gusenberg",
    ["WEAPON_MICROSMG"] = "w_sb_microsmg",
    ["WEAPON_MINISMG"] = "w_sb_minismg",
    ["WEAPON_SMG"] = "w_sb_smg",
    -- SNIPER RIFLES --
    ["WEAPON_HEAVYSNIPER"] = "w_sr_heavysniper",
    ["WEAPON_HEAVYSNIPER_MK2"] = "w_sr_heavysnipermk2",
    ["WEAPON_SNIPERRIFLE"] = "w_sr_sniperrifle"
}
