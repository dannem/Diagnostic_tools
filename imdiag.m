function out=imdiag(ims)
%this funtion takes a cell array of images and provides average, std, min,
%max per color channel per image
for i=1:size(ims1,1)
    temp=double(ims1{1});
    colmean1=temp(:,:,1);
    colmean2=temp(:,:,2);
    colmean3=temp(:,:,3);
    colmean1=colmean1(:);
    colmean2=colmean2(:);
    colmean3=colmean3(:);
    out(1,i)=mean(colmean1);
    out(2,i)=mean(colmean2);
    out(3,i)=mean(colmean3);
    out(4,i)=std(colmean1);
    out(5,i)=std(colmean2);
    out(6,i)=std(colmean3);
    out(7,i)=min(colmean1);
    out(8,i)=min(colmean2);
    out(9,i)=min(colmean3);
    out(10,i)=max(colmean1);
    out(11,i)=max(colmean2);
    out(12,i)=max(colmean3);
end
    