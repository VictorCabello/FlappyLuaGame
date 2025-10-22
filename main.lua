local love = require("love")
local bird = require("bird")


function love.load()
    bird:setup()
    PlayingAreaWidth = 300
    PlayingAreaHeight = 388

    PipeSpaceHeight = 100
    PipeWidth = 54

    function newPipeSpaceY()
        local pipeSpaceYMin = 54
        local pipeSpaceY = love.math.random(
            pipeSpaceYMin,
            PlayingAreaHeight - PipeSpaceHeight
        )
        return pipeSpaceY
    end

    function reset()
        bird:reset()
        Pipe1X = PlayingAreaWidth
        Pipe1SpaceY = newPipeSpaceY()

        Pipe2X = PlayingAreaWidth + ((PlayingAreaWidth + PipeWidth)/2)
        Pipe2SpaceY = newPipeSpaceY()

        Score = 0
        UpcomingPipe = 1
    end
    reset()
end

function love.update(dt)
    bird:update(dt)

    local function movePipe(pipeX, pipeSpaceY)
        pipeX = pipeX - (60 * dt)

        if (pipeX + PipeWidth) < 0 then
            pipeX = PlayingAreaWidth
            pipeSpaceY = newPipeSpaceY()
        end

        return pipeX, pipeSpaceY
    end

    Pipe1X, Pipe1SpaceY = movePipe(Pipe1X, Pipe1SpaceY)
    Pipe2X, Pipe2SpaceY = movePipe(Pipe2X, Pipe2SpaceY)

    local function isbirdCollidingWithPipe(pipeX, pipeSpaceY)
        return bird.x < (pipeX + PipeWidth)
        and
        (bird.x + bird.width) > pipeX
        and (
            bird.y < pipeSpaceY
            or
            (bird.y + bird.height) > (pipeSpaceY + PipeSpaceHeight)
        )
    end

    if isbirdCollidingWithPipe(Pipe1X, Pipe1SpaceY)
        or isbirdCollidingWithPipe(Pipe2X, Pipe2SpaceY)
        or bird.y > PlayingAreaHeight
    then

        love.load()
    end

    local function updateScoreAndClosestPipe(thispipe, pipeX, otherPipe)
        if UpcomingPipe == thispipe
            and (bird.x > (pipeX + PipeWidth))
        then
            Score = Score + 1
            UpcomingPipe = otherPipe
        end
    end
    updateScoreAndClosestPipe(1, Pipe1X, 2)
    updateScoreAndClosestPipe(2, Pipe2X, 1)
end

function DrawBackground()
    love.graphics.setColor(.14, .36, .46)
    love.graphics.rectangle(
        'fill',
        0,
        0,
        PlayingAreaWidth,
        PlayingAreaHeight
    )
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

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(Score, 15, 15)
end

function love.draw()
    DrawBackground()
    bird:draw()
    DrawPipes()
end

function love.keypressed()
    bird:jump()
end
