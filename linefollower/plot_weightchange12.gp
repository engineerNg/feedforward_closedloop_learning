set terminal epscairo size 8cm,6cm enhanced font 'Verdana,12' monochrome
set output 'weightchange12.eps'
set grid
set xtics 0,4000,16000

plot 'flog.tsv' using ($0):16 with lines notitle,\
	'flog.tsv' using ($0):17 with lines notitle


