# set title "Plot of Output Layer!"
# set output
#
# plot 'flog.tsv' using ($0):25 with lines title 'neuron 1', \
#      'flog.tsv' using ($0):26 with lines title 'neuron 2', \
#      'flog.tsv' using ($0):27 with lines title 'neuron 3', \
#      'flog.tsv' using ($0):28 with lines title 'neuron 4', \
#      'flog.tsv' using ($0):29 with lines title 'neuron 5', \
#      'flog.tsv' using ($0):30 with lines title 'neuron 6', \
# #     'flog.tsv' using ($0):19 with lines title 'neuron 1 error', \
# #     'flog.tsv' using ($0):20 with lines title 'neuron 2 error', \
# #     'flog.tsv' using ($0):21 with lines title 'neuron 3 error', \
# #     'flog.tsv' using ($0):22 with lines title 'neuron 4 error', \
# #     'flog.tsv' using ($0):23 with lines title 'neuron 5 error', \
# #     'flog.tsv' using ($0):24 with lines title 'neuron 6 error', \
# #     'flog.tsv' using ($0):($9/60) with lines title 'error signal(5x)', \
# #     'flog.tsv' using ($0):34 with lines title '1st neuron 1', \
# #     'flog.tsv' using ($0):35 with lines title '1st neuron 2', \
# #     'flog.tsv' using ($0):36 with lines title '1st neuron 3', \
# #     'flog.tsv' using ($0):37 with lines title '1st neuron 4', \
# #     'flog.tsv' using ($0):38 with lines title '1st neuron 5', \
# #     'flog.tsv' using ($0):39 with lines title '1st neuron 6'
#      'flog.tsv' using ($0):42 with lines title 'v_i', \
#      'flog.tsv' using ($0):($9/60) with lines title 'error signal(5x)', \
#      'flog.tsv' using ($0):43 with lines title 'e_i', \
#      'flog.tsv' using ($0):44 with lines title 'w_ij', \
#      'flog.tsv' using ($0):45 with lines title 'sum(w_ij)'
#
plot 'flog.tsv' using ($0):1 with lines title 'error', \
     'flog.tsv' using ($0):2 with lines title 'real error', \
     'flog.tsv' using ($0):3 with lines title 'output', \
     'flog.tsv' using ($0):5 with lines title 'weight layer_1', \
     'flog.tsv' using ($0):6 with lines title 'weight layer_output'




# pause -1 "Fuck!"

#plot 'flog.tsv' using ($0):37 with lines title 'v_i', \
#     'flog.tsv' using ($0):38 with lines title 'e_i', \
#     'flog.tsv' using ($0):39 with lines title 'w_ij', \
#     'flog.tsv' using ($0):40 with lines title 'sum(w_ij)', \
#     'flog.tsv' using ($0):41 with lines title 'e_j'
#      'flog.tsv' using ($0):50 with lines title 'e_i', \
#      'flog.tsv' using ($0):51 with lines title 'e_i', \
#      'flog.tsv' using ($0):52 with lines title 'e_i', \
#      'flog.tsv' using ($0):53 with lines title 'e_i', \
#      'flog.tsv' using ($0):54 with lines title 'e_i', \
#      'flog.tsv' using ($0):55 with lines title 'e_i', \
#      'flog.tsv' using ($0):56 with lines title 'e_i', \
#      'flog.tsv' using ($0):57 with lines title 'e_i', \
#      'flog.tsv' using ($0):58 with lines title 'e_i'


pause -1 "Press any key to continue..."

