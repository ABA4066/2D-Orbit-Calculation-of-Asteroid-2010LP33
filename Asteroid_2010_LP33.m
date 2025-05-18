%%2010LP33
clc
clear
a=381515710.2;
e=0.42;
T=2458344.2343327492;
p=128825856;
t=input("Enter t (in JD units):");
Me=mod(((2*pi)/p)*((t-T)*24*60*60), 2*pi);
Mep=Me/(2*pi);
E=0;
Ek=1000;
if Me>pi
    E = Me - (e / 2);
elseif Me<=pi
    E = Me + (e / 2);
end    
while abs(Ek) > 10^-6
    Ek=((E-e*sin(E)-Me)/(1-e*cos(E)));
    E = E-Ek;
end
r= a*(1-e*cos(E));

v=mod(2 * atan((sqrt((1+e)/(1-e)))*tan(E/2)), 2*pi);
vder = mod(rad2deg(v), 360);
fprintf("Me/2pi:%f\nE:%f radians\nr:%f km\nv:%f radians\nv:%f degrees\n",Mep,E,r,v,vder);