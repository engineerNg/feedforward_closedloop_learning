# 设置图例和标签
set xlabel "Row Number"
set ylabel "Values"

# 设置图形区域大小
set size 1,0.5

# 设置第一个绘图区域（上半部分）
set multiplot
set title "Plot of Column 1"
set autoscale y
plot 'flog.tsv' using ($0):1 with lines title 'neuron 1', \
     'flog.tsv' using ($0):2 with lines title 'neuron 2', \
     'flog.tsv' using ($0):3 with lines title 'neuron 3', \
     'flog.tsv' using ($0):4 with lines title 'neuron 4', \
     'flog.tsv' using ($0):5 with lines title 'neuron 5', \
     'flog.tsv' using ($0):6 with lines title 'neuron 6'

# 设置第二个绘图区域（下半部分）
unset title
unset xlabel
unset ylabel
set origin 0,0.5
set title "Plot of Column 2"
set autoscale y
plot 'flog.tsv' using ($0):8 with lines title 'error'

# 结束多图模式
unset multiplot
pause -1 "Hit any key to continue"
