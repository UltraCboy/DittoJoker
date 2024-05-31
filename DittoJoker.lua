--- STEAMODDED HEADER
--- MOD_NAME: Ditto
--- MOD_ID: DITT
--- MOD_AUTHOR: [UltraCboy]
--- MOD_DESCRIPTION: Ditto Joker
--- LOADER_VERSION_GEQ: 1.0.0
--- BADGE_COLOUR: A595B9

----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = "ditto_test",
    path = "ditto_test.png",
    px = 71,
    py = 95
}

-- Available specific Joker parameters
-- SMODS.Joker{key, name, rarity, unlocked, discovered, blueprint_compat, perishable_compat, eternal_compat, pos, cost, config, set, prefix}
SMODS.Joker{
    key = "ditto",
    name = "Ditto",
    rarity = 2,
    discovered = true,
    pos = {x = 0, y = 0},
    cost = 4,
    config = {mult = 20},
    loc_txt = {
        name = "Ditto",
        text = {
            "TODO: write description",
        }
    },
    calculate = function(card, context)
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = card.ability.mult,
                colour = G.C.RED,
                message = "Ditto"
            }
        end
    end,
    atlas = "ditto_test"
}

----------------------------------------------
------------MOD CODE END----------------------