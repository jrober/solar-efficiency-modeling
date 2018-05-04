function [Vglobal, Iglobal, maxPower,imax,vmax,powerData] = calculateNonUniform(Va,temperature,shadingPercentages, parallelOrSerial)

Icc = 6.35; % Closed Circuit Current (A)
Voc = 0.680; % Open Circuit Voltage (V)
numCells = length(shadingPercentages);
Iamat = zeros(numCells, length(Va));
Vb = -4;


for i=1:numCells
   
Iamat(i,:) = solar(Va,temperature,shadingPercentages(i));
 
end

% serial hook up
if parallelOrSerial == 0
    Imax = Icc;
    Imin = 0;
    Iglobal = Imin:.01:Imax;
    Vglobal = zeros(1,length(Iglobal));
    % iterate through each cell and find the voltage of each cell given
    % the current value, then add up all voltages
    
    %for each I global, add up the voltages to get the Vglobal
    
    for i=1:length(Iglobal)
        voltages = zeros(numCells,1);
        for j=1:numCells
            Iatemp = Iamat(j,:);
            flag = 0; % used if the Ia value isn't found
            k = 1;
            flag = 0;
            % iterate over the individual cells iv curve to find the
            % voltage at a given current value
            while Iglobal(i) < Iatemp(k) && flag == 0
               voltages(j) = Va(k);
               if k == length(Iatemp)
                  flag = 1;
                  display('issue finding current value');
                  display(Iglobal(i));
               end
               k = k+1;
            end
        end
        Vglobal(i) = sum(voltages);
    end           
    
% parallel hook up
else
    Vmax = Voc;
    Vmin = 0;
    Vglobal = Vmin:.01:Vmax;
    Iglobal = zeros(1,length(Vglobal));
    % iterate through each cell and find the voltage of each cell given
    % the current value, then add up all voltages
    
    %for each I global, add up the voltages to get the Vglobal
    
    for i=1:length(Vglobal)
        currents = zeros(numCells,1);
        for j=1:numCells
            Iatemp = Iamat(j,:);
            flag = 0; % used if the Ia value isn't found
            k = 1;
            flag = 0;
            % iterate over the individual cells iv curve to find the
            % voltage at a given current value
            while Vglobal(i) > Va(k) && flag == 0
               currents(j) = Iatemp(k);
               if k == length(Va)
                  flag = 1;
                  display('issue finding voltage value');
                  display(Vglobal(i));
               end
               k = k+1;
            end
        end
        Iglobal(i) = sum(currents);
    end      

end

% calculate max power
maxPower = -1000000;
imax = 0;
vmax = 0;
powerData = zeros(size(Vglobal));
for i=1:length(Vglobal)
    power = Vglobal(i) * Iglobal(i);
    powerData(i) = power;
    if(power > maxPower)
        maxPower = power;
        imax = Iglobal(i);
        vmax = Vglobal(i);
    end        
end

% display('max power');