# Use the official Python image as a base
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Install additional dependencies (e.g., CUDA, torchaudio)
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Set build argument for CUDA version (default to cu118)
ARG CUDA_VERSION=cu118

# Install PyTorch with configurable CUDA support
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/${CUDA_VERSION}

# Expose the port the app runs on
EXPOSE 8188

CMD ["python", "main.py", "--dont-print-server"]
ENV COMFYUI_PORT=8188
# Command to run the application
CMD ["python", "main.py"]
