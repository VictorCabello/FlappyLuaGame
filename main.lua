local love = require("love")

function love.load()
    BirdX = 62
    BirdWidth = 30
    BirdHeight = 25

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
        BirdY = 200
        BirdYSpeed = 0
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
    BirdYSpeed = BirdYSpeed + ( 515 * dt)
    BirdY = BirdY + (BirdYSpeed * dt)

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

    local function isBirdCollidingWithPipe(pipeX, pipeSpaceY)
        return
        BirdX < (pipeX + PipeWidth)
        and
        (BirdX + BirdWidth) > pipeX
        and (
            BirdY < pipeSpaceY
            or
            (BirdY + BirdHeight) > (pipeSpaceY + PipeSpaceHeight)
        )
    end

    if isBirdCollidingWithPipe(Pipe1X, Pipe1SpaceY)
        or isBirdCollidingWithPipe(Pipe2X, Pipe2SpaceY)
        or BirdY > PlayingAreaHeight
    then

        love.load()
    end

    local function updateScoreAndClosestPipe(thispipe, pipeX, otherPipe)
        if UpcomingPipe == thispipe
            and (BirdX > (pipeX + PipeWidth))
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

function DrawBrind()
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill',
		BirdX,
		BirdY,
		BirdWidth,
		BirdHeight
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
    DrawBrind()
    DrawPipes()
end

function love.keypressed()
    if BirdY > 0 then
        BirdYSpeed = -165
    end
end
