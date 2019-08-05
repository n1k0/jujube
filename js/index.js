import { Elm } from "./../elm/Main.elm";
import instruments from "./instruments.js";
import vuMeter from "./meter.js";

if (module.hot) {
  module.hot.dispose(() => {
    window.location.reload();
  });
}

const app = Elm.Main.init({ node: document.querySelector("main") });

let drumKit;
const tracks = {};

function setTrack(id, sequence, handler) {
  if (tracks.hasOwnProperty(id)) {
    tracks[id].mute = true;
    tracks[id].probability = 0;
    tracks[id].loop = 0;
    tracks[id].callback = () => {};
    tracks[id]
      .cancel(0)
      .stop(0)
      .removeAll()
      .dispose();
  }
  delete tracks[id];
  tracks[id] = new Tone.Sequence(handler, sequence).start(0);
  return tracks[id];
}

function drumTrack(id, sequence) {
  setTrack(id, sequence, function(time, note) {
    try {
      drumKit.get(note.pitch).start(time);
    } catch (e) {
      console.warn("cannot get drum sample", note.pitch);
    }
  }).probability = 0.99;
}

async function setupDrumKit() {
  const reverb = new Tone.Reverb(1.1);
  reverb.wet.value = 0.2;
  await reverb.generate();
  const panVol = new Tone.PanVol(0, -6);
  const sounds = instruments.drumSamples.reduce((acc, sample) => ({ ...acc, [sample]: sample }), {});
  drumKit = await new Promise(resolve => {
    new Tone.Players(sounds, function(kit) {
      resolve(kit.chain(panVol, reverb, Tone.Master));
    });
  });
}

app.ports.load.subscribe(async function() {
  Tone.start();
  Tone.Master.chain(new Tone.Limiter(-6));
  vuMeter(Tone.Master, document.querySelector(".vuMeter"));
  await setupDrumKit();
  app.ports.ready.send(true);
});

app.ports.start.subscribe(function() {
  Tone.Transport.start();
  Tone.Transport.scheduleRepeat(app.ports.bar.send, "4m");
});

app.ports.stop.subscribe(function() {
  Tone.Transport.stop();
  Tone.Transport.position = 0;
});

app.ports.setBpm.subscribe(function(bpm) {
  Tone.Transport.bpm.value = bpm;
});

app.ports.setDrumTracks.subscribe(function(drums) {
  for (const key in drums) {
    drumTrack(key, drums[key].sequence);
  }
});

app.ports.setTrack.subscribe(function(track) {
  const panVol = new Tone.PanVol(track.pan, track.volume);
  const pingPong = new Tone.PingPongDelay("8n", 0);
  const instrument = new Tone.PolySynth(4, Tone.Synth, instruments[track.instrument]).chain(
    pingPong,
    panVol,
    Tone.Master
  );

  setTrack(track.id, track.sequence, function(time, note) {
    instrument.triggerAttackRelease(note.pitch, note.dur, time, note.vel);
  }).probability = track.probability;
});
