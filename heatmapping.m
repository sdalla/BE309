file = 'ext:cont copy.csv';
data = csvread(file);
rel = csvread('relax stuff.csv');

data(data == -99999) = NaN;
rel(rel==-99999) = NaN;
xvars = data(1,2:end);
relxvars = rel(1,2:end);

figure(1)
h = heatmap(xvars, 1:5, data(2:end,2:end));

h.Colormap = colormap(cool);
xlabel('Frequency (Hz)')
ylabel('Leg')
title('Leg Angle Response to Stimulation')

figure(2)
h1 = heatmap(relxvars, 1:5, rel(2:end,2:end));
h1.Colormap = colormap(cool);

xlabel('Frequency (Hz)')
ylabel('Leg')
title('Leg Relaxation Angle')

