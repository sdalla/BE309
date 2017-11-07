%% Controlling Leg Only
devices = daq.getDevices; % set up devices
devices(2); % DEVICES TWO IS ANALOG OUTPUT

l = daq.createSession('ni');
addAnalogOutputChannel(l,'cDAQ1Mod2',0,'Voltage');

l.Rate = 8000; % set rate of scan (Hz)
l.DurationInSeconds = 5; % set time (sec)

outputSingleValue = 2;
outputSingleScan(l, outputSingleValue);

outputSignal1 = 12; % signal that we want in (Hz) -- alter output signal as needed
plot(outputSignal1);
hold on;
xlabel('Time');
ylabel('Voltage');
legend('Analog Output 0');
queueOutputData(l, outputSignal1);


%% Controlling Servo

s = daq.createSession('ni'); %creating session variable
addCounterOutputChannel(s,'myDAQ1', 0, 'PulseGeneration'); %define output channel
s.IsContinuous = true;
pwm = s.Channels(1); %only one channel
pwm.InitialDelay = 0;
pwm.Frequency = 50; %good between 50-150
pwm.DutyCycle = 0.05;
startBackground(s);

for i=.05:.01:.125
    pwm.DutyCycle = i; %good less than 1
    pause(2);
end

%startbackground(s);
