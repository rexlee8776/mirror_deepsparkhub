# Copyright (c) 2023, Shanghai Iluvatar CoreX Semiconductor Co., Ltd.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -euox pipefail

CUR_DIR=$(cd "$(dirname "$0")";pwd)
cd ${CUR_DIR}

if [[ ! -d ${CUR_DIR}/BookCorpusDataset ]]; then
    echo "BookCorpusDataset not exist, downloading..."
    wget http://sw.iluvatar.ai/download/apps/datasets/BookCorpusDataset/BookCorpusDataset.tar
    tar -xf BookCorpusDataset.tar && rm -f BookCorpusDataset.tar
fi