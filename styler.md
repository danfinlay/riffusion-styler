# Stylizing an Audio Track

There is an extra script in this root folder called `./sound2sound.sh`, and it's intended to let you input a sound file along with a prompt for a style to apply to it.

It doesn't work great yet, but is available for experimentation!

The script requires that you're already running the [inference server](./README.md#run-the-model-server), and requires that you provide its address as a parameter, which we'll call `$INFERENCE_SERVER`. It currently assumes local/http, and adds the route path for you.

Example usage:

```
 ./sound2sound.sh loops/0-raw/056_4.WAV ./loops/3-converted-audio/ "solo electric bass guitar, vibrato" 127.0.0.1:3013
```

The arguments in order are:
- The path to an input sound file (must be wav unless you have ffmpeg installed, per [readme](./README.md)).
- The path to a folder where you'd like the resulting audio to be put (the file name will be preserved, but the file extension `.mp3` will be used instead).
- A prompt to apply to the audio clip.
- The address of the inference server.

## Component scripts

That above script will:
1. Convert your sound file to a spectrogram.
2. Send that spectrogram to the inference server with your prompt.
3. Save the result in `result.json`
4. Parse `result.json` into the output `.mp3` using `./decode.py`.

Most of this glue code was written by ChatGPT! Neat, huh?

If you have a `result.json` but you want to use decode.py, you can use it like this:

```
python3 decode.py result.json $TARGET_FILE
```

where `$TARGET_FILE` is the path to save the file __but without a file extension__ (it will get `.mp3` added either way, anyways, whatever, I know, this is a hack).
