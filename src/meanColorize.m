function meanColorMask = meanColorize(rgbImage, mask, tolerance)
    
    ycbcrImage = rgb2ycbcr(im2double(rgbImage));

    Y = ycbcrImage(:, :, 1); 
    Cb = ycbcrImage(:, :, 2); 
    Cr = ycbcrImage(:, :, 3); 
    
    Ymean = mean(Y(mask));
    Cbmean = mean(Cb(mask));
    Crmean = mean(Cr(mask));

    rows = size(rgbImage, 1);
    columns = size(rgbImage, 2);
    
    deltaY = Y - Ymean * ones(rows, columns);
    deltaCb = Cb - Cbmean * ones(rows, columns);
    deltaCr = Cr - Crmean * ones(rows, columns);
    
    delta = sqrt(deltaY.^2 + deltaCb.^2 + deltaCr.^2);

    meanMaskedDeltaE = mean(delta(mask));
    
    meanColorMask = (delta >= meanMaskedDeltaE - tolerance) & ...
                    (delta <= meanMaskedDeltaE + tolerance);
    
end
