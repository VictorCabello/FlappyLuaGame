function resetPipe()
    local pipeSpaceYMin = 54
    PipeSpaceY = love.math.random(
        pipeSpaceYMin,
        PlayingAreaHeight - PipeSpaceHeight
    )
    PipeX = PlayingAreaWidth
end

function love.load()
    BirdY = 200
    BirdX = 62
    BirdWidth = 30
    BirdYSpeed = 0

    PlayingAreaWidth = 300
    PlayingAreaHeight = 388

    PipeSpaceHeight = 100
    PipeWidth = 54
    resetPipe()
end

function love.update(dt)
    BirdYSpeed = BirdYSpeed + ( 515 * dt)
    BirdY = BirdY + (BirdYSpeed * dt)
    PipeX = PipeX - (60 * dt)

    if
        BirdX < (PipeX + PipeWidth)
        and
        (BirdX + BirdWidth) > PipeX
        and
        BirdY < PipeSpaceY
    then

        love.load()
    end
end

function DrawBackground()
    love.graphics.setColor(.14, .36, .46)
    love.graphics.rectangle('fill', 0, 0, PlayingAreaWidth, PlayingAreaHeight)
end

function DrawBrind()
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', BirdX, BirdY, BirdWidth, 25)
end

function DrawPipes()

    love.graphics.setColor(.37, .82, .28)

    love.graphics.rectangle(
        'fill',
        PipeX,
        0,
        PipeWidth,
        PipeSpaceY
    )

    love.graphics.rectangle(
        'fill',
        PipeX,
        PipeSpaceHeight + PipeSpaceY,
        PipeWidth,
        PlayingAreaHeight - PipeSpaceHeight - PipeSpaceY
    )
end

function love.draw()
    DrawBackground()
    DrawBrind()
    DrawPipes()
end

function love.keypressed()
    if BirdY > 0 then
        BirdYSpeed = -165
    end
end
