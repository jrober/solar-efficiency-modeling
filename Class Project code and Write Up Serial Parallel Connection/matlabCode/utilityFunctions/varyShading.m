voltageMax = 2.5;

temperature = 25;





Vb = -4; % breakdown voltage
VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m

[Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateUniform(VaIn,temperature,0,1,1);
[Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateUniform(VaIn,temperature,50,1,1);
[Va3, Ia3, maxPower3,imax3,vmax3,powerData3] = calculateUniform(VaIn,temperature,100,1,1);

subplot(2,1,1);
title('IV curve')

p1a = plot(Va1, Ia1,'-');

xlabel('Voltage [V]');
ylabel('Current [A]');
hold on;


p1b = plot(Va2, Ia2,'--');
p1c = plot(Va3, Ia3,'-.');

legend('0% shading', '50% shading', '100% shading');

subplot(2,1,2);
title('power curve')

p2a = plot(Va1, powerData1,'-');

xlabel('Voltage [V]');
ylabel('Power [W]');
hold on;
plot(Va2, powerData2,'--');
plot(Va3, powerData3,'-.');

legend('0% shading', '50% shading', '100% shading');
