local MP = minetest.get_modpath(
    minetest.get_current_modname(
    )
)

local S, NS = dofile(
    MP .. "/intllib.lua"
)

minetest.register_privilege(
    'invincible',
    {
        description = S(
            "player cannot be killed"
        ),
        give_to_singleplayer = false,
    }
)

minetest.register_on_player_hpchange(
    function (
        player,
        hp_change,
        reason
    )
        local name = player:get_player_name(
        )
        local privs = minetest.get_player_privs(
            name
        )
        if 0 <= hp_change then
            return hp_change, false
        end
        if true == privs[
            "invincible"
        ] then
            return 0, false
        end
        return hp_change, false
    end,
    true
)
