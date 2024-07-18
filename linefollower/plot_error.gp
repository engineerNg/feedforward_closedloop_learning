set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'error.eps'
set grid
set title "Closed-loop Error"
set xlabel "time step"
set ylabel "error"
set yrange [-1:1]
set xtics 0,4000,16000

plot 'flog.tsv' using ($0):2 with lines notitle




