local snd <const> = playdate.sound


local bounceSound = snd.synth.new(snd.kWaveTriangle)
bounceSound:setADSR(0.1, 0.0, 0, 0) -- Attack, Decay, Sustain, Release. (Everything is in second except Sustain, which is 0-1)   For Help See: https://sonic-pi.net/tutorial.html#attack-phase

local pointSound = snd.synth.new(snd.kWaveTriangle)
pointSound:setADSR(0.5, 0.3, 0, 0.1)

function playBounceSound()
    bounceSound:playNote(525, 1, 1) -- Note: With how the note is set up with setADSR(), it will finish playing before 1 second.
end

function playPointSound()
    pointSound:playNote(570, 1, 1)
end
