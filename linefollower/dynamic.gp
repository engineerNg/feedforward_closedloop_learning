#! /usr/bin/gnuplot-qt

plot 'flog.tsv' using ($0):1 with lines title 'error', \
     'flog.tsv' using ($0):2 with lines title 'predict_error', \
     'flog.tsv' using ($0):3 with lines title 'output_weight', \
     'flog.tsv' using ($0):4 with lines title 'network_error', \
     'flog.tsv' using ($0):7 with lines title 'error_input'
#     'flog.tsv' using ($0):5 with lines title 'control_input_l', \
#     'flog.tsv' using ($0):6 with lines title 'control_input_r', \


pause -1

  

