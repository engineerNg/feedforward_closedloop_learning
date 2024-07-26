import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import iirfilter, lfilter

# Generate impulse signal
def impulse_signal(length, position):
    signal = np.zeros(length)
    signal[position] = 1
    return signal

# Design bandpass filter
def bandpass_filter(fc, Q, fs):
    b, a = iirfilter(N=2, Wn=[fc - fc/(2*Q), fc + fc/(2*Q)], rs=60,
                     btype='band', analog=False, ftype='butter', fs=fs)
    return b, a

# Apply filter
def apply_filter(signal, b, a):
    return lfilter(b, a, signal)

# Find zero-crossings
def find_zero_crossings(signal1, signal2):
    diff = signal1 - signal2
    zero_crossings = np.where(np.diff(np.sign(diff)))[0]
    return zero_crossings

# Set parameters
fs = 1000.0  # Sampling frequency
duration = 5.0  # Duration of the signal
t = np.arange(0, duration, 1.0/fs)  # Time array
impulse = impulse_signal(len(t), len(t)//2)  # Impulse signal
Q = 0.51

# Define bandpass filter center frequencies (fc)
fc_values = [0.3, 0.2, 0.1]  # Excluding 0.5 and 0.4

# Create figure
plt.figure(figsize=(14, 10))  # Increase figure size for better clarity

# Line styles for different filters
line_styles = ['-', '--', '-.', ':']
filtered_signals = []

# Plot filtered signals
for i, fc in enumerate(fc_values):
    b, a = bandpass_filter(fc, Q, fs)
    filtered_signal = apply_filter(impulse, b, a)
    filtered_signal /= np.max(np.abs(filtered_signal))  # Normalize the output
    filtered_signals.append(filtered_signal)
    
    label = f'fc = {fc} Hz'
    plt.plot(t, filtered_signal, color='black', linestyle=line_styles[i], label=label)
    
    # Add label next to the curve with larger font size
    label_x_pos = t[int(len(t) * 0.7)]  # Change the x position to avoid overlap
    label_y_pos = filtered_signal[int(len(t) * 0.7)]  # Corresponding y position
    plt.text(label_x_pos, label_y_pos, label, color='black', fontsize=16, 
             verticalalignment='bottom', horizontalalignment='left', weight='bold')

# Plot zero-crossings between the pairs of signals
cross_pairs = [(0, 1), (1, 2)]
for (i, j) in cross_pairs:
    zero_crossings = find_zero_crossings(filtered_signals[i], filtered_signals[j])
    for zc in zero_crossings:
        plt.axvline(x=t[zc], color='gray', linestyle='--')
        # Add the x-axis coordinate
        plt.text(t[zc], -0.4, f'{t[zc]:.3f}s', color='gray', fontsize=14,
                 verticalalignment='top', horizontalalignment='center')

# Add titles and labels with increased font size
plt.title('Impulse Response of Bandpass Filters', fontsize=20, weight='bold')
plt.xlabel('Time [s]', fontsize=18, weight='bold')
plt.ylabel('Normalized Amplitude', fontsize=18, weight='bold')
plt.xticks(fontsize=16)  # Increase x-axis tick label font size
plt.yticks(fontsize=16)  # Increase y-axis tick label font size
plt.grid(True)
plt.legend(fontsize=16)  # Increase legend font size
plt.ylim([-0.5, 1.1])  # Adjust y-axis limits for better visibility
plt.tight_layout()
plt.savefig('impulse_response_combined_with_current_error_and_crossings.eps', format='eps')
plt.show()
