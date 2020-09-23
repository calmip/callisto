import math

gamma = 1.4 #heat capacity ratio
R = 287 # specific gas constant for air (in J.kg^(-1).K^(-1))
T = 261.2153 # freestream temperature (in K)
Ma = 0.78 # freestream mach number
cs = math.sqrt(gamma*R*T) # freestream speed of sound (in m/s)
U = Ma*cs # freestream flow velocity (in m/s)
c = 0.15 # chord length (in m)
Fc = 0
f0 = 15.6 # fundamental frequency (enter 0 to plot no harmonics)
harmNbr = 2 #  number of harmonics

