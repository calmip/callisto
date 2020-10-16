#! /usr/bin/python3

#
# This file is part of Callisto software
# Callisto helps scientists to share data between collaborators
# 
# Callisto is free software: you can redistribute it and/or modify
# it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
#  Copyright (C) 2019-2021    C A L M I P
#  callisto is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU AFFERO GENERAL PUBLIC LICENSE for more details.
#
#  You should have received a copy of the GNU AFFERO GENERAL PUBLIC LICENSE
#  along with Callisto.  If not, see <http://www.gnu.org/licenses/agpl-3.0.txt>.
#
#  Authors:
#        Thierry Louge      - C.N.R.S. - UMS 3667 - CALMIP
#        Emmanuel Courcelle - C.N.R.S. - UMS 3667 - CALMIP
#

import sys
sys.path.append('../')

import math
import Constants
import csv
import pandas as pd
import numpy as np
import scipy.signal
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


def periodogram(sig, Fs):
    wind = scipy.signal.hann(sig.shape[0])

    sig = sig - sig.mean()

    nfft = 2**(4+math.ceil(math.log2(abs(sig.shape[0]))))

    F, Pxx = scipy.signal.periodogram(sig,fs=Fs,window=wind,nfft=nfft)

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

        F, Pxx = periodogram(nofiltersig, Fs)
        axs[0, 1].loglog(F, Pxx, linewidth=0.5)

        F, Pxx = periodogram(medianfiltersig, Fs)
        axs[1, 1].loglog(F, Pxx, linewidth=0.5)



        data = {'Frequence':F, 'Puissance':Pxx}
        df = pd.DataFrame(data)

        print(df.to_csv(path_or_buf=None))


        plt.show()


if __name__ == "__main__":
    main(sys.argv[1:])
