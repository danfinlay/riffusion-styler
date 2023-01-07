#!/bin/bash

rm ./result.json

# Set the file argument
file=$1
# Extract the filename from the full path
filename=$(basename "$file")
seed_id="${filename%.*}"
# Set the prompt argument
outpath=$2
prompt=$3
server=$4

# Set the directory for the input loop images
seed_folder="./seed_images"

# Set the directory for the output files
output_directory="./loops/"

# Remove the file extension
output_filename="${filename%.*}"
# Add the .png suffix
output_filename="$output_filename.png"
# Generate the full path for the output file
output_file="$seed_folder/$output_filename"

# Run the command with the current file as the argument and the output file
python3 -m riffusion.cli audio-to-image -a "$file" -i "$output_file"

# Run the CURL command with the file and prompt arguments
curl -X POST -H "Content-Type: application/json" -d '{
  "alpha": 0.75,
  "num_inference_steps": 50,
  "seed_image_id": "'"$seed_id"'",

  "start": {
    "prompt": "'"${prompt}"'",
    "seed": 42,
    "denoising": 0.75,
    "guidance": 7.0
  },

  "end": {
    "prompt": "'"${prompt}"'",
    "seed": 123,
    "denoising": 0.75,
    "guidance": 7.0
  }
}' http://${server}/run_inference/ >> result.json

python3 decode.py result.json $outpath/$seed_id
