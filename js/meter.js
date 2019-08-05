function clamp(x, lower, upper) {
  if (Number.isNaN(x)) return NaN;
  if (Number.isNaN(lower)) return NaN;
  if (Number.isNaN(upper)) return NaN;

  const max = Math.max(x, lower);
  const min = Math.min(max, upper);

  return min;
}

function scale(x, inLow, inHigh, outLow, outHigh) {
  if (Number.isNaN(x)) return NaN;
  if (Number.isNaN(inLow)) return NaN;
  if (Number.isNaN(inHigh)) return NaN;
  if (Number.isNaN(outLow)) return NaN;
  if (Number.isNaN(outHigh)) return NaN;

  if (x === Infinity || x === -Infinity) return x;

  let result = x - inLow;
  result *= outHigh - outLow;
  result /= inHigh - inLow;
  result += outLow;
  return result;
}

export default function vuMeter(tone, canvas) {
  const split = new Tone.Split();
  tone.connect(split);
  const meters = [new Tone.Meter(0.9), new Tone.Meter(0.9)];
  split.left.connect(meters[0]);
  split.right.connect(meters[1]);

  const context = canvas.getContext("2d");

  loop();

  function loop() {
    requestAnimationFrame(loop);
    const { width, height } = canvas;
    const values = meters.map(m => m.getLevel());
    const barHeights = values.map(value => clamp(scale(value, -100, 6, 0, height), 4, height));
    context.clearRect(0, 0, width, height);
    const barWidth = width / meters.length;
    context.fillStyle = "#777";
    const margin = meters.length > 1 ? 5 : 0;
    barHeights.forEach((barHeight, i) => {
      context.fillRect(i * barWidth + margin * i, height - barHeight, barWidth - margin, barHeight);
    });
  }
}
