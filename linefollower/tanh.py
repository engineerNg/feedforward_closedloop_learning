#! /usr/bin/python3

import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-2, 2, 400)
y = np.tanh(x)

plt.plot(x, y, label='tanh(x)')
plt.plot(x, x, label='x (linear)', linestyle='dashed')
plt.axvline(x=-1, color='gray', linestyle='dotted')
plt.axvline(x=1, color='gray', linestyle='dotted')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Comparison of tanh(x) and x')
plt.legend()
plt.grid(True)
plt.show()

