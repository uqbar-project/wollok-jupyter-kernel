[![Python package](https://github.com/uqbar-project/wollok-jupyter-kernel/actions/workflows/test.yml/badge.svg)](https://github.com/uqbar-project/wollok-jupyter-kernel/actions/workflows/test.yml)

<img src="./images/wollok_jupyter.png" height="100px" width="100px">

## Wollok Kernel for Jupyter notebook

`wollok_kernel` is a Jupyter kernel implementation, started from [a wrapper kernel](http://jupyter-client.readthedocs.io/en/latest/wrapperkernels.html).

## Installation

### From PyPI

To install `wollok_kernel` from PyPI:

```bash
pip install wollok_kernel
```
    
### From Git using Conda

To install `wollok_kernel` from git into a Conda environment:

```bash
git clone https://github.com/jupyter/wollok_kernel
cd wollok_kernel
conda create -n ker jupyter
conda activate ker
pip install .
```

## Using Wollok kernel

- **Notebook**: The *New* menu in the notebook should show an option for a Wollok notebook.
- **Console frontends**: To use it with the console frontends, add ``--kernel wollok`` to their command line arguments.
