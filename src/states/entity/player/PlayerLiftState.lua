--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerLiftState = Class{__includes = BaseState}

function PlayerLiftState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

    self.potHitBox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

    self.player:changeAnimation('lift-' .. self.player.direction)
    --self.player:changeState('walk-pot')
end

function PlayerLiftState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerLiftState:update(dt)
    local direction = self.player.direction

    if self.player.currentAnimation.timesPlayed > 0 then
        -- check if hitbox collides with any entities in the scene
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if object.type == 'pot' then
                if object:collides(self.potHitBox) then
                    --table.remove(self.room.objects, k)
                    --self.player:pickObject(object)
                    print("hit the pot!")
                    self.player:changeState('idle-pot')
                    return
                end
            end
        end
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end
end

function PlayerLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    --debug for player and hurtbox collision rects
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    love.graphics.rectangle('line', self.potHitBox.x, self.potHitBox.y,
        self.potHitBox.width, self.potHitBox.height)
    love.graphics.setColor(255, 255, 255, 255)
end
