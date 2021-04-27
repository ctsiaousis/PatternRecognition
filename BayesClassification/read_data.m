function [digit_C1_indices,digit_C2_indices,digit_C1_images,digit_C2_images] = read_data(dataX,dataY)

images = zeros(size(dataX, 1), 28, 28);
labels = zeros(size(dataY.', 1), 1);

for i = 1:size(dataX, 1)
    img = dataX(i, :);
    images(i, :, :) = reshape(img, 28, 28)';
    labels(i) = dataY(i);
end

digit_C1_indices = find(labels == 1); % digit 1
digit_C2_indices = find(labels == 2); % digit 2

digit_C1_images = images(digit_C1_indices, :, :);
digit_C2_images = images(digit_C2_indices, :, :);

end