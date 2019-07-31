window.instruments = (function() {
  const bass = {
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

  // drums

  function loadDrums() {
    return new Promise((resolve, reject) => {
      const drums = new Tone.Players({
        kick: "audio/kick-deep.ogg",
        snare: "audio/snare-electro.ogg",
        hihat: "audio/hihat-electro.ogg",
      }, function() {
        resolve(drums);
      });
    });
  }

  return {
    bass,
    brass,
    cello,
    kalimba,
    marimba,
    steelpan,
    piano,
    wind,
    loadDrums
  };
})();
