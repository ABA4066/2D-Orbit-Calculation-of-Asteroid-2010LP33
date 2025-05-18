clc;
clear;

a = 381515710.2;   
e = 0.42;          
T = 2458344.2343327492; 
p = 128825856;     
t = 2458344.2343327492:10:2459835.2743327493 ; 

Me = mod(((2*pi)/p)*((t - T)*24*60*60), 2*pi); 
Mep = Me / (2*pi); 

n = length(Me);     
E = zeros(1, n);    
r = zeros(1, n);   
v = zeros(1, n);  
vder = zeros(1, n); 

for i = 1:n
    if Me(i) > pi
        E(i) = Me(i) - (e / 2);
    else
        E(i) = Me(i) + (e / 2);
    end

    Ek = 1000;
    while abs(Ek) > 1e-6
        Ek = (E(i) - e * sin(E(i)) - Me(i)) / (1 - e * cos(E(i)));
        E(i) = E(i) - Ek;
    end

    r(i) = a * (1 - e * cos(E(i)));

    v(i) = mod(2 * atan(sqrt((1+e)/(1-e)) * tan(E(i)/2)), 2*pi);
    vder(i) = mod(rad2deg(v(i)), 360);
end
fig = figure;
polarplot(deg2rad(vder), r, 'b.-');
title("2010LP33'nın Yörüngesi")

dcm = datacursormode(fig);
set(dcm, 'UpdateFcn', @(obj, event) showTime(event, vder, t));

function output_txt = showTime(event_obj, v_angles_deg, t_times)
    pos = get(event_obj, 'Position');  
    clicked_deg = rad2deg(pos(1));    
    
    [~, idx] = min(abs(v_angles_deg - mod(clicked_deg, 360)));
    clicked_t = t_times(idx);
    
    date_str = datestr(datetime(clicked_t, 'convertfrom', 'juliandate'), 'dd-mmm-yyyy HH:MM:SS');
    
    output_txt = {
        sprintf('\\nu: %.2f°', v_angles_deg(idx)), ...
        sprintf('r: %.2f km', pos(2)), ...
        sprintf('JD: %.6f', clicked_t), ...
        ['Tarih: ', date_str]
    };
end
