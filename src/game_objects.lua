--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },

    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'idle',
        states = {
            ['idle'] = {
                frame = 5
            },
        },
        onCollide = function(self, room, k)
            if room.player.health <= 4 then
                room.player:damage(-2)
                table.remove(room.objects, k)
            end
            return false
        end
    },

    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'idle',
        states = {
            ['idle'] = {
                frame = 14,
            }
        },
        onCollide = function()
        end
    }
}
