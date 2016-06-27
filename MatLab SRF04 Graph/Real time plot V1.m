delete(instrfindall);
instrfind();

s = serial('COM17', 'baudrate', 115200);
fopen(s);
fprintf(s,'*IDN?');
%out = ones(1,100);

cla;

%%hold on
%hLine = plot(0:100:0,1:200:1, 'bo');
%xLine = plot(1:200:1, 'bo');
points = 100;
data_period = 50; %data period in milliseconds
x = linspace(0,points*data_period,points);
y = linspace(0,0,points);

i = 1;
lh = area(x,y);

axis([0,points*data_period,0,150]);
shg;

while 1

    while s.BytesAvailable == 0 
    end
    bytes = s.BytesAvailable;
    for r = 1:1:bytes
        for k = 1:1:points-1
           y(k) = y(k+1);
        end
    end
    for k = points-bytes:1:points
        y(k) = fread(s,1);
    end
    
    distance = y(points)
 
    if(max(y) < 50)
        axis([0,points*data_period,0,50]);
    else
       %  axis([0,points*data_period,0,150]);
    end
  
        
    remainder = rem(i ,1);
    if( remainder == 0)
        set(lh, 'YData',y);
        %set(l1,'XData',x1, 'YData',y1);        
  
        drawnow;
    end

    i = i+1;
    if( i > points)
        i = 1;
    end
    pause (0.1);
end
    

fclose(s);
delete(s);
clear s;