FROM rockylinux:8
LABEL maintainer="jwhite@lbl.gov"
LABEL version="0.1"
LABEL PMIX_VER=4.1.3
LABEL MUNGE_VER=0.5.15
LABEL SLURM_VER=22.05.10

ENV PMIX_VER=4.1.3
ENV MUNGE_VER=0.5.15
ENV SLURM_VER=22.05.10

RUN dnf -y install 'dnf-command(config-manager)'
RUN dnf config-manager --enable powertools
RUN dnf -y install epel-release
RUN dnf -y install flex python36 make hwloc-devel pam-devel json-c-devel
RUN dnf -y install gcc rpm-build wget libevent-devel

#RUN wget -c https://github.com/openpmix/openpmix/releases/download/v${PMIX_VER}/pmix-${PMIX_VER}.tar.bz2
#RUN rpmbuild -tb --define "_topdir /tmp/rpmbuild" --clean pmix-${PMIX_VER}.tar.bz2
#RUN dnf -y install /tmp/rpmbuild/RPMS/x86_64/pmix-${PMIX_VER}-1*.rpm
#RUN rm -rf /tmp/rpmbuild pmix-${PMIX_VER}.tar.bz2

RUN groupadd -g 1000 slurm
RUN useradd -r -u 1000 -g slurm slurm
RUN groupadd -g 1001 munge
RUN useradd -r -u 1001 -g munge -d /var/run/munge munge

RUN dnf -y install \
	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/pmix-4.2.6-1.el8.x86_64.rpm \
	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-0.5.15-1.el8.x86_64.rpm \
	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-libs-0.5.15-1.el8.x86_64.rpm \
	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-devel-0.5.15-1.el8.x86_64.rpm
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/slurm-22.05.10-1.el8.x86_64.rpm \
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/slurm-pam_slurm-22.05.10-1.el8.x86_64.rpm \
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/slurm-slurmctld-22.05.10-1.el8.x86_64.rpm \
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/slurm-slurmdbd-22.05.10-1.el8.x86_64.rpm 

#RUN dnf -y install https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-0.5.15-1.el8.x86_64.rpm \
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-devel-0.5.15-1.el8.x86_64.rpm \
#	https://scs-repo.lbl.gov/repo/rhel/8/x86_64/munge-libs-0.5.15-1.el8.x86_64.rpm



RUN dnf -y install readline-devel perl-ExtUtils-MakeMaker mariadb-devel
RUN wget -c https://download.schedmd.com/slurm/slurm-${SLURM_VER}.tar.bz2
RUN rpmbuild -tb --define "_topdir /tmp/rpmbuild" slurm-${SLURM_VER}.tar.bz2 --with=pmix
RUN dnf -y install \
           /tmp/rpmbuild/RPMS/x86_64/slurm-${SLURM_VER}-1.*.x86_64.rpm \
           /tmp/rpmbuild/RPMS/x86_64/slurm-pam_slurm-${SLURM_VER}-1.*.x86_64.rpm \
           /tmp/rpmbuild/RPMS/x86_64/slurm-slurmdbd-${SLURM_VER}-1.*.x86_64.rpm \
	/tmp/rpmbuild/RPMS/x86_64/slurm-slurmctld-${SLURM_VER}-1.*.x86_64.rpm
RUN rm -rf /tmp/rpmbuild slurm-${SLURM_VER}.tar.bz2

RUN dnf -y install strace

RUN mkdir -p /etc/slurm/spank

RUN wget -c https://scs-repo.lbl.gov/slurm-plugins/slurm-plugins-${SLURM_VER}-el8.tar.gz
RUN tar -vxf slurm-plugins-$SLURM_VER-el8.tar.gz
RUN mv slurm-plugins-${SLURM_VER}-el8/{job_submit_slurm_banking.so,jobcomp_slurm_banking.so,job_submit_require_cpu_gpu_ratio.so} /usr/lib64/slurm/
RUN mv slurm-plugins-${SLURM_VER}-el8/{spank_collect_script.so,spank_private_tmpshm.so,spank_slurm_banking.so} /etc/slurm/spank/
RUN rm -rf slurm-plugins-${SLURM_VER}-el8*


RUN mkdir -p /run/munge
RUN chown munge:munge /run/munge
RUN chown munge:munge -R /run/munge

RUN echo "nohup su - munge -c munged -F > /var/log/munged.log &" >> /tmp/entrypoint.sh
RUN chmod a+rx /tmp/entrypoint.sh

CMD "sh /tmp/entrypoint.sh"
