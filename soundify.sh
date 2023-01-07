#!/bin/bash

rm result.json

# Set the file argument
file=$1
filename=$(basename "$file")
seed_id="${filename%.*}"
# Set the prompt argument
prompt=$2

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
}' http://127.0.0.1:3013/run_inference/ >> result.json

python3 decode.py result.json

