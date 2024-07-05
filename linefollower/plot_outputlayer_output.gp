set title "Plot of 1st Hidden Layer!"
set output

plot 'flog.tsv' using ($0):25 with lines title 'neuron 1', \
     'flog.tsv' using ($0):26 with lines title 'neuron 2', \
     'flog.tsv' using ($0):27 with lines title 'neuron 3', \
     'flog.tsv' using ($0):28 with lines title 'neuron 4', \
     'flog.tsv' using ($0):29 with lines title 'neuron 5', \
     'flog.tsv' using ($0):30 with lines title 'neuron 6', \


pause -1 "Fuck!"
