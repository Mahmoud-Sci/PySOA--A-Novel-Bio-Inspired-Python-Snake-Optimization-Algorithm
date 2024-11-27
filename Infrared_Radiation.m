function IR = Infrared_Radiation(lighting,Amp_temp)
h=6.62607015e-34;
c=2.998e8;      %M/S
kb=(1.380649*10^(-23)) * (9/5); %by J/F
%The temperature of prey's body  by fahrenheit
Tp=104;
%The wavelength of infrared radiation of Python
lam=32*10^-6;
c1=2*h*c^2;
c2=(h*c)/(lam*kb);
J=(Amp_temp*lighting);
B=(c1/lam^5)*(1/(exp(c2/Tp)-1));
IR=J*B;
IR=1+(IR-0)*9/(745.4497-0);
end


