function onCreatePost()

    --name, modifier class, type (defaults to all), playfield number (-1 = all)
                            --other types:
                            -- player
                            -- opponent
  
                        
    startMod('drunkPF0', 'DrunkXModifier', 'player', -1) --playfield 0 = default playfield
    startMod('tipsyPF1', 'TipsyYModifier', 'player', -1)

    ease(32, 4, 'cubeInOut', [[
        1, tipsyPF1,
        2, tipsyPF1:speed
    ]]) --puting ":" makes it ease a submod, in this case its changing the speed


    for i = 0,3 do 
        local beat = i*8

        --start time, ease time, ease, modifier data (value, name)
        ease(beat, 1, 'expoOut', [[
            0.8, drunkPF0,
            3, drunkPF0:speed
        ]])

        --one section after
        ease((beat)+4, 1, 'expoOut', [[
            -0.8, drunkPF0
        ]])
    end


    startMod('drunkPF0', 'DrunkXModifier', 'player', -1) --playfield 0 = default playfield
    startMod('tipsyPF1', 'TipsyYModifier', 'player', -1)

    ease(32, 4, 'cubeInOut', [[
        1, tipsyPF1,
        2, tipsyPF1:speed
    ]]) --puting ":" makes it ease a submod, in this case its changing the speed


    for i = 4,50 do 
        local beat = i*8

        --start time, ease time, ease, modifier data (value, name)
        ease(beat, 1, 'expoOut', [[
            1.5, drunkPF0,
            3, drunkPF0:speed
        ]])

        --one section after
        ease((beat)+4, 1, 'expoOut', [[
            -1.5, drunkPF0
        ]])
    end


   
end
