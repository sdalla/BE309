file = 'ext:cont copy.csv';
data = csvread(file);

data(data == -99999) = NaN;
xvars = data(1,2:end);

cmap = colormap(spring);
h = heatmap(xvars, 1:5, data(2:end,2:end));
xlabel('Frequency (Hz)')
ylabel('Leg')
title('Leg Angle Response to 1Vpp Stimulation')