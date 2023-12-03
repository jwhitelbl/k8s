docker run \
	--mount type=bind,src="/home/jwhite/k8s/slurm/root/etc/munge",target=/etc/munge \
	--mount type=bind,src="/home/jwhite/k8s/slurm/root/etc/slurm/slurmdbd.conf",target=/etc/slurm/slurmdbd.conf \
	--mount type=bind,src="/home/jwhite/k8s/slurm/root/var/log/slurm",target=/var/log/slurm \
	--mount type=bind,src="/home/jwhite/k8s/slurm/root/var/run/slurm",target=/var/run/slurm \
        --mount type=bind,src="/home/jwhite/k8s/slurm/root/var/log/munge",target=/var/log/munge \
	6599c6e7dbcb437749fce5619386a41310f1de4f5484622982fe07843d73af51 $*