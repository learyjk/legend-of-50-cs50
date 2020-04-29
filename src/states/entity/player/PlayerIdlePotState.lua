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
            self.entity:changeState('walk')
    end



end
