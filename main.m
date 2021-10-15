clear;clc;
net=alexnet;
layer='fc6';

dataFolder ="...\Movie dataset";
[files,labels] = hmdb51Files(dataFolder);

uzunluk=length(files);
for idx=1:uzunluk
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
tt=ceil(kk/10);

m=1;
for i=1:tt:length(img)
    xxx=img{i};
    img1=imresize(xxx,[227 227]);
    features(:,m) = activations(net,img1,layer);
    m=m+1;
end

feat_alex{idx,1}=features;

end

%% feature average pooling approach
for ii=1:200
      aa=feat_alex{ii};
      for jj=1:4096
      xx(jj,1)=mean(abs(aa(jj,:)));
      end
feat(:,ii)=xx;
end
label=double(labels);
ff1=[feat',label];

%% feature standard pooling approach
for ii=1:200
      aa=feat_alex{ii};
      for jj=1:4096
      xx(jj,1)=std(abs(aa(jj,:)));
      end
feat(:,ii)=xx;
end
label=double(labels);
ff2=[feat',label];

%% feature fusion approach
for ii=1:200
      aa=feat_alex{ii};
      xx1=reshape(aa,[],1);
fusion(:,ii)=xx1;
end
ff3=[fusion',label];

%% fc+relu+fc+softmax (classification process)

