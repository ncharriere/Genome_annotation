#!/bin/bash
#SBATCH --time=7-0
#SBATCH --mem=120G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=50
#SBATCH --job-name=Maker
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Run_Maker_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Run_Maker_%x_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/ncharriere/TE_annotation"
REPEATMASKER_DIR="/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"

export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"
module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

#cd $WORKDIR

mpiexec --oversubscribe -n 50 apptainer exec \
--bind $SCRATCH:/TMP \
--bind $COURSEDIR \
--bind $AUGUSTUS_CONFIG_PATH \
--bind $REPEATMASKER_DIR \
--bind $WORKDIR \
${COURSEDIR}/containers/MAKER_3.01.03.sif \
maker -mpi --ignore_nfs_tmp -TMP /TMP \
maker_opts.ctl maker_bopts.ctl \
maker_evm.ctl maker_exe.ctl