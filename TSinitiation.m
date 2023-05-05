function [SET]=TSinitiation(trstartET,crtntrstartET,corrET,incorrET)
temp1=sort([trstartET; crtntrstartET]);
temp2=sort([corrET; incorrET]);
temp3=zeros(length(temp2),1);

if length(temp1)>length(temp2)
    temp1(end)=[];
end
for n=1:length(temp2)
    
    if isempty(find(corrET==temp2(n), 1))==0
    temp4(n)=find(corrET==temp2(n));
    else
        temp4(n)=0;
    end
end
temp5=(temp4>0)';
SET=[temp1 temp2 temp5];

end
