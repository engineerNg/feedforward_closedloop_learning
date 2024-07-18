set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'output.eps'
set grid
set title "Network Output"
set xlabel "time step"
set ylabel "output"
set xtics 0,4000,16000

plot 'flog.tsv' using ($0):3 with lines notitle




