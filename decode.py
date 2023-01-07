import sys
import json
import base64
import os

# Set the input file path
input_file = sys.argv[1]
output_filename=sys.argv[2]

# Set the output directory
output_directory = "./loops/3-converted-audio/"

# Read the input file
with open(input_file, "r") as f:
    data = json.load(f)

# Extract the base64-encoded MP3 clip from the JSON data
encoded_clip = data["audio"]

# Decode the base64-encoded MP3 clip
decoded_clip = base64.b64decode(encoded_clip)

# Extract the filename from the input file path
filename = os.path.basename(input_file)

# Add the .mp3 suffix
output_filename += ".mp3"

# Save the decoded MP3 clip to the output file
with open(output_filename, "wb") as f:
    f.write(decoded_clip)

