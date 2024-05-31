--- STEAMODDED HEADER
--- MOD_NAME: Ditto
--- MOD_ID: DITT
--- MOD_AUTHOR: [UltraCboy]
--- MOD_DESCRIPTION: Ditto Joker

----------------------------------------------
------------MOD CODE -------------------------


function SMODS.INIT.Ditto()
    local loc_def = 
	{
        ["name"] = "Ditto",
        ["text"] = {
            [1] = "TODO: write description",
        }
    }

    -- SMODS.Joker:new(name, slug, config, spritePos, loc_txt, rarity, cost, unlocked, discovered, blueprint_compat, eternal_compat)
    local ditto = SMODS.Joker:new("Ditto", "ditto", {}, {
        x = 0,
        y = 0
    }, loc_def, 1, 4)

    SMODS.Sprite:new("j_ditto", SMODS.findModByID("DITT").path, "ditto_test.png", 71, 95, "asset_atli"):register();

    ditto:register()

    SMODS.Jokers.j_ditto.set_ability = function(self, context)
        sendDebugMessage("Hello !", 'MyLogger')
    end

    SMODS.Jokers.j_ditto.calculate = function(self, context)
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = 20,
                card = self,
                colour = G.C.RED,
                message = "Ditto"
            }

        end
    end
end

----------------------------------------------
------------MOD CODE END----------------------
