window.instruments = (function() {
  const bass = {
    volume: -10,
    envelope: {
      attack: 0.1,
      decay: 0.3,
      release: 2,
    },
    filterEnvelope: {
      attack: 0.001,
      decay: 0.01,
      sustain: 0.5,
      octaves: 2.6
    }
  };

  const tiny = {
    volume: -10,
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

  const kalimba = {
    volume: -10,
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

  const electricCello = {
    volume: -10,
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

  const brassCircuit = {
    volume: -10,
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

  const steelpan = {
    volume: -10,
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

  const marimba = {
    volume: -10,
    oscillator: {
      partials: [
        1,
        0,
        2,
        0,
        3
      ]
    },
    envelope: {
      attack: 0.001,
      decay: 1.2,
      sustain: 0,
      release: 1.2
    }
  };

  const wind = {
    volume: -10,
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

  return {
    bass,
    tiny,
    kalimba,
    electricCello,
    brassCircuit,
    steelpan,
    marimba,
    wind,
  };
})();
