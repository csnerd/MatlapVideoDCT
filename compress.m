function cframe = compress(iframe)

    c = iframe;
    imgycbcr = rgb2ycbcr(iframe);
    Y = imgycbcr(:,:,1);
    Cb = imgycbcr(:,:,2);
    Cr = imgycbcr(:,:,3);
%     imshow(imgycbcr);
    
    D = 8;
    T = dctmtx(D);
    %dct = @(block_struct) T * block_struct.data * T';
    Y = im2double(Y);
    Cb = im2double(Cb);
    Cr = im2double(Cr);
    BY = blkproc(Y,[D D],'P1*x*P2',T,T');
    BCb = blkproc(Cb,[D D],'P1*x*P2',T,T');
    BCr = blkproc(Cr,[D D],'P1*x*P2',T,T');
    mask = [1   1   1   1   0   0   0   0
            1   1   1   0   0   0   0   0
            1   1   0   0   0   0   0   0
            1   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0];
    
    B2Y = blkproc(BY,[D D],'P1.*x',mask);
    B2Cb = blkproc(BCb,[D D],'P1.*x',mask);
    B2Cr = blkproc(BCr,[D D],'P1.*x',mask);
    
    I2Y = blkproc(B2Y,[D D],'P1*x*P2',T',T);
    I2Cb = blkproc(B2Cb,[D D],'P1*x*P2',T',T);
    I2Cr = blkproc(B2Cr,[D D],'P1*x*P2',T',T);

    imgycbcr(:,:,1) = im2uint8(I2Y);
    imgycbcr(:,:,2) = im2uint8(I2Cb);
    imgycbcr(:,:,3) = im2uint8(I2Cr);
    cframe = ycbcr2rgb(imgycbcr);
%     imtool(imgycbcr);
end