function lines = draw_flake(flake, offset_x, offset_y)

N=length(flake);
ystep = sqrt(3)/2;

#Create sides
sides=xor(flake(2:end,1:end-1),flake(2:end,2:end));
smask =find(sides & tril(ones(N-1)));

sX1 = repmat([0:N-2]/2, N-1, 1) - repmat([1:N-1]'/2, 1, N-1);
sX2 = sX1 + .5;

sY1 = repmat(mod([0:N-2],2)*ystep, N-1, 1) + repmat([1:N-1]'*ystep, 1, N-1);
sY2 = repmat(mod([1:N-1],2)*ystep, N-1, 1) + repmat([1:N-1]'*ystep, 1, N-1);

sides_vec=zeros(2,2,N-1,N-1);
sides_vec(1,1,:,:)=sX1;
sides_vec(2,1,:,:)=sX2;
sides_vec(1,2,:,:)=sY1;
sides_vec(2,2,:,:)=sY2;
#plot(sides_vec(:,1,fsides), sides_vec(:,2,fsides))

sides_vec = sides_vec(:,:,smask);
sides_vec_flipped = sides_vec;
sides_vec_flipped(:,1,:) = -sides_vec_flipped(:,1,:);

#Create flats
flats = xor(flake(1:end-1, 1:2:end-1), flake(2:end, 2:2:end)); 
if size(flats,2)<length(flake(end,1:2:end));
    flats(:,end+1)=0;
end
flats=[flats; flake(end, 1:2:end)];
Nflats = size(flats,2);
ftril=tril(ones(Nflats));
fmask=zeros(Nflats*2, Nflats);
fmask(1:2:end, :) = ftril;
fmask(2:2:end, :) = ftril;
fmask = fmask(1:size(flats,1), :);

fmask2 = 0*fmask;
fmask2(2:end,:) = fmask(1:end-1, :);
fmask2=find(flats & fmask2);
fmask=find(flats & fmask);

fX1 = repmat([0:2:N-1]/2, N, 1) - repmat([1:N]'/2, 1, Nflats);
fX2 = fX1 + 1;

fY = repmat(ystep*[1:N]', 1, Nflats);

flats_vec=zeros(2,2,N,Nflats);

flats_vec(1,1,:,:)=fX1;
flats_vec(2,1,:,:)=fX2;
flats_vec(1,2,:,:)=fY;
flats_vec(2,2,:,:)=fY;

flats_vec_flipped = flats_vec(:,:,fmask2); # fmask2 doesn't copy the diagonal
flats_vec_flipped(:,1,:)=-flats_vec_flipped(:,1,:);
flats_vec = flats_vec(:,:,fmask);

lines = cat( 3, sides_vec, sides_vec_flipped, flats_vec, flats_vec_flipped);
    
lines2 = lines;
theta = pi/3;
lines2(:,1,:) = cos(theta)*lines(:,1,:) - sin(theta)*lines(:,2,:);
lines2(:,2,:) = sin(theta)*lines(:,1,:) + cos(theta)*lines(:,2,:);
lines = cat( 3, lines, lines2);
lines2(:,1,:) = -lines2(:,1,:);
lines = cat( 3, lines, lines2);
lines2 = lines;
lines2(:,2,:) = -lines2(:,2,:);
lines = cat( 3, lines, lines2);

lines(:,1,:) = lines(:,1,:) + offset_x;
lines(:,2,:) = lines(:,2,:) + offset_y;


#close all
#hold on
#cellfun(@(c)plot(c(:,1),c(:,2),'k','LineWidth',2), clines );
#hold off
#axis equal
#axis off

