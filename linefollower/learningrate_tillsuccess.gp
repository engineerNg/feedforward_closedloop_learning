set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'learningrate_tillsuccess.eps'
set logscale x
set grid


plot 'stats_withend.dat' using 1:2 with points pointtype 2  pointsize 1 notitle
