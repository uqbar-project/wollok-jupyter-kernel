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

# Create kernel directory
KERNEL_DIR="$(python -c 'from jupyter_core.paths import jupyter_data_dir; print(jupyter_data_dir())')/kernels/wollok"
mkdir -p "$KERNEL_DIR"

# Get the Python executable path
PYTHON_PATH="$(which python)"

# Create kernel.json with proper configuration
cat > "$KERNEL_DIR/kernel.json" << EOL
{
 "argv": [
  "$PYTHON_PATH",
  "-m",
  "wollok_kernel",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Wollok",
 "language": "wollok",
 "metadata": {
  "debugger": false,
  "kernelspec": {
   "display_name": "Wollok",
   "language": "wollok",
   "name": "wollok"
  }
 },
 "env": {},
 "interrupt_mode": "message"
}
EOL

# Copy any logo files if they exist
for logo in logo-32x32.png logo-64x64.png; do
    if [ -f "$logo" ]; then
        cp "$logo" "$KERNEL_DIR/"
    fi
done

# Register the kernel
echo "Registering Wollok kernel..."
python -m jupyter kernelspec install --user --name=wollok "$KERNEL_DIR"

# Force refresh the kernel list
echo -e "\n✅ Wollok kernel has been installed successfully!"
echo -e "\nAvailable kernels:"
jupyter kernelspec list --json | python -c '
import json, sys
kernels = json.load(sys.stdin)["kernelspec"]
for name, spec in kernels.items():
    print(f"{name}: {spec["resource_dir"]}")
'
