use_debug false
use_bpm 112


fadein = (ramp *range(0.5, 0.1, 0.05))
glitchy_volume = 2
eleckick_volume = 4
bd_volume = 1
bass_volume = 1
melody_volume = 0.5

kick_cutoff = range(50, 80, 0.5).mirror
live_loop :elec do
  if (spread 1, 4).tick then
    sample :elec_soft_kick, amp: fadein.tick* eleckick_volume, decay: 0.5,
      cutoff: kick_cutoff.look
  end
  sleep 1
end

live_loop :bd do
  sync :elec
  with_fx :echo, mix: 1 do
    sample :bd_pure, amp: fadein.tick* bd_volume
  end
  sleep 0.5
end

live_loop :bass do
  sync :elec
  with_fx :lpf, cutoff: 130 do
    sample :bass_thick_c, pre_amp: 1, decay: 1, amp: fadein.tick* bass_volume
  end
  sleep 2
end

live_loop :glitchy do
  with_fx :reverb do
    sample :glitch_bass_g, amp: fadein.tick* glitchy_volume, pan: rrand(1, -1), mix: 1, room: 1
  end
  sleep 4
end

live_loop :melody do
  with_fx :ixi_techno do
    p = play (chord :Eb3, :major7).tick, divisor: 0.01, div_slide: rrand(0, 10), depth: rrand(0.001, 2), release: rrand(0, 5), amp: fadein.tick* melody_volume
    control p, divisor: rrand(10, 50)
  end
  sleep [1.5, 0.5, 1, 1].look
end

