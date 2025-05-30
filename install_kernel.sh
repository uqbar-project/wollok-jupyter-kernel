# /bin/bash
conda create -n wollok jupyter -y
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate wollok
conda install jupyter ipykernel -y
pip install .
python -m ipykernel install --user --name wollok --display-name "Wollok"
