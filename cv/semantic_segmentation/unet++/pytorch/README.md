# UNet++: A Nested U-Net Architecture for Medical Image Segmentation

## Model description

We present UNet++, a new, more powerful architecture for medical image segmentation. Our architecture is essentially
a deeply supervised encoder-decoder network where the encoder and decoder sub-networks are connected through a series of nested, dense skip
pathways. The re-designed skip pathways aim at reducing the semantic
gap between the feature maps of the encoder and decoder sub-networks.
We argue that the optimizer would deal with an easier learning task when
the feature maps from the decoder and encoder networks are semantically
similar.

## Step 1: Installation

### Install packages

```bash
yum install -y mesa-libGL

pip3 install -r requirements.txt

wget http://www.zlib.net/fossils/zlib-1.2.9.tar.gz
tar xvf zlib-1.2.9.tar.gz
cd zlib-1.2.9/
./configure && make install
```

### Build extension

```bash
python3 setup.py build && cp build/lib.linux*/mmcv/_ext.cpython* mmcv
```

## Step 2: Prepare datasets

If there is `DRIVE` dataset locally

```bash
mkdir -p data/
ln -s ${DRIVE_DATASET_PATH} data/
```

If there is no `DRIVE` dataset locally, you can download `DRIVE` from a file server or
[DRIVE](https://drive.grand-challenge.org/) official website 

```bash
python3 tools/convert_datasets/drive.py /path/to/training.zip /path/to/test.zip
```

## Step 3: Training



```bash
# Training on multiple cards
## "config" files can be found in the configs directory
bash train_dist.sh <config file> <num_gpus> [training args]  

# Example
bash train_dist.sh configs/unet++/unet++_r34_40k_drive.py 8
```

**Training arguments are as follows:**

```python
# the dir to save logs and models
work-dir: str = None

# the checkpoint file to load weights from
load-from: str = None

# the checkpoint file to resume from
resume-from: str = None

# whether not to evaluate the checkpoint during training
no-validate: bool = False

# (Deprecated, please use --gpu-id) number of gpus to 
# use (only applicable to non-distributed training)
gpus: int = None

# (Deprecated, please use --gpu-id) ids of gpus to use 
# (only applicable to non-distributed training)
gpu-ids: int = None

# id of gpu to use (only applicable to non-distributed training)
gpu-id: int = 0

# random seed
seed: int = None

# Whether or not set different seeds for different ranks
diff_seed: bool = False

# whether to set deterministic options for CUDNN backend.
deterministic: bool = False

# --options is deprecated in favor of --cfg_options' and it 
# will not be supported in version v0.22.0. Override some 
# settings in the used config, the key-value pair in xxx=yyy 
# format will be merged into config file. If the value to be 
# overwritten is a list, it should be like key="[a,b]" or key=a,b 
# It also allows nested list/tuple values, e.g. key="[(a,b),(c,d)]" 
# Note that the quotation marks are necessary and that no white space 
# is allowed.
options: str = None

# override some settings in the used config, the key-value pair 
# in xxx=yyy format will be merged into config file. If the value 
# to be overwritten is a list, it should be like key="[a,b]" or key=a,b 
# It also allows nested list/tuple values, e.g. key="[(a,b),(c,d)]" 
# Note that the quotation marks are necessary and that no white 
# space is allowed.
cfg-options: str = None

# job launcher
launcher: str = "none"

# local rank
local_rank: int = 0

# distributed backend
dist_backend: str = None

# resume from the latest checkpoint automatically.
auto-resume: bool = False
```

## Results

| GPUs| Crop Size | Lr schd | FPS | mDice |
| ------ | --------- | ------: | --------  |--------------:|
|  BI-V100 x8 | 64x64  |   40000 | 238.9      | 87.52 |

## Reference
- [dataset_prepare](https://mmsegmentation.readthedocs.io/en/latest/dataset_prepare.html#cityscapes)
- [mmsegmentation](https://github.com/open-mmlab/mmsegmentation)
