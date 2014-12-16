function clines = join_flake(lines);

lines=round(1000*lines)/1000;

clines = {};

while length(lines)>0
    n = length(clines)+1;
    clines{n} = lines(:,:,1);
    endpoint = lines(2,:,1);
    lines=lines(:,:,2:end);
    
    found = 1;
    
    while found && size(lines,3)>1
        found=found(1);
        if( found = find(ismember(squeeze(lines(1,:,:))', endpoint, 'rows'),1) )
            clines{n} = [clines{n}; lines(2,:, found)];
            endpoint = lines(2,:,found);
            lines(:,:, found) = [];
        elseif(found = find(ismember(squeeze(lines(2,:,:))', endpoint, 'rows'),1) )
            clines{n} = [clines{n}; lines(1,:, found)];
            endpoint = lines(1,:,found);
            lines(:,:, found) = [];
        end
    end

    if isequal(lines(1,:,:),endpoint)
        clines{n} = [clines{n}; lines(2,:,:)];
        found = [];
        lines  = [];
    elseif isequal(lines(2,:,:),endpoint)
        clines{n} = [clines{n}; lines(1,:,:)];
        found = [];
        lines = [];
    end
end 	
