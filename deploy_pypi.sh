#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Starting deployment process..."

# Clean up previous builds
rm -rf dist/ build/ *.egg-info/

# Install required tools
echo "📦 Installing build tools..."
pip install --upgrade pip
pip install -q build twine ipykernel

# Get current local version
CURRENT_VERSION=$(python -c "from wollok_kernel import __version__; print(__version__)")
echo "📦 Current local version: $CURRENT_VERSION"

# Try to get the latest PyPI version
echo "🔍 Checking PyPI for latest version..."

# The package name on PyPI uses a hyphen, not an underscore
PYPI_PACKAGE_NAME="wollok-kernel"

# Get the current version from PyPI
PYPI_OUTPUT=$(pip index versions "$PYPI_PACKAGE_NAME" 2>&1)
PYPI_STATUS=$?

if [ $PYPI_STATUS -ne 0 ]; then
    if [[ $PYPI_OUTPUT == *"No matching distribution found"* ]]; then
        echo "ℹ️  Package not found on PyPI. This appears to be the first release."
        PYPI_VERSION="0.0.0"
    else
        echo "❌ Error checking PyPI version"
        echo "$PYPI_OUTPUT"
        exit 1
    fi
else
    # Try to extract version from the output
    PYPI_VERSION=$(echo "$PYPI_OUTPUT" | grep -oP '(?<=available: )([0-9.]+)' || true)
    
    if [ -z "$PYPI_VERSION" ]; then
        # Fallback to a more permissive version pattern
        PYPI_VERSION=$(echo "$PYPI_OUTPUT" | grep -oP '([0-9]+\.[0-9]+(\.[0-9]+)?)' | head -1 || true)
        
        if [ -z "$PYPI_VERSION" ]; then
            echo "❌ Could not determine version from PyPI"
            exit 1
        fi
    fi
fi

echo "📦 Latest PyPI version: $PYPI_VERSION"

# Compare versions
if [ "$(printf '%s\n' "$CURRENT_VERSION" "$PYPI_VERSION" | sort -V | head -n1)" = "$CURRENT_VERSION" ]; then
    if [ "$CURRENT_VERSION" = "$PYPI_VERSION" ]; then
        echo "❌ Error: Version $CURRENT_VERSION is already published on PyPI"
        echo "Please update the version in wollok_kernel/__init__.py"
        exit 1
    fi
    # Current version is greater than PyPI version, continue
    echo "✅ Version $CURRENT_VERSION is newer than PyPI version $PYPI_VERSION"
else
    echo "❌ Error: Local version $CURRENT_VERSION is older than PyPI version $PYPI_VERSION"
    echo "Please update the version in wollok_kernel/__init__.py"
    exit 1
fi

# Build the package
echo "🔨 Building package..."
python -m build

# Upload to PyPI
echo "🚀 Uploading $PYPI_PACKAGE_NAME to PyPI..."
twine upload dist/*

echo "✅ Version $CURRENT_VERSION deployed successfully!"
