#function flake=makeflake(N,P)

N=10; # Radius in cells
P=.5; # Fill ratio
S=ceil(P*N*(N+1)/2); # Number of steps

flake=zeros(N);

border = tril(ones(N));

for s=1:S
    if prod(sum(flake(2:end,:),2))==0
        force_move=repmat(sum(flake,2)==0,1,N).*border;
        if force_move
            border=force_move;
            border(1)=0;
        end
    end
    avail=find(border);
    n_avail = length(avail);
    flake( avail( ceil(n_avail*rand()) ) )=1;
    border=find_border(flake);
#    flake
end

if sum(flake(:,1))*sum(diag(flake))==0
    valid = false;
#    clear flake;
else
    valid = true;
end


