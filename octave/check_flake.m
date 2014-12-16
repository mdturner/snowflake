function [valid, border] = check_flake(flake);

border=0*flake;
N=length(flake);

if (sum(flake(:,1))==0 || sum(diag(flake))==0)
    valid = false;
    if sum(flake(:,1))==0
        border(:,1)=1;
    end
    if sum(diag(flake))==0
        border=border|diag(ones(N,1));
    end
    return
end

%if flake(1)==1;
%    valid = true;
%    border = find_border(flake);
%    return
%end

connected=0*flake;
connected(find(flake)(1))=1;

old_connected = 0*flake;

while any( (old_connected~=connected)(:) )
    old_connected = connected;
    connected = connected | (find_border(connected) & flake);
end

if connected==flake
    valid = true
    border = find_border(flake);
else 
    border=find_border(flake & ~connected);
    valid = false;
end

if ~any(flake(end,:))
    valid=false;
end

stretch = repmat(~any(flake,2),1,N) & border;
stretch(1) = 0;
if any( stretch(:) )
    border = stretch;
end


