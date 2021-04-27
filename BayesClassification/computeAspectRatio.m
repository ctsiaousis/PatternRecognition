function aRatio = computeAspectRatio(image)
    % Fill your code
    
    img_row_vector = sum(image, 2);
    img_col_vector = sum(image, 1);
    row = find(img_row_vector, 1, 'first');  
    last_row = find(img_row_vector, 1, 'last');
    col = find(img_col_vector, 1, 'first');  
    last_col = find(img_col_vector, 1, 'last');
    
    height = last_row-row+1;
    width = last_col-col+1;
    aRatio = width/height;

end

