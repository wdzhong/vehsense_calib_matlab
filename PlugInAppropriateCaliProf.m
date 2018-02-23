function [ valid_cali_profiles_comp ] = PlugInAppropriateCaliProf( valid_cali_profiles_comp,still_phase_data_comp,move_phase_data_mean_lin_acc_comp )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_valid_cali,num_cols_valid_cali] = size(valid_cali_profiles_comp);
[num_rows_still_phase,num_cols_still_phase] = size(still_phase_data_comp);
for i=1:num_rows_valid_cali
    validity_prof = valid_cali_profiles_comp(i,9);
    mov_strt_ind = valid_cali_profiles_comp(i,5);
    mov_end_ind = valid_cali_profiles_comp(i,7);
    
    if(validity_prof==1)
        for j=1:num_rows_still_phase
            still_strt_ind = still_phase_data_comp(j,1);
            still_end_ind = still_phase_data_comp(j,2);
            still_strt_time = still_phase_data_comp(j,3);
            still_end_time = still_phase_data_comp(j,4);
            
            if(mov_strt_ind==still_end_ind+1)
                valid_cali_profiles_comp(i,1)=still_strt_ind;
                valid_cali_profiles_comp(i,2)=still_strt_time;
                valid_cali_profiles_comp(i,3)=still_end_ind;
                valid_cali_profiles_comp(i,4)=still_end_time;
                break;
            else
                if(mov_strt_ind==move_phase_data_mean_lin_acc_comp(1,1))
                    valid_cali_profiles_comp(i,1)=still_strt_ind;
                    valid_cali_profiles_comp(i,2)=still_strt_time;
                    valid_cali_profiles_comp(i,3)=still_end_ind;
                    valid_cali_profiles_comp(i,4)=still_end_time;
                    break;
                end
            
            end
        end
      valid_cali_profiles_comp(i,10)=valid_cali_profiles_comp(i,5);
      valid_cali_profiles_comp(i,11)=valid_cali_profiles_comp(i,6);
      valid_cali_profiles_comp(i,12)=valid_cali_profiles_comp(i,7);
      valid_cali_profiles_comp(i,13)=valid_cali_profiles_comp(i,8);
    else
        for j=1:num_rows_still_phase
            still_strt_ind = still_phase_data_comp(j,1);
            still_end_ind = still_phase_data_comp(j,2);
            still_strt_time = still_phase_data_comp(j,3);
            still_end_time = still_phase_data_comp(j,4);
            
            if(mov_strt_ind==still_end_ind+1)
                valid_cali_profiles_comp(i,1)=still_strt_ind;
                valid_cali_profiles_comp(i,2)=still_strt_time;
                valid_cali_profiles_comp(i,3)=still_end_ind;
                valid_cali_profiles_comp(i,4)=still_end_time;
                break;
            else
                if(mov_strt_ind==move_phase_data_mean_lin_acc_comp(1,1))
                    valid_cali_profiles_comp(i,1)=still_strt_ind;
                    valid_cali_profiles_comp(i,2)=still_strt_time;
                    valid_cali_profiles_comp(i,3)=still_end_ind;
                    valid_cali_profiles_comp(i,4)=still_end_time;
                    break;
                end
            
            end
        end
        
        k=i-1;
        
        while(k>=1)
            
            if(valid_cali_profiles_comp(k,9)==1)
                valid_cali_profiles_comp(i,10)=valid_cali_profiles_comp(k,5);
                valid_cali_profiles_comp(i,11)=valid_cali_profiles_comp(k,6);
                valid_cali_profiles_comp(i,12)=valid_cali_profiles_comp(k,7);
                valid_cali_profiles_comp(i,13)=valid_cali_profiles_comp(k,8);
                break;
            end
            k=k-1;
        end
        
    end
    
    
    
end

end

