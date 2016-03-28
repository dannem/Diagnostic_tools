% testing what is reconstructed better: average or extremes.

%% 1. inputs
load('/Users/dannem/Dropbox/CompNeuroLab/EEG Reconstruction/Recon_Percept_Exp/Stimuli/ims.mat')
%% 2. computing average face and distance
happIm=double(imCell2double(ims(1:59),2));
neutIm=double(imCell2double(ims(60:end),2));
averHappIm=mean(happIm,2);
averNeutIm=mean(neutIm,2);
distHapp=sqrt(sum((double(happIm)-repmat(averHappIm,1,59)).^2,1));
distNeut=sqrt(sum((double(neutIm)-repmat(averNeutIm,1,59)).^2,1));

%% 3. plotting distance
figure 
subplot(2,1,1)
bar(distHapp)
title('Happy images distance from mean image')
subplot(2,1,2)
bar(distNeut)
title('Neut images distance from mean image')

%% 4. computing correlation with accuracy
corNeutL_10=corr(aver_im_neutL10,distNeut')
corNeut_10=corr(aver_im_neut10,distNeut')
corNeutL_IO=corr(aver_im_neutLIO,distNeut')
corNeut_IO=corr(aver_im_neutIO,distNeut')

%% 5. computing inverse distance 
for i=1:size(happIm,2)
    newind=setdiff([1:size(happIm,2)],i);
    happID(i)=sum(1./(sqrt(sum((repmat(happIm(:,i),1,size(happIm,2)-1)-happIm(:,newind)).^2,1))));
    neutID(i)=sum(1./(sqrt(sum((repmat(neutIm(:,i),1,size(neutIm,2)-1)-neutIm(:,newind)).^2,1))));
end

%% 6. computing correlation between distance and inverse distance
corrDisNeut=corr(distNeut',neutID')

%% 7. regression of accuracy by distance and inverse distance
[b,se,pval,inmodel,stats,nextstep,history]=...
    stepwisefit([neutID' distNeut'],aver_im_neut10,'penter',0.05,'premove',0.10);

%% 8. exploring stimului face space neutral stimuli
neutIm=imCell2double(ims(1:60),2);
maxVal=length(ims)/2;
vecInd=nchoosek(1:maxVal,2);
outputVal=zeros(maxVal);
for i=1:length(vecInd)
    a=double(neutIm(:,vecInd(i,1)));
    b=double(neutIm(:,vecInd(i,2)));
    outputVal(vecInd(i,1),vecInd(i,2))=sqrt(sum((a-b).^2));
    outputVal(vecInd(i,2),vecInd(i,1))=sqrt(sum((a-b).^2));
    
end
conf=outputVal;
conf=conf./max(max(conf));% to make them from 0 to 1;

[loadAll,~,per1,comprt,z]=...
    patMDS(conf,20,0.0001,[1:59]);

%% 9. computing origin image and distance based on origin. 
%     FOR HASAN: load confusability matrices of all conditions and ims.

maxVal=length(ims)/2;
conf=conf_behavioural;
[loadAll,~,per1,comprt,z]=patMDS(conf,20,0.0001,[1:59]);
var=double(imCell2double(ims(60:118),2));% choosing neutral. 
% var=double(imCell2double(ims(1:59),2));%choosing happy
orig=sqrt(sum(loadAll.^2, 2)); %distance
orig_norm=orig.*(1/sum(orig, 1)); %normalized distance
orig_norm_im=sum(var.*repmat(reshape(orig_norm,1,maxVal),size(var,1),1),2); % creating origin image
distVar=sqrt(sum((double(var)-repmat(orig_norm_im,1,maxVal)).^2,1));
