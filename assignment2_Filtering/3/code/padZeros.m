function[outputImage]=padZeros(Neighbourhood,patchsize)

ns=size(Neighbourhood);
ps=floor(patchsize);
outputImage=zeros(ns+ps-1);
outputImage(floor(ps/2)+1:end-floor(ps/2),floor(ps/2)+1:end-floor(ps/2))=Neighbourhood;

end