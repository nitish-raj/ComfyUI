#!/bin/bash

# Function to start the Cloudflare tunnel
start_cloudflared() {
    while true; do
        sleep 0.5
        if nc -z 127.0.0.1 8188; then
            break
        fi
    done
    printf "\nComfyUI finished loading, trying to launch cloudflared (if it gets stuck here cloudflared is having issues)\n"
    cloudflared tunnel --url http://127.0.0.1:8188 &
}

# Start the Cloudflare tunnel in the background
start_cloudflared &

# Start the ComfyUI application
python main.py --dont-print-server