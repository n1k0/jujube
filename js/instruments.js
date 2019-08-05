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
  "clap-808.ogg",
  "clap-analog.ogg",
  "clap-crushed.ogg",
  "clap-fat.ogg",
  "clap-slapper.ogg",
  "clap-tape.ogg",
  "cowbell-808.ogg",
  "crash-808.ogg",
  "crash-acoustic.ogg",
  "crash-noise.ogg",
  "crash-tape.ogg",
  "hihat-808.ogg",
  "hihat-acoustic01.ogg",
  "hihat-acoustic02.ogg",
  "hihat-analog.ogg",
  "hihat-digital.ogg",
  "hihat-dist01.ogg",
  "hihat-dist02.ogg",
  "hihat-electro.ogg",
  "hihat-plain.ogg",
  "hihat-reso.ogg",
  "hihat-ring.ogg",
  "kick-808.ogg",
  "kick-acoustic01.ogg",
  "kick-acoustic02.ogg",
  "kick-big.ogg",
  "kick-classic.ogg",
  "kick-cultivator.ogg",
  "kick-deep.ogg",
  "kick-dry.ogg",
  "kick-electro01.ogg",
  "kick-electro02.ogg",
  "kick-floppy.ogg",
  "kick-gritty.ogg",
  "kick-heavy.ogg",
  "kick-newwave.ogg",
  "kick-oldschool.ogg",
  "kick-plain.ogg",
  "kick-slapback.ogg",
  "kick-softy.ogg",
  "kick-stomp.ogg",
  "kick-tape.ogg",
  "kick-thump.ogg",
  "kick-tight.ogg",
  "kick-tron.ogg",
  "kick-vinyl01.ogg",
  "kick-vinyl02.ogg",
  "kick-zapper.ogg",
  "openhat-808.ogg",
  "openhat-acoustic01.ogg",
  "openhat-analog.ogg",
  "openhat-slick.ogg",
  "openhat-tight.ogg",
  "perc-808.ogg",
  "perc-chirpy.ogg",
  "perc-hollow.ogg",
  "perc-laser.ogg",
  "perc-metal.ogg",
  "perc-nasty.ogg",
  "perc-short.ogg",
  "perc-tambo.ogg",
  "perc-tribal.ogg",
  "perc-weirdo.ogg",
  "ride-acoustic01.ogg",
  "ride-acoustic02.ogg",
  "shaker-analog.ogg",
  "shaker-shuffle.ogg",
  "shaker-suckup.ogg",
  "snare-808.ogg",
  "snare-acoustic01.ogg",
  "snare-acoustic02.ogg",
  "snare-analog.ogg",
  "snare-big.ogg",
  "snare-block.ogg",
  "snare-brute.ogg",
  "snare-dist01.ogg",
  "snare-dist02.ogg",
  "snare-dist03.ogg",
  "snare-electro.ogg",
  "snare-lofi01.ogg",
  "snare-lofi02.ogg",
  "snare-modular.ogg",
  "snare-noise.ogg",
  "snare-pinch.ogg",
  "snare-punch.ogg",
  "snare-smasher.ogg",
  "snare-sumo.ogg",
  "snare-tape.ogg",
  "snare-vinyl01.ogg",
  "snare-vinyl02.ogg",
  "tom-808.ogg",
  "tom-acoustic01.ogg",
  "tom-acoustic02.ogg",
  "tom-analog.ogg",
  "tom-chiptune.ogg",
  "tom-fm.ogg",
  "tom-lofi.ogg",
  "tom-rototom.ogg",
  "tom-short.ogg"
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
