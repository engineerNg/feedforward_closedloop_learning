set title "Plot of output Layer!"
set output

plot 'flog.tsv' using ($0):19 with lines title 'neuron 1', \
     'flog.tsv' using ($0):20 with lines title 'neuron 2', \
     'flog.tsv' using ($0):21 with lines title 'neuron 3', \
     'flog.tsv' using ($0):22 with lines title 'neuron 4', \
     'flog.tsv' using ($0):23 with lines title 'neuron 5', \
     'flog.tsv' using ($0):24 with lines title 'neuron 6', \
     'flog.tsv' using ($0):8 with lines title 'error signal'

pause -1 "wait!"
