set title "Plot of Output Layer!"
set output

plot 'flog.tsv' using ($0):40 with lines title 'close', \
     'flog.tsv' using ($0):41 with lines title 'far', \

pause -1 "Fuck!"
