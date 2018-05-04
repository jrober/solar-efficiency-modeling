




voltageMax = 2.5;

temperature1 = 25;
numberOfCells1 = 2;
shadingPercentage1 = 100;
parallelOrSerial1 = 0;
numberOfModules1 = 1;




Vb = -4; % breakdown voltage
VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m

% iterate over each module

[Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateUniform(VaIn,temperature1,shadingPercentage1,numberOfCells1,parallelOrSerial1);



% subplot(2,1,1);
title('IV curve')

p1a = plot(Va1, Ia1,'--');
ylim([0,Inf]);
xlim([Vb,Inf]);
xlabel('Voltage [V]');
ylabel('Current [A]');
hold on;
% plot(vmax1,imax1,'r*');
% plot([Vb vmax1],[imax1 imax1],'--r');
% plot([vmax1 vmax1],[imax1 0],'--r');


% plot([Vb vmax2],[imax2 imax2],'-r');
% plot([vmax2 vmax2],[imax2 0],'-r');



% subplot(2,1,2);
% title('power curve')
% 
% p2a = plot(Va1, powerData1,'-');
% ylim([0,Inf]);
% xlim([Vb,inf]);
% xlabel('Voltage [V]');
% ylabel('Power [W]');
% hold on;
% plot(vmax1,maxPower1,'r*');

% p2b = plot(Va2, powerData2,'--');
% ylim([0,maxPower + maxPower/3]);
% xlim([Vb,vmax+vmax/1.5]);

hold on;



display(imax1);
display(vmax1);
display(maxPower1);





