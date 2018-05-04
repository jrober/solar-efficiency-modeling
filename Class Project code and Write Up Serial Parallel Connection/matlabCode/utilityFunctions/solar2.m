
function Ia = solar(Va,Irad,TaC,shadingPerc)
    % Ia,Va = current and voltage vectors [A] and [V]
    % G = nominal irradiance 1000W/m^2 https://us.sunpower.com/sites/sunpower/files/media-library/spec-sheets/sp-sunpower-maxeon-solar-cells-gen2.pdf
    % T = temperature of the cell [C]
%     G = 1000;
%     
%     Vg = 1.12; % Voltage  of the Crystaline Silicon [eV], 1.75eV for Amorphous Silicon
%     Tdatasheet = 25;
%     T1 = 273 + Tdatasheet; % Normalised temperature [K]
%     Irad = Irad * (1 - shadingPerc/100);
% 
%     % Sunpower A300's values
%     Voc_T1 = 0.680; % Open-current voltage at T1 [V]. Peak performance Maxeon Gen 2 solar cells https://us.sunpower.com/sites/sunpower/files/media-library/spec-sheets/sp-sunpower-maxeon-solar-cells-gen2.pdf
%     Isc_T1 = 6.35; % Peak performance Maxeon Gen 2 solar cells https://us.sunpower.com/sites/sunpower/files/media-library/spec-sheets/sp-sunpower-maxeon-solar-cells-gen2.pdf
%     K0 = .0026; % Current/Temperature coefficient [A/K]. See above data sheet
%     dVdI_Voc = -0.00985; % dV/dI coefficient at Voc [A/V]. See SunpowerCurves.xlsx
    
    % These equations are sourced from 
    % 1. Maximum power point tracking of partially shaded solar photovoltaic arrays Shubhajit Roy Chowdhury,
    % Hiranmay Sahan

    % 2. Model of Photovoltaic Module in Matlab™ Francisco M. González-Longatt
    % 3. partially shaded solar photovoltaic arrays Shubhajit Roy Chowdhury,
    % Hiranmay Sahan
    TaK = 273 + TaC; % Convert cell's temperature from Celsius to Kelvin [K]
%     IL_T1 = Isc_T1 * Irad/G; % Compute IL depending on total irradiance. Equation (9)
%     IL = IL_T1 + K0*(TaK - T1); % Apply the temperature effect. Equation (8) corrected by source 2
%     I0_T1 = Isc_T1/(exp(q*Voc_T1/(n*k*T1))); % Equation (12) note: the 1 is negligible and corrected by source 2
%     I0 = I0_T1*(TaK/T1).^(3/n).*exp(-q*Vg/(n*k).*((1./TaK)-(1/T1))); % Equation (11)
%     Xv = I0_T1*q /(n*k*T1) * exp(q*Voc_T1/(n*k*T1)); % Equation (14)
%     Rs = - dVdI_Voc - 1/Xv; %Compute the Rs Resistance. Equation (13)
    
    Rs = 1.33;
    IL = 30;
    I0 = 5500;
    k = 1.38e-23; % Boltzmann constant [J/K]
    q = 1.60e-19; % Elementary charge [C]
    n = 1.5; % Quality factor for the diode []. n=2 for crystaline, <2 for amorphous
    Vt_Ta = n * k * TaK / q; % Equation (2) from source 3
    Ia = zeros(size(Va)); %Initialize Ia vector
    C = 1/Vt_Ta;
    Beta = 3.7;
    Vb = -4;
    Rp = 750;
    a = 0.1;
    
    % Compute Ia with Newton method
    for j=1:5;
        Ia = Ia - (IL - Ia - I0.*( exp((Va+Ia.*Rs).*C) -1) - ((Va + Ia.*Rs)./Rp).*(1 + a .*(1- (Va + Rs.*Ia)./Vb).^(-Beta)))./...
            (-1 - (I0.*( exp((Va+Ia.*Rs).*C))).*Rs.*C - ((Va + Rs.*Ia)./Rp .* (Beta .* a .* (1 - (Va + Rs.*Ia)./Vb).^(-Beta-1).*(Rs/Vb)) +  Rs/Rp .* (1 + a .* (1 - ((Va + Rs.*Ia)./Vb).^(-Beta))    )    ));
    end
%     for i=1:length(Va)
%        Ia(i) =  
%     end
end