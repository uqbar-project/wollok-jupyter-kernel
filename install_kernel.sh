#!/bin/bash
set -e  # Exit on error

# First, uninstall any existing kernel
echo "Removing any existing Wollok kernel..."
jupyter kernelspec remove -f wollok 2>/dev/null || true
rm -rf "$HOME/.local/share/jupyter/kernels/wollok"

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
# We just need to register it with the correct prefix
KERNEL_SPEC_DIR="$(python -c 'import sys; from pathlib import Path; print(Path(sys.prefix) / "share" / "jupyter" / "kernels" / "wollok")')"

if [ ! -d "$KERNEL_SPEC_DIR" ]; then
    echo "Error: Kernel spec not found at $KERNEL_SPEC_DIR"
    exit 1
fi

# Register the kernel
echo "Registering Wollok kernel..."
jupyter kernelspec install --user "$KERNEL_SPEC_DIR"

# Show success message and list installed kernels
echo -e "\n✅ Wollok kernel has been installed successfully!"
jupyter kernelspec list
