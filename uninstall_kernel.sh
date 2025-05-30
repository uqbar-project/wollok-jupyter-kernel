#!/bin/bash
set -e  # Exit on error

# Remove the conda environment if it exists
if conda info --envs | grep -q "^wollok "; then
    echo "Removing conda environment..."
    conda env remove -n wollok -y
fi

# Remove the Jupyter kernel
if command -v jupyter >/dev/null 2>&1; then
    if jupyter kernelspec list 2>/dev/null | grep -q "wollok"; then
        echo "Uninstalling Jupyter kernel..."
        jupyter kernelspec uninstall wollok -y
    fi
fi

# Clean up any remaining files
if command -v conda >/dev/null 2>&1; then
    CONDA_BASE="$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")"
    for dir in "$CONDA_BASE/envs/wollok" \
               "$CONDA_BASE/pkgs/wollok" \
               "$CONDA_BASE/pkgs/wollok-ts" \
               "$CONDA_BASE/pkgs/wollok_kernel" \
               "$CONDA_BASE/pkgs/wollok_kernel-*"; do
        if [ -e "$dir" ]; then
            echo "Removing $dir"
            rm -rf "$dir"
        fi
    done
fi

# Remove Jupyter kernel directory
KERNEL_DIR="$HOME/Library/Jupyter/kernels/wollok"
if [ -e "$KERNEL_DIR" ]; then
    echo "Removing $KERNEL_DIR"
    rm -rf "$KERNEL_DIR"
fi

echo -e "\n✅ Wollok kernel has been uninstalled successfully!"
