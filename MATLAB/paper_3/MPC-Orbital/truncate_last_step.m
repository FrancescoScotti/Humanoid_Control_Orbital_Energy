function [tout1,out1] = truncate_last_step(tout,out,zf)
    flag=1;
    j = 1;
    while flag == 1
        if out(j,3)-zf<1e-4 && out(j,1)<1e-4 && out(j,2)<1e-4
            tout1 = tout(1:j-1);
            out1 = out(1:j-1,:);
            break;
        end
        j=j+1;
    end

end

