
function NonUniformOptimizer

    testing = 0;
    voltageMax = 2.5;
    numberOfModules = 1;
    temperature = 25;
    
    if testing == 1

        
        shadingPercentage = [0 50];

    
    else
        data = xlsread('inputs\shadingInputs36.xlsx');
        shadingPercentage = data(:,1);    
    end
    
    
    Vb = -4; % breakdown voltage
    VaIn = (Vb+.05):.01:voltageMax; % this voltage range is specific for the cell modeled in solar.m
    

    % iterate over each module
    if testing == 1
        [Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateNonUniform(VaIn,temperature,shadingPercentage,1);
        [Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateNonUniform(VaIn,temperature,shadingPercentage,0);
   
    else
        for i=1:numberOfModules
            [Va1, Ia1, maxPower1,imax1,vmax1,powerData1] = calculateNonUniform(VaIn,temperature,shadingPercentage,1);
            [Va2, Ia2, maxPower2,imax2,vmax2,powerData2] = calculateNonUniform(VaIn,temperature,shadingPercentage,0);
%             data(i,5) = vmax;
%             data(i,6) = imax;
%             data(i,7) = maxPower;
        end
    end
    
    % this can be used to generate the IV curves for a single cell
%     if testing == 1
        subplot(2,1,1);
        title('IV curve')

        p1a = plot(Va1, Ia1);
        ylim([0,imax1+imax1/3]);
        xlim([Vb,vmax1+vmax1/1.5]);
        xlabel('Voltage [V]');
        ylabel('Current [A]');
        hold on;
        plot(vmax1,imax1,'r*');
        plot(vmax2,imax2,'r*');
        p1b = plot(Va2, Ia2,'--');
%         plot([Vb vmax1],[imax1 imax1],'--r');
%         plot([vmax1 vmax1],[imax1 0],'--r');
%         legend('1 cell','2 cells in series');
        legend([p1a p1b],{'parallel module', 'series module'});


        subplot(2,1,2);
        title('power curve')

        p2a = plot(Va1, powerData1);

        xlabel('Voltage [V]');
        ylabel('Power [W]');
        hold on;
        p2b = plot(Va2, powerData2);
        plot(vmax1,maxPower1,'r*');
        plot(vmax2,maxPower2,'r*');
        legend([p2a p2b],{'parallel module', 'series module'});
% legend([p2a p2b],{'1 cell', '2 cells in series'});
%     else
        % write out data to a file
%         csvwrite('outputs\Fast Flexible Filling Design 5000 4 factor_results.csv',data)
        
        % plot the last module
%         subplot(2,1,1);
%         title('IV curve for the last module')
% 
%         plot(Va, Ia);
% %         ylim([-10,10]);
% %         xlim([Vb,Inf]);
%         xlabel('Voltage [V]');
%         ylabel('Current [A]');
% 
% 
%         subplot(2,1,2);
%         title('power curve for the last module')
% 
%         plot(Va, powerData);
% %         ylim([-5,5]);
% %         xlim([Vb,Inf]);
%         xlabel('Voltage [V]');
%         ylabel('Power [W]');
%     end
    display(imax1);
    display(vmax1);
    display(maxPower1);
    
    display(imax2);
    display(vmax2);
    display(maxPower2);
    
    

end