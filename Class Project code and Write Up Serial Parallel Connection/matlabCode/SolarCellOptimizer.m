
function SolarCellOptimizer

    
    

    testing = 0;
    voltageMax = 2.5;
    
    if testing == 1

        temperature = 25;
        numberOfCells = 1;
        shadingPercentage = 100;
        parallelOrSerial = 0;
        numberOfModules = 1;
    
    else
        data = xlsread('inputs\Fast Flexible Filling Design 5000 4 factor.xlsx');
        temperature = data(:,1);
        numberOfCells = data(:,2);
        shadingPercentage = data(:,3);
        parallelOrSerial = data(:,4);
        numberOfModules = length(parallelOrSerial);
        
    end
    
    
    Vb = -4; % breakdown voltage
    VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m
    
    % iterate over each module
    for i=1:numberOfModules
        [Va, Ia, maxPower,imax,vmax,powerData] = calculateUniform(VaIn,temperature(i),shadingPercentage(i),numberOfCells(i),parallelOrSerial(i));
        data(i,5) = vmax;
        data(i,6) = imax;
        data(i,7) = maxPower;
        
    end
    
    % this can be used to generate the IV curves for a single cell
    if testing == 1
        subplot(2,1,1);
        title('IV curve')

        plot(Va, Ia);
        ylim([0,imax+imax/3]);
        xlim([Vb,vmax+vmax/1.5]);
        xlabel('Voltage [V]');
        ylabel('Current [A]');
        hold on;
        plot(vmax,imax,'r*');
        plot([Vb vmax],[imax imax],'--r');
        plot([vmax vmax],[imax 0],'--r');



        subplot(2,1,2);
        title('power curve')

        p2b = plot(Va, powerData);
        ylim([0,maxPower + maxPower/3]);
        xlim([Vb,vmax+vmax/1.5]);
        xlabel('Voltage [V]');
        ylabel('Power [W]');
        hold on;
        plot(vmax,maxPower,'r*');

    else
        % write out data to a file
        csvwrite('outputs\Fast Flexible Filling Design 5000 4 factor_results 2.csv',data)
        
        % plot the last module
        subplot(2,1,1);
        title('IV curve for the last module')

        plot(Va, Ia);
%         ylim([-10,10]);
%         xlim([Vb,Inf]);
        xlabel('Voltage [V]');
        ylabel('Current [A]');


        subplot(2,1,2);
        title('power curve for the last module')

        plot(Va, powerData);
%         ylim([-5,5]);
%         xlim([Vb,Inf]);
        xlabel('Voltage [V]');
        ylabel('Power [W]');
    end
    display(imax);
    display(vmax);
    display(maxPower);
    
    

end