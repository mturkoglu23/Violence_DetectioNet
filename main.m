clear;clc;
% % layer ='fc1000';
% % net = densenet201;
net=alexnet;
layer='fc6';
% % net1 = resnet101;
% % net2 = resnet101;
% % net3=efficientnetb0;
% % layer1='efficientnet-b0|model|head|dense|MatMul';
% % net3=inceptionresnetv2;
% % layer1='predictions';
% 
dataFolder ="E:\New Studies\tevfik çalışma\uygulamalar\uygulama\dataset\hockey";
[files,labels] = hmdb51Files(dataFolder);

uzunluk=length(files)
for idx=1:uzunluk
    idx
filename = files(idx);
video = VideoReader(filename);
vidwidth=video.Width;
vidheight=video.Height;
mov=struct('cdata',zeros(vidheight,vidwidth,3,'uint8'),'colormap',[]);

k=1;
while hasFrame(video)
    img{k}=readFrame(video);
k=k+1;
end

kk=length(img);
tt=ceil(kk/5);
% [rr]=randperm(kk,5);

m=1;
for i=1:tt:length(img)
    xxx=img{i};
    img1=imresize(xxx,[227 227]);
    features(:,m) = activations(net,img1,layer);
%     features1(:,m) = activations(net1,img1,layer);
    m=m+1;
end

feat_den{idx,1}=features;
% feat_res{idx,1}=features1;

end

%%
for ii=1:1000
      aa=feat_den{ii};
      for jj=1:4096
      xx(jj,1)=mean(abs(aa(jj,:)));
      end
feat(:,ii)=xx;
end
label=double(labels);
ff1=[feat',label];

%%
for ii=1:1000
      aa=feat_den{ii};
      for jj=1:4096
      xx(jj,1)=std(abs(aa(jj,:)));
      end
feat(:,ii)=xx;
end
label=double(labels);
ff2=[feat',label];

%%
for ii=1:1000
      aa=feat_den{ii};
      xx1=reshape(aa,[],1);
fusion(:,ii)=xx1;
end
ff3=[fusion',label];
