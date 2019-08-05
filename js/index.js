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
    drumKit.get(note.pitch).start(time);
  }).probability = 0.99;
}

function setupDrumKit(samples) {
  const sounds = samples.reduce((acc, sample) => ({ ...acc, [sample]: sample }), {});
  return new Promise(resolve => {
    new Tone.Players(sounds, function(kit) {
      resolve(kit.toMaster());
    });
  });
}

app.ports.load.subscribe(function() {
  Tone.start();
  Tone.Master.chain(new Tone.Limiter(-6));
  vuMeter(Tone.Master, document.querySelector(".vuMeter"));
  setupDrumKit(instruments.drumSamples).then(function(result) {
    drumKit = result;
    app.ports.ready.send(true);
  });
});

app.ports.start.subscribe(function() {
  Tone.Transport.start();
  Tone.Transport.scheduleRepeat(function(time) {
    app.ports.bar.send(true);
  }, "4m");
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
