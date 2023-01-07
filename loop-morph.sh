#!/bin/bash

# Set the directory containing the input files
input_directory="./loops/0-raw"
# Set the directory for the output files
output_directory="./loops/1-raw-images"

# Loop through all files in the input directory
for file in "$input_directory"/*; do
  # Extract the filename from the full path
  filename=$(basename "$file")
  # Remove the file extension
  output_filename="${filename%.*}"
  # Add the .png suffix
  output_filename="$output_filename.png"
  # Generate the full path for the output file
  output_file="$output_directory/$output_filename"

  # Run the command with the current file as the argument and the output file
  python3 -m riffusion.cli audio-to-image -a "$file" -i "$output_file"

done

