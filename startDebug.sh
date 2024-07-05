#! /usr/bin/fish
make
sudo make install
cd ./linefollower
make
./linefollower 0
cd ..

