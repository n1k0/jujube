const bass = {
  envelope: {
    attack: 0.1,
    decay: 0.3,
    release: 2
  },
  filterEnvelope: {
    attack: 0.001,
    decay: 0.01,
    sustain: 0.5,
    octaves: 2.6
  }
};

const brass = {
  portamento: 0.01,
  oscillator: {
    type: "sawtooth"
  },
  filter: {
    Q: 2,
    type: "lowpass",
    rolloff: -24
  },
  envelope: {
    attack: 0.1,
    decay: 0.1,
    sustain: 0.6,
    release: 0.5
  },
  filterEnvelope: {
    attack: 0.05,
    decay: 0.8,
    sustain: 0.4,
    release: 1.5,
    baseFrequency: 2000,
    octaves: 1.5
  }
};

const cello = {
  harmonicity: 3.01,
  modulationIndex: 14,
  oscillator: {
    type: "triangle"
  },
  envelope: {
    attack: 0.2,
    decay: 0.3,
    sustain: 0.1,
    release: 1.2
  },
  modulation: {
    type: "square"
  },
  modulationEnvelope: {
    attack: 0.01,
    decay: 0.5,
    sustain: 0.2,
    release: 0.1
  }
};

const drumSamples = [
  "audio/clap-808.ogg",
  "audio/clap-analog.ogg",
  "audio/clap-crushed.ogg",
  "audio/clap-fat.ogg",
  "audio/clap-slapper.ogg",
  "audio/clap-tape.ogg",
  "audio/cowbell-808.ogg",
  "audio/crash-808.ogg",
  "audio/crash-acoustic.ogg",
  "audio/crash-noise.ogg",
  "audio/crash-tape.ogg",
  "audio/hihat-808.ogg",
  "audio/hihat-acoustic01.ogg",
  "audio/hihat-acoustic02.ogg",
  "audio/hihat-analog.ogg",
  "audio/hihat-digital.ogg",
  "audio/hihat-dist01.ogg",
  "audio/hihat-dist02.ogg",
  "audio/hihat-electro.ogg",
  "audio/hihat-plain.ogg",
  "audio/hihat-reso.ogg",
  "audio/hihat-ring.ogg",
  "audio/kick-808.ogg",
  "audio/kick-acoustic01.ogg",
  "audio/kick-acoustic02.ogg",
  "audio/kick-big.ogg",
  "audio/kick-classic.ogg",
  "audio/kick-cultivator.ogg",
  "audio/kick-deep.ogg",
  "audio/kick-dry.ogg",
  "audio/kick-electro01.ogg",
  "audio/kick-electro02.ogg",
  "audio/kick-floppy.ogg",
  "audio/kick-gritty.ogg",
  "audio/kick-heavy.ogg",
  "audio/kick-newwave.ogg",
  "audio/kick-oldschool.ogg",
  "audio/kick-plain.ogg",
  "audio/kick-slapback.ogg",
  "audio/kick-softy.ogg",
  "audio/kick-stomp.ogg",
  "audio/kick-tape.ogg",
  "audio/kick-thump.ogg",
  "audio/kick-tight.ogg",
  "audio/kick-tron.ogg",
  "audio/kick-vinyl01.ogg",
  "audio/kick-vinyl02.ogg",
  "audio/kick-zapper.ogg",
  "audio/openhat-808.ogg",
  "audio/openhat-acoustic01.ogg",
  "audio/openhat-analog.ogg",
  "audio/openhat-slick.ogg",
  "audio/openhat-tight.ogg",
  "audio/perc-808.ogg",
  "audio/perc-chirpy.ogg",
  "audio/perc-hollow.ogg",
  "audio/perc-laser.ogg",
  "audio/perc-metal.ogg",
  "audio/perc-nasty.ogg",
  "audio/perc-short.ogg",
  "audio/perc-tambo.ogg",
  "audio/perc-tribal.ogg",
  "audio/perc-weirdo.ogg",
  "audio/ride-acoustic01.ogg",
  "audio/ride-acoustic02.ogg",
  "audio/shaker-analog.ogg",
  "audio/shaker-shuffle.ogg",
  "audio/shaker-suckup.ogg",
  "audio/snare-808.ogg",
  "audio/snare-acoustic01.ogg",
  "audio/snare-acoustic02.ogg",
  "audio/snare-analog.ogg",
  "audio/snare-big.ogg",
  "audio/snare-block.ogg",
  "audio/snare-brute.ogg",
  "audio/snare-dist01.ogg",
  "audio/snare-dist02.ogg",
  "audio/snare-dist03.ogg",
  "audio/snare-electro.ogg",
  "audio/snare-lofi01.ogg",
  "audio/snare-lofi02.ogg",
  "audio/snare-modular.ogg",
  "audio/snare-noise.ogg",
  "audio/snare-pinch.ogg",
  "audio/snare-punch.ogg",
  "audio/snare-smasher.ogg",
  "audio/snare-sumo.ogg",
  "audio/snare-tape.ogg",
  "audio/snare-vinyl01.ogg",
  "audio/snare-vinyl02.ogg",
  "audio/tom-808.ogg",
  "audio/tom-acoustic01.ogg",
  "audio/tom-acoustic02.ogg",
  "audio/tom-analog.ogg",
  "audio/tom-chiptune.ogg",
  "audio/tom-fm.ogg",
  "audio/tom-lofi.ogg",
  "audio/tom-rototom.ogg",
  "audio/tom-short.ogg"
];

const kalimba = {
  harmonicity: 8,
  modulationIndex: 2,
  oscillator: {
    type: "sine"
  },
  envelope: {
    attack: 0.001,
    decay: 2,
    sustain: 0.1,
    release: 2
  },
  modulation: {
    type: "square"
  },
  modulationEnvelope: {
    attack: 0.002,
    decay: 0.2,
    sustain: 0,
    release: 0.2
  }
};

const marimba = {
  oscillator: {
    partials: [1, 0, 2, 0, 3]
  },
  envelope: {
    attack: 0.001,
    decay: 1.2,
    sustain: 0,
    release: 1.2
  }
};

const piano = {
  harmonicity: 2,
  oscillator: {
    type: "amsine2",
    modulationType: "sine",
    harmonicity: 1.01
  },
  envelope: {
    attack: 0.006,
    decay: 4,
    sustain: 0.04,
    release: 1.2
  },
  modulation: {
    volume: 13,
    type: "amsine2",
    modulationType: "sine",
    harmonicity: 12
  },
  modulationEnvelope: {
    attack: 0.006,
    decay: 0.2,
    sustain: 0.2,
    release: 0.4
  }
};

const steelpan = {
  oscillator: {
    type: "fatcustom",
    partials: [0.2, 1, 0, 0.5, 0.1],
    spread: 40,
    count: 3
  },
  envelope: {
    attack: 0.001,
    decay: 1.6,
    sustain: 0,
    release: 1.6
  }
};

const wind = {
  portamento: 0.0,
  oscillator: {
    type: "square4"
  },
  envelope: {
    attack: 2,
    decay: 1,
    sustain: 0.2,
    release: 2
  }
};

export default {
  bass,
  brass,
  cello,
  drumSamples,
  kalimba,
  marimba,
  steelpan,
  piano,
  wind
};
