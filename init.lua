local S

if minetest.get_modpath(
    "intllib"
) then
    S = intllib.Getter(
    )
else
    S = function(
        translated
    )
        return translated
    end
end

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
