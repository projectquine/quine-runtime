pkg install golang make cmake ndk-multilib

mkdir $TMPDIR/docker-build
cd $TMPDIR/docker-build
cd $TMPDIR/docker-build
git clone --depth 1 https://github.com/krallin/tini
cd tini
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j8
make install
ln -s $PREFIX/bin/tini-static $PREFIX/bin/docker-init
