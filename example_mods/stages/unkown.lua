local timer = true
local followPos = true
local counter = 1

function onCreatePost()
    MidPointX = getProperty('dad.x') + getProperty('dad.width') + math.abs(getProperty('boyfriend.x')-getProperty('dad.x')-getProperty('dad.width'))/2

    makeLuaSprite('forest1', 'bg/main stage', -1100, -500)
    addLuaSprite('forest1')

    makeLuaSprite('forest2', 'bg/front trees 1', -1180, -500)
    addLuaSprite('forest2')

    triggerEvent('Camera Follow Pos', MidPointX, 380)

    setProperty('gf.x', MidPointX - getProperty('gf.width')/1.5)
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bunfriend')
end

function onBeatHit()
    Ofs = 60

    if followPos then
        if mustHitSection == false then
            triggerEvent('Camera Follow Pos', MidPointX - Ofs*3, 380 - Ofs)
            --debugPrint('dad')
        elseif mustHitSection then
            triggerEvent('Camera Follow Pos', MidPointX + Ofs*3, 380 + Ofs)
            --debugPrint('bf')
        end
    end
    --debugPrint(os.clock() - OffsetTime
end

function otimer(name, time)
    OtimerName = name
    Otime = time
    OffsetTime = os.clock()
    timer = true
end

function onSongStart()
    OffsetTime = os.clock()

    otimer('taunt', 12.4)
end

function onUpdate(elapsed)
    local time = getProperty('songTime')/1000

    if time >= Otime and OtimerName == 'taunt' and timer == true and counter < 4 then
        triggerEvent('Play Animation', 'taunt', 0)
        timer = false
        otimer('taunt', 0.5*counter + 12.4)
        counter = counter + 1
    end
end