function temprature_prediction(a)
% Documentation Block
% Temprature_prediction predicts future temperature and provides LED warnings.
% Temprature_prediction(a) continuously reads temperature data from a thermistor
% It is connected to an Arduino, it converts the measured voltage to temperature,
% and estimates the rate of change between consecutive readings. Using
% this rate, the function predicts the temperature 5 minutes ahead. The
% system then evaluates whether the temperature is rising or falling too
% quickly and activates LEDs to indicate system status: green for stable
% conditions, red for rapid increase, and yellow for rapid decrease. The
% function operates in a continuous loop, providing real-time monitoring,
% prediction, and visual feedback through both LEDs and command window output.

%% CONSTANTS
RATE_LIMIT = 4/60;      
% Rate threshold (°C per second)

%% INITIAL VALUES
previoustemp = 0;           
% Stores previous temprature

time = 0;               
% Counts time

%% MAIN LOOP
while true
    
    time = time + 1;    
    % Increment time
    
    voltage = readVoltage(a,'A1');    
    % Read voltage from the sensor
    
    temperature = (voltage - 0.500) / 0.010;    
    % Converts voltage to temperature 
    
    rate = temperature - previoustemp;    
    % Rate of change of temperature
    
    predictedtemp = temperature + rate * 300;    
    % Predict temperature after 5 minutes (300 seconds)
    
    fprintf('Current Temp: %.2f °C\n', temperature);
    fprintf('Predicted Temp (5 min): %.2f °C\n\n', predictedtemp);
    % Outputs a display
    
    writeDigitalPin(a,'D2',0);
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',0);
    % Turn all LEDs OFF
    
    if rate > RATE_LIMIT
        writeDigitalPin(a,'D4',1);
        % Red LED if the temprature rises too fast
        
    elseif rate < -RATE_LIMIT
        writeDigitalPin(a,'D3',1);
        % Yellow LED if the temprature drops too fast
        
    else
        writeDigitalPin(a,'D2',1);
        % Green LED if the temprature is stable
    end
    
    previoustemp = temperature;    
    % Store current temperature
    
    pause(1);    
    % Waits 1 second
end

end