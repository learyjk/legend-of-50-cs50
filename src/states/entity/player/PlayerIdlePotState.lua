--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdlePotState = Class{__includes = EntityIdleState}

function PlayerIdlePotState:init(entity, dungeon)
    self.entity = entity
    self.dungeon = dungeon

    self.entity:changeAnimation('idle-pot-' .. self.entity.direction)

end

function PlayerIdlePotState:update(dt)

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
            self.entity:changeState('walk-pot')
    end

    if love.keyboard.wasPressed('return') then

        for i = #self.dungeon.currentRoom.projectiles, 1, -1 do
            p = self.dungeon.currentRoom.projectiles[i]
            self.entity:throw(p)
        end
        --table.remove should be part of Projectile:update when it hits stuff
        --table.remove(self.dungeon.currentRoom.projectiles, 1)
        self.entity:changeState('idle')
    end



end
