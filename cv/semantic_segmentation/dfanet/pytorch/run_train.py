# Copyright (c) 2022 Iluvatar CoreX. All rights reserved.

import os
import sys

sys.path.append("../../torchvision/pytorch")

from model import builder
from train import train_model
from utils import padding_conv_channel_to_4


def create_model(args):
    args.find_unused_parameters = True
    model = builder.__dict__[args.model](args.num_classes)
    if args.padding_channel:
        model.encoder.conv1[0] = padding_conv_channel_to_4(model.encoder.conv1[0])

    return model


train_model(create_model)


