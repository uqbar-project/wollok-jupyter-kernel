#!/bin/bash
set -e  # Exit on error

# Function to remove all instances of the kernel spec
remove_kernel_specs() {
    echo "Removing any existing Wollok kernel specs..."
    # Remove from user space
    jupyter kernelspec remove -f wollok 2>/dev/null || true
    # Remove from conda environment
    if [ -d "$CONDA_PREFIX/share/jupyter/kernels/wollok" ]; then
        rm -rf "$CONDA_PREFIX/share/jupyter/kernels/wollok"
    fi
    # Remove from user's local directory
    rm -rf "$HOME/.local/share/jupyter/kernels/wollok"
    # Remove from system-wide directory (requires sudo)
    if [ -d "/usr/local/share/jupyter/kernels/wollok" ]; then
        echo "Removing system-wide kernel spec (requires sudo)"
        sudo rm -rf "/usr/local/share/jupyter/kernels/wollok"
    fi
}

# Clean up any existing kernel specs first
remove_kernel_specs

# Create and activate conda environment with the latest stable Python 3.x
echo "Creating conda environment..."
conda create -n wollok python=3 -y
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate wollok

# Install build dependencies
echo "Installing dependencies..."
conda install -c conda-forge jupyter jupyter_client ipykernel hatchling -y

# Install the Wollok kernel in regular mode (not development mode)
echo "Installing Wollok kernel..."
pip install --no-cache-dir .

# The kernel spec is installed by hatch_build.py during package installation
# We just need to verify it exists
KERNEL_SPEC_DIR="$(python -c 'import sys; from pathlib import Path; print(Path(sys.prefix) / "share" / "jupyter" / "kernels" / "wollok")')"

if [ ! -d "$KERNEL_SPEC_DIR" ]; then
    echo "Error: Kernel spec not found at $KERNEL_SPEC_DIR"
    exit 1
fi

# Show success message and list installed kernels
echo -e "\n✅ Wollok kernel has been installed successfully!"
echo -e "\nInstalled kernels:"
jupyter kernelspec list
