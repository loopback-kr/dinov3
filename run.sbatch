#!/bin/bash
#SBATCH --job-name dinov3_train
#SBATCH --output logs/%x/%j.log
#SBATCH --time 7-00:00:00
#SBATCH --partition A100,RTX6000Ada,A6000,RTX3090,RTX8000
#SBATCH --gres gpu:1 -A found.mi2rl

set -euo pipefail

/usr/bin/docker compose build train
/usr/bin/docker compose run -T --service-ports train
