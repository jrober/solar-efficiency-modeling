voltageMax = 2.5;

temperature = 25;





Vb = -4; % breakdown voltage
VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m

[Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateUniform(VaIn,temperature,0,1,1);
[Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateUniform(VaIn,temperature,100,1,1);

subplot(2,1,1);
title('IV curve')

p1a = plot(Va1, Ia1,'-');

xlabel('Voltage [V]');
ylabel('Current [A]');
hold on;
plot([Va2(454) Va1(463)],[Ia2(454) Ia1(463)],'r-.');
plot([Va2(454) Va1(463)],[Ia2(454) Ia1(463)],'r-.');
plot(Va2(454), Ia2(454) ,'r*');
plot(Va1(463),Ia1(463),'r*');


p1b = plot(Va2, Ia2,'--');


legend([p1a p1b], {'0% shading', '100% shading'});

subplot(2,1,2);
title('IV curve')

p2a = plot(Va1, Ia1,'-');

xlabel('Voltage [V]');
ylabel('Current [A]');
hold on;
p2b = plot(Va2, Ia2,'--');
plot([Va2(461) Va1(461)],[Ia2(461) Ia1(461)],'r-.');
plot([Va2(461) Va1(461)],[Ia2(461) Ia1(461)],'r-.');
plot(Va2(461), Ia2(461) ,'r*');
plot(Va1(461),Ia1(461),'r*');


legend([p2a p2b],{'0% shading', '100% shading'});
