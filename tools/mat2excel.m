function mat2excel(data)
    load([data,'.mat']); 
	excel_name = [data,'.xlsx'];
    xlswrite(excel_name, {'psnr_ori_arr'}, 1, 'A2:A2');
    xlswrite(excel_name, psnr_ori_arr, 1, 'B2:I2');
    xlswrite(excel_name, {'psnr_cut_arr'}, 1, 'A3:A3');
    xlswrite(excel_name, psnr_cut_arr, 1, 'B3:I3');
    xlswrite(excel_name, {'psnr_drop_arr'}, 1, 'A4:A4');
    xlswrite(excel_name, psnr_drop_arr, 1, 'B4:I4');
    xlswrite(excel_name, {'alpha_ori_arr'}, 1, 'A5:A5');
    xlswrite(excel_name, alpha_ori_arr, 1, 'B5:I5');
    xlswrite(excel_name, {'alpha_cut_arr'}, 1, 'A6:A6');
    xlswrite(excel_name, alpha_cut_arr, 1, 'B6:I6');
    xlswrite(excel_name, {'alpha_drop_arr'}, 1, 'A7:A7');
    xlswrite(excel_name, alpha_drop_arr, 1, 'B7:I7');
    xlswrite(excel_name, {'one_avg_ori_arr'}, 1, 'A8:A8');
    xlswrite(excel_name, one_avg_ori_arr, 1, 'B8:I8');
    xlswrite(excel_name, {'one_avg_cut_arr'}, 1, 'A9:A9');
    xlswrite(excel_name, one_avg_cut_arr, 1, 'B9:I9');
    xlswrite(excel_name, {'one_avg_drop_arr'}, 1, 'A10:A10');
    xlswrite(excel_name, one_avg_drop_arr, 1, 'B10:I10');
end