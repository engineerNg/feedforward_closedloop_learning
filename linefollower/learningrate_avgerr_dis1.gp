set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'learningrate_avgerr_dis1.eps'
set logscale x
set grid

plot 'stats_withend_dis1.dat' using 1:4 with points pointtype 2  pointsize 1 notitle
