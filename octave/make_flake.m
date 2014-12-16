function flake=make_flake(N, P, F, M)
#clear

#N=10; # Radius in cells
#P=.2;  # Prefill ratio
#F=.1; # Minimum fill ratio
#M=.8; # Maximum fill ratio

S=F*N*(N+1)/2; # Number of fills

flake=ones(N);

while sum(flake(:))>M*N*(N+1)/2
    valid = false;
    if P==0
        n = ceil(N*rand);
        flake(:) = 0;
        flake(n,n)=1;
    else
        flake = tril(rand(N)<P);
    end
    #flake

    while ((~valid) || sum(flake(:))<S)
        [valid, border] = check_flake(flake);
        if (valid && sum(flake(:))>=S)
            break
        end
        
        avail=find(border);
        n_avail = length(avail);
        flake( avail( ceil(n_avail*rand()) ) )=1;
        
    #    border
    #    pause
    #    flake
    end
end

#flake
