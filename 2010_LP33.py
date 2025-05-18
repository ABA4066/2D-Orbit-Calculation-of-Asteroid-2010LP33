import math
#2010LP33#
a=381515710.2
e=0.42
T=2458344.2343327492
p=128825856

t= float(input("Enter t (in JD units):\n"))
E=0
Ek=1000
Me=((2*math.pi)/p)*((t-T)*24*60*60)
Me = Me % (2 * math.pi)
Mep=Me/(2*math.pi)

if Me>math.pi:
    E = Me - (e / 2)

elif Me<=math.pi:
    E = Me + (e / 2)

while abs(Ek) > 1e-6:
    Ek=((E-e*math.sin(E)-Me)/(1-e*math.cos(E)))
    E = E-Ek

r= a*(1-e*math.cos(E))

v=2 * math.atan((math.sqrt((1+e)/(1-e)))*math.tan(E/2)) % (2 * math.pi)
vder=math.degrees(v)

print("Me/2pi:{}\nE:{} radians\nr:{} km\nv:{} radians\nv:{} degrees\n".format(Mep,E,r,v,vder))
