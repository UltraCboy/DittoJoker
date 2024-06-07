--- STEAMODDED HEADER
--- MOD_NAME: Ditto
--- MOD_ID: DittoJoker
--- MOD_AUTHOR: [UltraCboy]
--- MOD_DESCRIPTION: Ditto Joker
--- LOADER_VERSION_GEQ: 1.0.0
--- BADGE_COLOUR: A595B9

----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = "ditto",
    path = "ditto.png",
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
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    pos = {x = 0, y = 0},
    cost = 7,
    config = {
		extra = {
			increment = 0.3, current = 1, spawn_goodies = true
		}
	},
    loc_txt = {
        name = "Ditto",
        text = {
            "Gains {X:mult,C:white}X#1# {} Mult whenever",
			"a {C:attention}playing card{} is copied",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
			
        }
    },
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.increment, card.ability.extra.current}}
	end,
	calculate = function(self, card, context)
		-- Do nothing if debuffed
		if self.debuff then return nil end
		if context.using_consumeable and not context.blueprint then
			-- Using Death
			if context.consumeable.ability.name == "Death" then
				card.ability.extra.current = card.ability.extra.current + card.ability.extra.increment
				card_eval_status_text(card, 'extra', nil, nil, nil, 
					{message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.current}}}
				)
			end
			-- Using Cryptid
			if context.consumeable.ability.name == "Cryptid" then
				card.ability.extra.current = card.ability.extra.current + 2 * card.ability.extra.increment
				card_eval_status_text(card, 'extra', nil, nil, nil, 
					{message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.current}}}
				)
			end
		end
		if context.cardarea == G.jokers then
			-- Using DNA
			if context.before and not context.blueprint then
				if G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
					local inc = 0
					local function foo(i)
						if i > #G.jokers.cards then return 0
						elseif G.jokers.cards[i].ability.name == "DNA" then return 1
						elseif G.jokers.cards[i].ability.name == "Blueprint" then return foo(i + 1)
						elseif G.jokers.cards[i].ability.name == "Brainstorm" then return foo(1)
						else return 0
						end
					end
					for i = 1, #G.jokers.cards do
						inc = inc + foo(i)
					end
					if inc > 0 then
						card.ability.extra.current = card.ability.extra.current + inc * card.ability.extra.increment
						card_eval_status_text(card, 'extra', nil, nil, nil, 
							{message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.current}}}
						)
					end
				end
			end
			-- Scoring
			if context.joker_main then
				if card.ability.extra.current > 1 then
					return {
						Xmult_mod = card.ability.extra.current,
						message = localize {
							type = 'variable',
							key = 'a_xmult',
							vars = {card.ability.extra.current}
						},
					}
				end
			end
		end
		-- Creating things on shops ending - TESTING ONLY
		if card.ability.extra.spawn_goodies and context.ending_shop then
			-- Create a Death Card
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                        local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_death', 'dit')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true
                end)}))
			-- Create a Cryptid Card
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                        local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, 'c_cryptid', 'dit')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true
                end)}))
			-- Create a DNA Joker
			G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_dna', 'dit')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                end}))
			-- No more goodies
			card.ability.extra.spawn_goodies = false
		end
	end,
    atlas = "ditto"
}

----------------------------------------------
------------MOD CODE END----------------------