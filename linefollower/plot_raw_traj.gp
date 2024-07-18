set terminal epscairo size 8.5cm,7.5cm  enhanced font 'Verdana,12' monochrome
set output 'raw_traj_learning.eps'
# set title "Trajectory of Robot without Learning"

plot "coord.tsv" using 1:2 with lines title 'Trajectory'
# pause -1 "Hit any key to continue"
