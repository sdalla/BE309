
% update directory for every leg
files = dir('/Users/olang/Documents/MATLAB/BE309/CMI/CSVs/*.csv');
direction = input('Does this leg CONTRACT in cw or ccw direction?');
direction = strcmp('cw', direction); % cw is true, ccw is false

%Get Data from every trial
for file = files' 
    %% Trial Specific Info
    csv_filename = file.name;
    leg = str2double(csv_filename(2));
    freq = str2double(csv_filename(3:(find(csv_filename=='H')-1)));
    amp = csv_filename((find(csv_filename=='z')+1):(find(csv_filename=='V')-1));
    if (strcmp(amp, '1_5'))
        amp = 1.5;
    else
        if (strcmp(amp, '05'))
            amp = 0.5;
        else
            amp = 1;
        end
    end

    %% READ IN DATA
    csv_filepath = ['/Users/olang/Documents/MATLAB/BE309/CMI/CSVs/', csv_filename];
    data = readtable(csv_filepath);
    knee = table2array(data(1,:));
    ankle = table2array(data(2:end,:));

    %% ANALYSIS
    start = ankle(1,:); % Initial Location

    angle = zeros(length(ankle), 1);
    for i = 1:length(ankle)
        angle(i) = get_angle(knee,start,ankle(i,:),direction);
    end
    
    [ext, extind] = max(angle);
    extrel = max(angle(extind:end));
    [cont, contind] = min(angle);
    contrel = min(angle(contind:end));
    
    % IF CONTRACTS IN CCW DIR, CONTRACTIONS ARE 

    
    %{
    todo: 
    put the leg data into their own directories and re-run
    %}

    %% Append to CSV
    newrow = [leg freq amp ext extrel cont contrel];
    dlmwrite('master_data.csv',newrow,'-append');
end

function theta = get_angle(v, start, p2, dir) 
v1 = [start(1)-v(1) start(2)-v(2) 0]; % head minus tail
v2 = [p2(1)-v(1) p2(2)-v(2) 0]; % head minus tail

v1mag = sqrt(v1(1)^2 + v1(2)^2);
v2mag = sqrt(v2(1)^2 + v2(2)^2);

dotprod = dot(v1, v2);

cosineval = dotprod / (v1mag * v2mag);

theta = acos(cosineval) * 180 / pi;

if (v2mag == 0 || v1mag == 0)
    theta = 0;
end

crossprod = cross(v1,v2);
crossprod = crossprod(3);
if ((dir == 1 && crossprod < 0) || (dir == 0 && crossprod > 0)) 
    theta = -theta;
end

end



