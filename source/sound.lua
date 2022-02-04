local snd <const> = playdate.sound


local bounceSound = snd.synth.new(snd.kWaveSquare)
bounceSound:setADSR(0.05, 0.2, 0, 0) -- Attack, Decay, Sustain, Release. (Everything is in second except Sustain, which is 0-1)   For Help See: https://sonic-pi.net/tutorial.html#attack-phase

local hitSound = snd.synth.new(snd.kWaveSquare)
hitSound:setADSR(0, 0.2, 0, 0)

local pointSound = snd.synth.new(snd.kWaveSquare)
pointSound:setADSR(0.5, 0.3, 0, 0.1)

function playBounceSound()
    bounceSound:playNote(523, 1, 1) -- Note: With how the note is set up with setADSR(), it will finish playing before 1 second.
end

function playHitSound()
    hitSound:playNote(515, 1, 1)
end

function playPointSound()
    pointSound:playNote(500, 1, 1)
    pointSound:playNote(510, 1, 1)
end