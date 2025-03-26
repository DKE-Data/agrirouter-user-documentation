#!/bin/bash

# Parse command line arguments
DRY_RUN=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--dry-run) DRY_RUN=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Base path for images
IMAGE_BASE_PATH="de/modules/ROOT/assets/images"

# Extract image paths and sizes from adoc files and process them
find de -name "*.adoc" -type f -exec grep -l "image::" {} \; | while read -r adoc_file; do
    grep "image::" "$adoc_file" | while read -r line; do
        # Extract image path and size
        if [[ $line =~ image::([^[]+)\[(.*)\] ]]; then
            image_path="${BASH_REMATCH[1]}"
            size="${BASH_REMATCH[2]}"
            
            # Extract just the number from the size (e.g., "Select Register, 400" -> "400")
            if [[ $size =~ .*,\ *([0-9]+) ]]; then
                target_size="${BASH_REMATCH[1]}"
                full_image_path="$IMAGE_BASE_PATH/$image_path"
                if [ "$DRY_RUN" = true ]; then
                    echo "[DRY RUN] Would process $full_image_path to size $target_size"
                else
                    echo "Processing $full_image_path to size $target_size"
                    magick -verbose "$full_image_path" -strip -quality 85 -resize "${target_size}x${target_size}^" "$full_image_path"
                fi
            fi
        fi
    done
done