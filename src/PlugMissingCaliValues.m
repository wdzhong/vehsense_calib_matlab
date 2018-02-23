function [ valid_cali_profiles_comp ] = PlugMissingCaliValues( valid_cali_profiles_comp )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here

[num_rows_valid_cali,num_cols_valid_cali] = size(valid_cali_profiles_comp);

for i=1:num_rows_valid_cali
    if(valid_cali_profiles_comp(i,10)==0)
        k=1;
        while(k<=num_rows_valid_cali)
            if(valid_cali_profiles_comp(k,10)~=0)
                valid_cali_profiles_comp(i,10) = valid_cali_profiles_comp(k,10);
                valid_cali_profiles_comp(i,11) = valid_cali_profiles_comp(k,11);
                valid_cali_profiles_comp(i,12) = valid_cali_profiles_comp(k,12);
                valid_cali_profiles_comp(i,13) = valid_cali_profiles_comp(k,13);
                break;
                
            end
            k = k+1;
        end
    end
end

end

