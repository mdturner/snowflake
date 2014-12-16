function border=find_border(flake);

N=length(flake);
mask=tril(ones(N));

#Find the border
border=zeros(N);
border(:,2:end)=flake(:,1:end-1);
border(:,1:end-1)=border(:,1:end-1) | flake(:,2:end);
border(2:end, 2:2:end)=border(2:end, 2:2:end) | flake(1:end-1, 1:2:end-1);
border(1:end-1, 1:2:end-1)=border(1:end-1, 1:2:end-1) | flake(2:end, 2:2:end);
border=border & !flake & mask;
