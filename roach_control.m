

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

s = daq.createSession('ni');
addAnalogInputChannel(s,'cDAQ1Mod1', 0, 'Voltage');
addCounterOutputChannel(s,'cDAQ1Mod5', 0, 'PulseGeneration');

pwm = s.Channels(2);
pwm.InitialDelay = 0;
pwm.IsContinuous = 1; %true

s.startBackground;
