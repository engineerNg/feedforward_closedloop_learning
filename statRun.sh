#! /usr/bin/fish
make
sudo make install
cd ./linefollower
make
./linefollower 1
cd ..

