#!/bin/bash
#SBATCH -p dgx2q
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
export OMP_NUM_THREADS=1
module load slurm/20.02.7
module load cuda11.1/toolkit/11.1.1
module load cuda10.2/toolkit/10.2.243
module use /cm/shared/ex3-modules/0.4.0/modulefiles
module load python/3.7.4
source ../../../pytorch_env/bin/activate

datapath=../
datasets=('electrical_insulator' 'photovoltaic_module' 'metal_welding ' 'wind_turbine ' 'catenary_dropper' 'nut_and_bolt'
'witness_mark')
dataset_flags=($(for dataset in "${datasets[@]}"; do echo '-d '$dataset; done))

python main.py --dataset mvtec --data_path ../MIAD/ --noise 0.1  "${dataset_flags[@]}" --gpu 0

