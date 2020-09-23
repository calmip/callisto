import sys
sys.path.append('../')

import math
import Constants
import csv
import pandas as pd
import numpy as np
import scipy.signal
import scipy.fft
import matplotlib.pyplot as plt


def burst_process(sig,Fc,tt):
    sig = sig - sig.mean()
    yy = sig / math.sqrt(sig.var())
    YY = np.fft.fft(yy)

    fe = 1/(tt.values[1]-tt.values[0])

    dF = fe / len(yy)

    deb_burst = int(np.fix(Fc/dF)-3)
    fin_burst = len(sig)-deb_burst+3

    YY_c = YY
    YY_c[0:deb_burst-2] = 0
    YY_c[fin_burst:] = 0

    x_c = np.fft.ifft(YY_c)
    burst = x_c.real

    #fft_HF = YY_c

    return burst


# filtering = 0 -> zero mean, no filtering
# filtering != 0 -> zero mean, 1-D median filtering
def signal(s, tt, filtering):

    if filtering == 0:
        sig = burst_process(s,Constants.Fc,tt)
    else:
        sig = scipy.signal.medfilt(s-s.mean(),kernel_size=1)


    return sig


def fft(sig, Fs):
    dF = Fs / sig.shape[0]
    wind = scipy.signal.hann(sig.shape[0])

    sig = sig - sig.mean()

    nfft = 2**(1+math.ceil(math.log2(abs(sig.shape[0]))))

    F = Fs / 2.0*np.linspace(0,1,nfft)

    YY = scipy.fft(sig, nfft)
    Pxx = (YY * np.conj(YY)) / sig.shape[0]
    Pxx[1:-2] = 2*Pxx[1:-2]
    Pxx = 10*np.log(Pxx/4e-10)


    return F, Pxx



def main(argv):
    for arg in argv:
        df = pd.read_csv(arg, sep='  ', header=None)
        tt = df.iloc[23999:, 0]
        s = df.iloc[23999:, 1]



        nofiltersig = signal(s, tt, 0);
        medianfiltersig = signal(s, tt, 1);
        fig, axs = plt.subplots(2, 2, figsize=(5, 5))
        axs[0, 0].plot(tt.values, nofiltersig)
        axs[1, 0].plot(tt.values, medianfiltersig)

        Fs = tt.values[1] - tt.values[0]



        F, Pxx = fft(nofiltersig, Fs)
        axs[0, 1].semilogx(F, Pxx, linewidth=0.5)

        F, Pxx = fft(medianfiltersig, Fs)
        axs[1, 1].semilogx(F, Pxx, linewidth=0.5)

        data = {'Frequence':F, 'Puissance':Pxx}
        df = pd.DataFrame(data)

        print(df.to_csv(path_or_buf=None))
        #plt.show()


if __name__ == "__main__":
    main(sys.argv[1:])
