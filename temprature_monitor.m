function temprature_monitor(a)
% TEMPERATURE_MONITOR - Reads temperature from Thirmistor, plots in real time,
% It controls LEDs based on temperature thresholds.
% Input a (Arduino object)

%% High and Low tempreture
low_temp = 18;    
high_temp = 24;     

%% SETUP PLOT
figure
h = plot(0,0);                    
xlabel('time (s)')
ylabel('temperature (°C)')
title('Real-Time temperature monitoring')
% Starts Plot
time = 0;   
% Counts time

%% MAIN LOOP
while true
    
    time = time + 1;
    % Change in time
    
    %% SENSOR Voltage
    voltage = readVoltage(a, 'A1'); 
    % Reads voltage from the sensor

    %% CONVERT VOLTAGE TO TEMPERATURE 
    temperature = (voltage - 0.500) / 0.010;
    
    %% DISPLAY TEMPERATURE
    fprintf('temperature: %.2f °C\n', temperature);
    
    x = get(h,'XData');
    y = get(h,'YData');
    set(h,'XData',[x time], 'YData',[y temperature]);
    drawnow
    % Plot Updated
    
    %% LED CONTROL LOGIC
    
    writeDigitalPin(a,'D2',0);   % Green
    writeDigitalPin(a,'D3',0);   % Red
    writeDigitalPin(a,'D4',0);   % Yellow
 % This will turn all LEDs OFF first
    % Check temperature range
    if temperature >= low_temp && temperature <= high_temp
        writeDigitalPin(a,'D2',1);
        % For normal tempreture green light stays on
    elseif temperature < low_temp
        writeDigitalPin(a,'D4',1);
        pause(0.5);
        writeDigitalPin(a,'D4',0);
        % If its too cold yellow LED will blink
    else   
        writeDigitalPin(a,'D3',1);
        pause(0.25);
        writeDigitalPin(a,'D3',0);
    end
    % If it's too hot red LED will blink
    pause(1);
    % Waits 1 second before next reading
end

end