set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'learningrate_tillunstable.eps'
set logscale x
set grid

plot 'stats.dat' using 1:3:(($2<15000)? 2:3) with points pointtype variable pointsize 1 notitle
