--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{__includes = GameObject}

function Projectile:init(def, x, y, player)
    GameObject.init(self, def)
    self.x = x
    self.y = y
    self.dx = 0
    self.dy = 0
    self.player = player
    self.isThrown = false
    self.distanceTraveled = 0
end

function Projectile:update(dt)
    -- move the projectile
    if self.dx ~= 0 or self.dy ~= 0 then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
        self.distanceTraveled = self.distanceTraveled + (self.dx * dt) + (self.dy * dt)
    else
        self.x = self.player.x
        self.y = self.player.y - (self.player.height/2 + 2)
    end
end

function Projectile:hitsWall(room)
    if self.x < 1 + 16 or self.x > VIRTUAL_WIDTH - 32 then
        return true
    elseif self.y < 1 + 16 or self.y > VIRTUAL_HEIGHT - 32 then
        return true
    else
        return false
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end
