# Copyright (c) 2023, NVIDIA CORPORATION.  All rights reserved.

import importlib

required_libs = [
    "faiss",
    "h5py",
    "transformers", # for huggingface bert
]

for lib in required_libs:
    try:
        globals()[lib] = importlib.import_module(lib)
    except ImportError as e:
        raise Exception(f"Missing one or more packages required for Retro preprocessing: {required_libs}. Tried importing '{lib}'.")
