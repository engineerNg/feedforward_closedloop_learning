set term qt 0
set title "Plot of 1st Hidden Layer!"
set output

plot 'flog.tsv' using ($0):13 with lines title 'neuron 1', \
     'flog.tsv' using ($0):14 with lines title 'neuron 2', \
     'flog.tsv' using ($0):15 with lines title 'neuron 3', \
     'flog.tsv' using ($0):16 with lines title 'neuron 4', \
     'flog.tsv' using ($0):17 with lines title 'neuron 5', \
     'flog.tsv' using ($0):18 with lines title 'neuron 6', \
     'flog.tsv' using ($0):8 with lines title 'error signal'


pause -1 "Fuck!"
