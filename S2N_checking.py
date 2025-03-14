from openpiv import tools, pyprocess, validation, filters, scaling, preprocess
import numpy as np
import matplotlib.pyplot as plt
import os
from openpiv.tools import imread

# Define base path
base_path = '<insert input path>'
file_a = 'xx.tif'
file_b = 'xx.tif'


# Construct paths
path_a = os.path.join(base_path, file_a)
path_b = os.path.join(base_path, file_b)

# Validate paths
if not os.path.exists(path_a):
    raise FileNotFoundError(f"File {path_a} does not exist.")
if not os.path.exists(path_b):
    raise FileNotFoundError(f"File {path_b} does not exist.")

# Read images
frame_a = tools.imread(path_a)
frame_b = tools.imread(path_b)

# PIV parameters
winsize = 55
searchsize = 60
overlap = 30
dt = 1 #sec

u0, v0, sig2noise = pyprocess.extended_search_area_piv(
    frame_a, #.astype(np.int32)
    frame_b, # .astype(np.int32)
    window_size=winsize,
    overlap=overlap,
    dt=dt,
    search_area_size=searchsize,
    sig2noise_method='peak2peak',
)

plt.hist(sig2noise.flatten())

# Plot histogram with population count annotations and black borders on bins
plt.figure(figsize=(30, 6))
counts, bins, patches = plt.hist(sig2noise.flatten(), bins=200, color="blue", alpha=0.7, edgecolor="black", linewidth=1.2)

# Annotate bin population counts
for count, bin_edge in zip(counts, bins[:-1]):
    plt.text(bin_edge, count, str(int(count)), ha="center", va="bottom", fontsize=8, rotation=0)

# Adjust X-axis tick intervals
min_snr = np.min(bins)
max_snr = np.max(bins)
tick_interval = (max_snr - min_snr) / 20  # Smaller intervals for finer control
plt.xticks(np.arange(min_snr, max_snr, tick_interval), rotation=45, fontsize=10)  # Rotate labels for better readability

plt.xlabel("Signal-to-Noise Ratio")
plt.ylabel("Frequency")
plt.title("Histogram of Signal-to-Noise Ratio with Population Counts & Black Bin Borders")
plt.grid(True)
plt.show()

