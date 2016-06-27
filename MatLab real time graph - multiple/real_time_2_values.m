delete(instrfindall);
instrfind();

s = serial('COM6', 'baudrate', 115200);
fopen(s);
fprintf(s,'*IDN?');
%out = ones(1,100);

cla;

%%hold on
%hLine = plot(0:100:0,1:200:1, 'bo');
%xLine = plot(1:200:1, 'bo');
points = 50;
data_period = 50; %data period in milliseconds
x = linspace(-points*data_period,0,points);
y = linspace(0,0,points);
y2 = linspace(0,0,points);
y3 = linspace(0,0,points);

i = 1;
p = 1;

subplot(3,1,1);
lh = area(x,y);
axis([-points*data_period,0,0,1023]);

subplot(3,1,2);
lh2 = area(x,y2);
axis([-points*data_period,0,0,1023]);

subplot(3,1,3);
lh3 = area(x,y3);
axis([-points*data_period,0,0,1023]);

shg;

while 1

    while s.BytesAvailable < 4 
    end
    bytes = s.BytesAvailable;
    %for r = 1:1:bytes
        for k = 1:1:points-1
           y(k) = y(k+1);
           y2(k) = y2(k+1);
           y3(k) = y3(k+1);
        end
    %end
    %for k = points-bytes:1:points
        low = fread(s,1)
        high = fread(s,1)
        y(k) = (bitsll(high, 8) +  low);
        
        low = fread(s,1);
        high = fread(s,1);
        y2(k) = bitsll(high, 8) + low;
        
        low = fread(s,1);
        high = fread(s,1);
        y3(k) = bitsll(high, 8) + low;
   % end
    
    value1 = y(i)
    value2 = y2(i)
    value3 = y3(i)
    
  
        
    set(lh, 'YData',y);
    set(lh2, 'YData',y2);
    set(lh3, 'YData',y3);
    %set(l1,'XData',x1, 'YData',y1);        

    drawnow;


    i = i+1;
    if( i > points)
        i = 1;
    end
    pause (0.01);
end
    

fclose(s);
delete(s);
clear s;