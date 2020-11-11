mkdir build
cd build
git clone --depth 1 https://github.com/key4hep/spack
git clone --depth 1 https://github.com/key4hep/key4hep-spack
cp key4hep-spack/config/packages.yaml spack/etc/spack
cp key4hep-spack/config/cvmfs_build/upstreams.yaml spack/etc/spack
source spack/share/spack/setup-env.sh
spack repo add --scope site key4hep-spack
source setup_spack_gcc.sh
spack compiler find --scope site
cd ..
spack dev-build --test=all edm4hep@master ^podio@master

