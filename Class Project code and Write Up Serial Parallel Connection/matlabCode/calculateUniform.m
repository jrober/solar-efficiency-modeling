function [Va, Ia, maxPower,imax,vmax,powerData] = calculateUniform(Va,temperature,shadingPercentage,numberOfCells, parallelOrSerial)

 
Ia = solar(Va,temperature,shadingPercentage);

% connect each cell together in series or parallel and recreate the IV
% curve for the solar module
if parallelOrSerial == 1
    Ia = Ia * numberOfCells;   
else
    Va = Va * numberOfCells;  
end


% calculate max power
maxPower = -1000000;
imax = 0;
vmax = 0;
powerData = zeros(size(Va));
for i=1:length(Va)
    power = Va(i) * Ia(i);
    powerData(i) = power;
    if(power > maxPower)
        maxPower = power;
        imax = Ia(i);
        vmax = Va(i);
    end        
end

% display('max power');