import sys
import matplotlib.pyplot as plt
x = []
y = []
for line in input_file.readlines():
    x.append(line.split(":")[0])
    y.append(line.split(":")[1])
plt.plot(x, y, 'x', color='black');
plt.savefig('ExempleService3_results.png')

