function [outGen,outZero] =zeroPixelValue(ims,imNum,pixVal,plotOn)
temp=double(imCell2double(ims,4));
temp=squeeze(temp(:,:,:,imNum));
ch1=squeeze(temp(:,:,1));
ch2=squeeze(temp(:,:,2));
ch3=squeeze(temp(:,:,3));
ch1(ch1==pixVal)=0;
ch1(ch1~=pixVal)=255;
ch2(ch2==pixVal)=0;
ch2(ch2~=pixVal)=255;
ch3(ch3==pixVal)=0;
ch3(ch3~=pixVal)=255;

outGen{1,1}='mean';
outGen{2,1}='std';
outGen{3,1}='min';
outGen{4,1}='max';
outGen{5,1}='#pixVal';
outGen{6,1}='#255'

outGen{1,2}=mean(mean(temp(:,:,1)));
outGen{1,3}=mean(mean(temp(:,:,2)));
outGen{1,4}=mean(mean(temp(:,:,3)));
newtemp1=temp(:,:,1);
newtemp2=temp(:,:,2);
newtemp3=temp(:,:,3);
outGen{2,2}=std(newtemp1(:));
outGen{2,3}=std(newtemp2(:));
outGen{2,4}=std(newtemp3(:));
outGen{3,2}=min(min(temp(:,:,1)));
outGen{3,3}=min(min(temp(:,:,2)));
outGen{3,4}=min(min(temp(:,:,3)));
outGen{4,2}=max(max(temp(:,:,1)));
outGen{4,3}=max(max(temp(:,:,2)));
outGen{4,4}=max(max(temp(:,:,3)));
% finding indices of zeros
[a1,b1]=find(temp(:,:,1)==pixVal);
[a2,b2]=find(temp(:,:,2)==pixVal);
[a3,b3]=find(temp(:,:,3)==pixVal);
[c1,d1]=find(temp(:,:,1)==255);
[c2,d2]=find(temp(:,:,2)==255);
[c3,d3]=find(temp(:,:,3)==255);
outZero{1,1}=[a1 b1];
outZero{1,2}=[a2 b2];
outZero{1,3}=[a3 b3];


outGen{5,2}=size(a1,1);
outGen{5,3}=size(a2,1);
outGen{5,4}=size(a3,1);
outGen{6,2}=size(c1,1);
outGen{6,3}=size(c2,1);
outGen{6,4}=size(c3,1);
if plotOn
figure
subplot(2,2,1)
imshow(uint8(temp))
title('Original')
subplot(2,2,2)
imshow(ch1)
title('Channel 1')
subplot(2,2,3)
imshow(ch2)
title('Channel 2')
subplot(2,2,4)
imshow(ch3)
title('Channel 3')
else
end


