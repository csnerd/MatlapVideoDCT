video = VideoReader('Tiger.mp4');

wVideo = VideoWriter('img\\myVideo.avi');
wVideo.FrameRate =1;
wcVideo = VideoWriter('com\\myVideo.avi');
wcVideo.FrameRate =1;

open(wVideo);
open(wcVideo);

v = read(video,[1 5]);
back = imread('back.png');
for i = 1:5
    frame = v(:,:,:,i);
    for a = 1:size(frame,1)
        for b = 1:size(frame,2)
            if(frame(a,b,1) <= 120 &&frame(a,b,2) >= 150 && frame(a,b,3)<=120)
                frame(a,b,1) = back(a,b,1);
                frame(a,b,2) = back(a,b,2);
                frame(a,b,3) = back(a,b,3);
            end
        end
    end
    imwrite(frame,strcat('.\\img\\img',int2str(i),'.png'));
    writeVideo(wVideo,frame);
    cframe = compress(frame);
    imwrite(cframe,strcat('.\\com\\img',int2str(i),'.png'));
    writeVideo(wcVideo,cframe);
end

close(wVideo);
close(wcVideo);


