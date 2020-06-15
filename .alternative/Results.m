function [ output_args ] = Results( flag )
smallImage = imread('Images/Source/small.png');
medImage = imread('Images/Source/med.png');
largeImage = imread('Images/Source/large.png');
figure();
subplot(1,3,1);imshow(smallImage);
subplot(1,3,2);imshow(medImage);
subplot(1,3,3);imshow(largeImage);

[resizedSMALL,initFileSizeSMALL,savedFileSizeSMALL,timeElapsedSMALL,Space_SMALL,cc_SMALL] = ProcessImage('small.png',1);
[resizedMED,initFileSizeMED,savedFileSizeMED,timeElapsedMED,Space_MED,cc_MED] = ProcessImage('med.png',1);
[resizedLARGE,initFileSizeLARGE,savedFileSizeLARGE,timeElapsedLARGE,Space_LARGE,cc_Large] = ProcessImage('large.png',1);

[outFileSizeSMALL,timeElapsedSMALL1] = loadImage('small.bin',1);
[outFileSizeMED,timeElapsedMED1] = loadImage('med.bin',1);
[outFileSizeLARGE,timeElapsedLARGE1] = loadImage('large.bin',1);

out_smallImage = imread('Images/OUTPUT/small_out.png');
out_medImage = imread('Images/OUTPUT/med_out.png');
out_largeImage = imread('Images/OUTPUT/large_out.png');
ALLINTSIZE = [initFileSizeSMALL;initFileSizeMED;initFileSizeLARGE]
ALLTE = [cc_SMALL;cc_MED;cc_Large];
figure();
plot(ALLINTSIZE,ALLTE);

if flag == 1
    figure();
    subplot(1,3,1);
    imshow(smallImage);title('Orginal Image');
    subplot(1,3,2);
    imshow(out_smallImage);title({['Compressed Image : CR:', num2str(cc_SMALL)]...
        [' SS:',num2str(Space_SMALL)]});
    subplot(1,3,3);
    diffPlot = imabsdiff(resizedSMALL,out_smallImage);
    diff = graythresh(diffPlot)*100;
    error = immse(out_smallImage, resizedSMALL)*100;
    imshow(diffPlot), title ({['Diff, mse=' num2str(error)] ['Diff=' num2str(diff)]}); 

    figure();
    subplot(1,3,1);
    imshow(medImage);title('Orginal Image');
    subplot(1,3,2);
    imshow(out_medImage);title({['Compressed Image : CR:', num2str(cc_MED)]...
        [' SS:',num2str(Space_LARGE)]});
    subplot(1,3,3);
    diffPlot = imabsdiff(resizedMED,out_medImage);
    diff = graythresh(diffPlot)*100;
    error = immse(out_medImage, resizedMED)*100;
    imshow(diffPlot), title ({['Diff, mse=' num2str(error)] ['Diff=' num2str(diff)]}); 

    figure();
    subplot(1,3,1);
    imshow(largeImage);title('Orginal Image');
    subplot(1,3,2);
    imshow(out_largeImage);title({['Compressed Image : CR:', num2str(cc_Large)]...
        [' SS:',num2str(Space_LARGE)]});
    subplot(1,3,3);
    diffPlot = imabsdiff(resizedLARGE,out_largeImage);
    diff = graythresh(diffPlot)*100;
    error = immse(out_largeImage, resizedLARGE)*100;
    imshow(diffPlot), title ({['Diff, mse=' num2str(error)] ['Diff=' num2str(diff)]}); 
end
end

