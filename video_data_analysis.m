

% INPUT
csv_filename = 'L2700Hz1Vpp.csv';

% Video Specific Info
leg = str2num(csv_filename(2));
freq = str2num(csv_filename(3:(find(csv_filename=='H')-1)));
amp = str2num(csv_filename((find(csv_filename=='z')+1):(find(csv_filename=='V')-1)));

% READ IN DATA
csv_filepath = ['/Users/olang/Documents/MATLAB/BE309/CMI/CSVs/', csv_filename];
data = readtable(csv_filepath);
knee = table2array(data(1,:));
ankle = table2array(data(2:end,:));

% ANALYSIS
start = ankle(1,:); % Initial Location

% GET MAXIMUM EXTENSION
[~, indmaxext] = max(ankle(:,1));
max_ext = ankle(indmaxext, :);

% GET RELAXATION AFTER EXTENSION
[~, indextrelax] = min(ankle(indmaxext:end,1));
ext_relax = ankle(indextrelax, :);

% GET MAXIMUM CONTRACTION
[~, indmaxcont] = min(ankle(:,1));
max_cont = ankle(indmaxcont, :);

% GET RELAXATION AFTER CONTRACTION
[~, indcontrelax] = max(ankle(indmaxcont:end,1));
cont_relax = ankle(indcontrelax, :);

%% Finding Angles

% Extension:
ext = get_angle(knee, start, max_ext);
extrel = get_angle(knee, start, ext_relax);
cont = get_angle(knee, start, max_cont);
contrel = get_angle(knee, start, cont_relax);


%% Append to CSV
newrow = [leg freq amp ext extrel cont contrel];
dlmwrite('master_data.csv',newrow,'-append');

function theta = get_angle(v, p1, p2) 
a = sqrt((v(1) - p1(1))^2 + (v(2) - p1(2))^2);
b = sqrt((v(1) - p2(1))^2 + (v(2) - p2(2))^2);
c = sqrt((p1(1) - p2(1))^2 + (p1(2) - p2(2))^2);

theta = acos((a^2 + b^2 - c^2)/(2*a*b));
end



