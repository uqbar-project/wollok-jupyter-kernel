import os
import sys
from hatchling.builders.hooks.plugin.interface import BuildHookInterface
import subprocess

import argparse
import json
import os
import shutil

from jupyter_client.kernelspec import KernelSpecManager
from tempfile import TemporaryDirectory

kernel_json = {
    "argv": [sys.executable, "-m", "wollok_kernel", "-f", "{connection_file}"],
    "display_name": "Wollok",
    "language": "wollok",
}

class CustomHook(BuildHookInterface):
    def initialize(self, version, build_data):
        here = os.path.abspath(os.path.dirname(__file__))
        sys.path.insert(0, here)
        prefix = os.path.join(here, 'data_kernelspec')

        self.find_and_install_npm_dependencies(start_dir=here)

        with TemporaryDirectory() as td:
            os.chmod(td, 0o755) # Starts off as 700, not user readable
            with open(os.path.join(td, 'kernel.json'), 'w') as f:
                json.dump(kernel_json, f, sort_keys=True)
            print('Installing Jupyter kernel spec')

            # Requires logo files in kernel root directory
            cur_path = os.path.dirname(os.path.realpath(__file__))
            for logo in ["logo-32x32.png", "logo-64x64.png"]:
                try:
                    shutil.copy(os.path.join(cur_path, logo), td)
                except FileNotFoundError:
                    print("Custom logo files not found. Default logos will be used.")

            KernelSpecManager().install_kernel_spec(td, 'wollok', user=False, prefix=prefix)


    def find_and_install_npm_dependencies(self, start_dir="."):
        """Find and install npm dependencies for every package.json files in subfolders"""
        print("Installing node dependencies")
        subprocess.run(["pwd"])
        for root, dirs, files in os.walk(start_dir):
            if "package.json" in files:
                print(f"package.json found in: {root}")
                try:
                    subprocess.run(["npm", "install"], cwd=root, check=True)
                    print(f"✅ npm install completed in {root}\n")
                except subprocess.CalledProcessError as e:
                    print(f"❌ Error executing npm install in {root}: {e}\n")
