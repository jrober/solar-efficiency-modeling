




voltageMax = 2.5;

temperature = 25;
shadingPercentages1 = [0 50];
parallelOrSerial1 = 0;





Vb = -4; % breakdown voltage
VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m

% iterate over each module

[Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateNonUniform(VaIn,temperature,shadingPercentages1,parallelOrSerial1);



shadingPercentages2 = [0 50];
parallelOrSerial2 = 1;


[Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateNonUniform(VaIn,temperature,shadingPercentages2,parallelOrSerial2);

subplot(2,1,1);
title('IV curve')

p1a = plot(Va1, Ia1,'-');
% ylim([0,imax+imax/3]);
% xlim([Vb,vmax+vmax/1.5]);
xlabel('Voltage [V]');
ylabel('Current [A]');
hold on;
plot(vmax1,imax1,'r*');
% plot([Vb vmax1],[imax1 imax1],'-r');
% plot([vmax1 vmax1],[imax1 0],'-r');

p1b = plot(Va2, Ia2,'--');
% ylim([0,imax+imax/3]);
% xlim([Vb,vmax+vmax/1.5]);
hold on;
plot(vmax2,imax2,'r*');
% plot([Vb vmax2],[imax2 imax2],'-r');
% plot([vmax2 vmax2],[imax2 0],'-r');

legend([p1a p1b],{'Series Connection', 'Parallel Connection'});

subplot(2,1,2);
title('power curve')

p2a = plot(Va1, powerData1,'-');
% ylim([0,maxPower + maxPower/3]);
% xlim([Vb,vmax+vmax/1.5]);
xlabel('Voltage [V]');
ylabel('Power [W]');
hold on;
plot(vmax1,maxPower1,'r*');

p2b = plot(Va2, powerData2,'--');
% ylim([0,maxPower + maxPower/3]);
% xlim([Vb,vmax+vmax/1.5]);

hold on;
plot(vmax2,maxPower2,'r*');

legend([p2a p2b],{'Series Connection', 'Parallel Connection'});

display(imax1);
display(vmax1);
display(maxPower1);

display(imax2);
display(vmax2);
display(maxPower2);



