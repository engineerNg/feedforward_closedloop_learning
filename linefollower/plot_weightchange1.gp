set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'weightchange1.eps'
set grid
set title "Weight Change of Layer 1"
set xtics 0,4000,16000

plot 'flog.tsv' using ($0):4 with lines notitle\

