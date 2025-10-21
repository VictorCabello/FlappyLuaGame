
function love.load()
    BirdY = 200
    BirdX = 62
    BirdWidth = 30
    BirdHeight = 25
    BirdYSpeed = 0

    PlayingAreaWidth = 300
    PlayingAreaHeight = 388

    PipeSpaceHeight = 100
    PipeWidth = 54

    local function resetPipe()
        local pipeSpaceYMin = 54
        PipeSpaceY = love.math.random(
            pipeSpaceYMin,
            PlayingAreaHeight - PipeSpaceHeight
        )
        PipeX = PlayingAreaWidth
    end
    resetPipe()

    Pipe1X = 100
    Pipe1SpaceY = 100

    Pipe2X = 200
    Pipe2SpaceY = 200
end

function love.update(dt)
    BirdYSpeed = BirdYSpeed + ( 515 * dt)
    BirdY = BirdY + (BirdYSpeed * dt)
    PipeX = PipeX - (60 * dt)

    if
        BirdX < (PipeX + PipeWidth)
        and
        (BirdX + BirdWidth) > PipeX
        and (
            BirdY < PipeSpaceY
            or
            (BirdY + BirdHeight) > (PipeSpaceY + PipeSpaceHeight)
        )
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
    love.graphics.rectangle('fill', BirdX, BirdY, BirdWidth, BirdHeight)
end

function DrawPipes()
    local function drawPipe(pipeX, pipeSpaceY)
        love.graphics.setColor(.37, .82, .28)

        love.graphics.rectangle(
            'fill',
            pipeX,
            0,
            PipeWidth,
            pipeSpaceY
        )

        love.graphics.rectangle(
            'fill',
            pipeX,
            PipeSpaceHeight + pipeSpaceY,
            PipeWidth,
            PlayingAreaHeight - PipeSpaceHeight - pipeSpaceY
        )
    end

    drawPipe(Pipe1X, Pipe1SpaceY)
    drawPipe(Pipe2X, Pipe2SpaceY)
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
