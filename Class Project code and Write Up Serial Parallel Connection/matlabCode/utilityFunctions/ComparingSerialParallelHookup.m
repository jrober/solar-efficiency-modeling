



voltageMax = 2.5;




temperature = 25;
shadingPercentage = [0 100];
parallelOrSerial = 0;




Vb = -4; % breakdown voltage
VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m

iter = 1;
% iterate over each module

[Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateNonUniform(VaIn,temperature,shadingPercentage,1);
[Va1a, Ia1a, maxPower1a,imax1a,vmax1a,powerData1a] = calculateUniform(VaIn,temperature,shadingPercentage(1),1,1);
[Va1b, Ia1b, maxPower1b,imax1b,vmax1b,powerData1b] = calculateUniform(VaIn,temperature,shadingPercentage(2),1,1);

[Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateNonUniform(VaIn,temperature,shadingPercentage,0);
[Va2a, Ia2a, maxPower2a,imax2a,vmax2a,powerData2a] = calculateUniform(VaIn,temperature,shadingPercentage(1),1,1);
[Va2b, Ia2b, maxPower2b,imax2b,vmax2b,powerData2b] = calculateUniform(VaIn,temperature,shadingPercentage(2),1,1);


subplot(2,1,1);
title('IV curve')

plot(Va1, Ia1, '-');
hold on;
plot(Va1a, Ia1a, '--');
plot(Va1b, Ia1b, '-.');

xlabel('Voltage [V]');
ylabel('Current [A]');
legend('parallel connected module','0% shaded cell','100% shaded cell');




subplot(2,1,2);
title('IV curve')

plot(Va2, Ia2, '-');
hold on;
plot(Va2a, Ia2a, '--');
plot(Va2b, Ia2b, '-.');

xlabel('Voltage [V]');
ylabel('Current [A]');
legend('series connected module','0% shaded cell','100% shaded cell');

figure(2);
plot(Va1b, Ia1b);

xlabel('Voltage [V]');
ylabel('Current [A]');



display('parallel');
display(imax1);
display(vmax1);
display(maxPower1);

display('serial');
display(imax2);
display(vmax2);
display(maxPower2);
    
    
