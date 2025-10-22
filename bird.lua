local M = {
    defaults = {
        x = 62,
        y = 200,
        width = 30,
        height = 25,
        ySpeed = 0
    }
}

M.setup = function(self, opts)
    local function init(anOpts)
        for k, v in pairs(anOpts) do
            self[k] = v
        end
    end

    init(self.defaults)
    if opts ~= nil then
        init(opts)
    end
end

M.reset = function(self)
    self.setup(self, self.defaults)
end

M.update = function(self, dt)
    local speed = self.ySpeed
    speed = speed + ( 515 * dt)
    self.y = self.y + (speed * dt)
    self.ySpeed = speed
end

M.draw = function (self)
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill',
		self.x,
		self.y,
		self.width,
		self.height
    )
end

M.jump = function (self)
    if self.y > 0 then
        self.ySpeed = -165
    end
end

return M
