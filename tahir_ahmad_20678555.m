% Tahir Ahmad
% egyta10@nottingham.ac.uk
%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]
a=arduino('com5','uno');
% Defining variable to comunicate to arduino
for blink = 1:15
    writeDigitalPin(a,"D2",1);
    pause(0.5),
    writeDigitalPin(a,"D2",0);
    pause(0.5);
end
% Loop for the LED to blink 15 times with 0.5 sec intervals
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
duration = 600;
% Defined the duration 10 minutes/600 sec
time = 0:1:duration;
% Created a time array
temprature = zeros(size(time));
% For efficiency preallocated temprature array
% Data acquisition loop
for d_a_l = 1:length(time)
    voltage = readVoltage(a,'A1');
    % This would read voltage from sensor analog pin A1
    temprature(d_a_l) = (voltage - 0.500)/0.010;
    % This converts the voltage to temprature, equation from datasheet
    pause(1);
    % Pauses for 1 sec between readings
end

% Statistical Analysis
mintemp = min(temprature);
% Minimum temprature that was recored
maxtemp = max(temprature);
% Maximum temprature that was recorded
avgtemp = mean(temprature);
% Average temprature that was recorded

% Plotting
figure
plot(time,temprature)
xlabel('time(s)')
ylabel('temprature(°C)')
title('temprature vs time graph')
saveas(gcf,'temprature_vs_time_graph.png');
% Saves the image of the graph

% Output to cmd window
fprintf('Data logging starts\n\n');
% Header printed
for d_a_l = 1:10
    index = d_a_l * 60;
    % This will calculate index for each minute
    fprintf('minute\t\t%d\n', d_a_l);
    fprintf('temperature\t%.2f C\n\n', temprature(index));
end 
% This will print data every minute

% Summary Statistics
fprintf('Maximum temp\t%.2f C\n', maxtemp);
fprintf('Minimum temp\t%.2f C\n', mintemp);
fprintf('Average temp\t%.2f C\n\n', avgtemp);
fprintf('Data logging ends\n');

% Writing data into a text file
fileID = fopen('capsule_temperature.txt','w');
% Opens file to write on
fprintf(fileID,'Temperature Log\n\n');
% Heading
for d_a_l = 1:10
    
    index = d_a_l * 60;
    
    fprintf(fileID,'minute %d\n', d_a_l);
    fprintf(fileID,'temperature %.2f C\n\n', temprature(index));
end
% This will write data by each minute
fprintf(fileID,'Maximum temp %.2f C\n', maxtemp);
fprintf(fileID,'Minimum temp %.2f C\n', mintemp);
fprintf(fileID,'Average temp %.2f C\n', avgtemp);
% This will write the statistics
fclose(fileID);
% Closes the file
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.