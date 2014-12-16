N=8; # Radius in cells
P=0.1;  # Prefill ratio
F=.1; # Minimum fill ratio
M=.5; # Maximum fill ratio

D=2*N+1; # Flake spacing

R = 4;
C = 4;

more off;

Lines = [];

for r=1:R
    for c=1:C
#        N=N+1;
        
        offset_x = (c-1)*D;
        offset_y = (r-1)*D;
        flake = make_flake(N, P, F, M);
        lines = draw_flake(flake, offset_x, offset_y);
        clines = join_flake(lines);
        disp('flake');
               
        if r*c==1
            Lines = clines; 
        else
            Lines = cat(2, Lines, clines);
        end
    end
end

close all
hold on
cellfun(@(c)plot(c(:,1),c(:,2),'k','LineWidth',2), Lines );
hold off
axis equal
axis off

filename = ['flakes.' num2str(R) 'x' num2str(C) '.' datestr(now,30) '.svg'];
print(filename, '-dsvg');
