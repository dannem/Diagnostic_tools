output=[];
for i=1:size(lwdata,2)
    temp1=str2num(lwdata(i).header.name(findstr('bck',lwdata(i).header.name)+5:findstr('bck',lwdata(i).header.name)+6)); 
    temp2=str2num(lwdata(i).header.name(findstr('idn',lwdata(i).header.name)+4:findstr('bck',lwdata(i).header.name)-1));
    output(temp1,temp2)=size(lwdata(i).data,1);
end