//
//  ViewController.m
//  canvas
//
//  Created by Natalia Souza on 4/29/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "ViewController.h"

#import "PBJVision.h"
#import "PBJVisionUtilities.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <GLKit/GLKit.h>

@interface ViewController ()<UIGestureRecognizerDelegate,PBJVisionDelegate,UIAlertViewDelegate>{ 
    
    int countImage;
    NSURL *directoryURL;
    NSString *documentsDirectoryPath;
    NSMutableArray *images;
    AVAssetWriterInputPixelBufferAdaptor *adaptor;
    NSString *documentsDirectory;
    AVAssetWriter *videoWriter;
    AVAssetWriterInput* writerinput;
    NSTimer *timer;
    unsigned long frameCount;
    
    //gravação da camera frontal
    UIView *_captureDock;
    
    UIView *_previewView;
    AVCaptureVideoPreviewLayer *_previewLayer;
    GLKViewController *_effectsViewController;
    
    UILabel *_instructionLabel;
    UIView *_gestureView;
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
    UITapGestureRecognizer *_focusTapGestureRecognizer;
    UITapGestureRecognizer *_photoTapGestureRecognizer;
    
    BOOL _recording;
    
    ALAssetsLibrary *_assetLibrary;
    __block NSDictionary *_currentVideo;
    __block NSDictionary *_currentPhoto;
}

@end

@implementation ViewController

int record = 1;

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    countImage = 0;
    //[self startCapture];
    
    
    //gravação da camera frontal
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    
    // preview and AV layer
    _previewView = [[UIView alloc] initWithFrame:CGRectZero];
    _previewView.backgroundColor = [UIColor blackColor];
    CGRect previewFrame = CGRectMake(0, 60.0f, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame));
    _previewView.frame = previewFrame;
    _previewLayer = [[PBJVision sharedInstance] previewLayer];
    _previewLayer.frame = _previewView.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_previewView.layer addSublayer:_previewLayer];
    
    if ([[PBJVision sharedInstance] supportsVideoFrameRate:120]) {
        // set faster frame rate
    }
    PBJVision *vision = [PBJVision sharedInstance];
    vision.cameraDevice = vision.cameraDevice == PBJCameraDeviceBack;
    [self _startCapture];
    
    [super viewDidLoad];
}

//gravação da camera frontal
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _resetCapture];
    [[PBJVision sharedInstance] startPreview];
}

//gravação da camera frontal
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[PBJVision sharedInstance] stopPreview];
}
//------------------------------------------gravação da camera frontal------------------------------------------------------------------
- (void)_startCapture
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //NSLog(@"Antes do StartVideoCapture");
    [[PBJVision sharedInstance] startVideoCapture];
    //NSLog(@"Depois do StartVideoCapture");
}

- (void)_pauseCapture
{
    [[PBJVision sharedInstance] pauseVideoCapture];
}

- (void)_resumeCapture
{
    [[PBJVision sharedInstance] resumeVideoCapture];
}

- (void)_resetCapture
{
    PBJVision *vision = [PBJVision sharedInstance];
    vision.delegate = self;
    
    vision.cameraDevice = PBJCameraDeviceFront;
    
    vision.cameraMode = PBJCameraModeVideo;
    //vision.cameraMode = PBJCameraModePhoto; // PHOTO: uncomment to test photo capture
    vision.cameraOrientation = PBJCameraOrientationPortrait;
    vision.focusMode = PBJFocusModeContinuousAutoFocus;
    vision.outputFormat = PBJOutputFormatSquare;
    vision.videoRenderingEnabled = YES;
    vision.additionalCompressionProperties = @{AVVideoProfileLevelKey : AVVideoProfileLevelH264Baseline30}; // AVVideoProfileLevelKey requires specific captureSessionPreset
    
    // specify a maximum duration with the following property
    // vision.maximumCaptureDuration = CMTimeMakeWithSeconds(5, 600); // ~ 5 seconds
}


- (void)_endCapture
{
    //[self stopCapture];
    [self performSelector:@selector(_EndCaptureHandler) withObject:nil afterDelay:2.0 ];
    [self _EndCaptureHandler];
}
- (void)_EndCaptureHandler{
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [[PBJVision sharedInstance] endVideoCapture];
    _effectsViewController.view.hidden = YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self _resetCapture];
}

#pragma mark - PBJVisionDelegate

// session

- (void)visionSessionWillStart:(PBJVision *)vision
{
    
}

- (void)visionSessionDidStart:(PBJVision *)vision
{
    //NSLog(@"Inicio do SessionDidStart");
    //NSLog(@"Final do SessionDidStart");
}

- (void)visionSessionDidStop:(PBJVision *)vision
{
    [_previewView removeFromSuperview];
}

// preview

- (void)visionSessionDidStartPreview:(PBJVision *)vision
{
    NSLog(@"Camera preview did start");
    
}

- (void)visionSessionDidStopPreview:(PBJVision *)vision
{
    NSLog(@"Camera preview did stop");
}

// device

- (void)visionCameraDeviceWillChange:(PBJVision *)vision
{
    NSLog(@"Camera device will change");
}

- (void)visionCameraDeviceDidChange:(PBJVision *)vision
{
    NSLog(@"Camera device did change");
}

// mode

- (void)visionCameraModeWillChange:(PBJVision *)vision
{
    NSLog(@"Camera mode will change");
}

- (void)visionCameraModeDidChange:(PBJVision *)vision
{
    NSLog(@"Camera mode did change");
}

// format

- (void)visionOutputFormatWillChange:(PBJVision *)vision
{
    NSLog(@"Output format will change");
}

- (void)visionOutputFormatDidChange:(PBJVision *)vision
{
    NSLog(@"Output format did change");
}

- (void)vision:(PBJVision *)vision didChangeCleanAperture:(CGRect)cleanAperture
{
}

// video capture

- (void)visionDidStartVideoCapture:(PBJVision *)vision
{
    _recording = YES;
}

- (void)visionDidPauseVideoCapture:(PBJVision *)vision
{
}

- (void)visionDidResumeVideoCapture:(PBJVision *)vision
{
}

- (void)vision:(PBJVision *)vision capturedVideo:(NSDictionary *)videoDict error:(NSError *)error
{
    _recording = NO;
    
    if (error && [error.domain isEqual:PBJVisionErrorDomain] && error.code == PBJVisionErrorCancelled) {
        NSLog(@"recording session cancelled");
        return;
    } else if (error) {
        NSLog(@"encounted an error in video capture (%@)", error);
        return;
    }
    
    _currentVideo = videoDict;
    
    NSString *videoPath = [_currentVideo  objectForKey:PBJVisionVideoPathKey];
    [_assetLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:videoPath] completionBlock:^(NSURL *assetURL, NSError *error1) {
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Video Saved!" message: @"Saved to the camera roll."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];*/
    }];
}

// progress

- (void)vision:(PBJVision *)vision didCaptureVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    //    NSLog(@"captured audio (%f) seconds", vision.capturedAudioSeconds);
}

- (void)vision:(PBJVision *)vision didCaptureAudioSample:(CMSampleBufferRef)sampleBuffer
{
    //    NSLog(@"captured video (%f) seconds", vision.capturedVideoSeconds);
}
//------------------------------------------gravação da camera frontal------------------------------------------------------------------video.

-(void)startCapture{
    directoryURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:    [[NSProcessInfo processInfo] globallyUniqueString]] isDirectory:YES];
    [self writer];
}
-(void)stopCapture{
    [self finishing];
    [timer invalidate];
}
-(CVPixelBufferRef)captureImage{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *endImage = [self resizeImage:imageView];
    //UIImageWriteToSavedPhotosAlbum(endImage, nil, nil, nil);
    return [self newPixelBufferFromCGImage:[endImage CGImage]];
}

- (void)writer{
    // delete video if it already exist
    documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:nil];
    for (NSString *tString in dirContents){
        if ([tString isEqualToString:@"video.mp4"]){
            [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectoryPath,tString] error:nil];
        }
    }
    
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [NSString stringWithFormat:@"%@/video.mp4",documentsDirectory];
    //NSLog(@"tryna to save in %@",documentsDirectory);
    videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:documentsDirectory] fileType:AVFileTypeQuickTimeMovie error:&error];
    NSURL *url=[[NSURL alloc] initFileURLWithPath:documentsDirectory];
    NSLog(@"url -> %@",[url absoluteString]);
    
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey, [NSNumber numberWithInt:self.view.bounds.size.width], AVVideoWidthKey, [NSNumber numberWithInt:self.view.bounds.size.height], AVVideoHeightKey,nil];
    writerinput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    NSDictionary *bufferAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey, nil];
    adaptor = [AVAssetWriterInputPixelBufferAdaptor
               assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerinput
               sourcePixelBufferAttributes:bufferAttributes];
    NSParameterAssert(writerinput);
    NSParameterAssert([videoWriter canAddInput:writerinput]);
    [videoWriter addInput:writerinput];
    
    // - starting session
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    // - writing
    frameCount = 0;
    NSTimeInterval interval = 0.0055;
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(writing) userInfo:nil repeats:YES];
    
}
-(void)writing{
    CVPixelBufferRef buffer = [self captureImage];
    BOOL append_ok = NO;
    int j=0;
    int kRecordingFPS = 24;
    while(!append_ok && j < 10){
        if(adaptor.assetWriterInput.readyForMoreMediaData){
            CMTime frameTime = CMTimeMake(frameCount, (int32_t)kRecordingFPS);
            append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
            if(buffer){
                CVBufferRelease(buffer);
            }
            [NSThread sleepForTimeInterval:0.0055];
        }else{
            NSLog(@"Adptor not ready, %d, %d",frameCount,j);
            [NSThread sleepForTimeInterval:0.0055];
        }
        j++;
    }
    /*if(!append_ok)
     NSLog(@"Got error");
     else
     NSLog(@"Got sucess!");*/
//    
//    if(frameCount > 140){
//        [self finishing];
//        [timer invalidate];
//    }
    frameCount++;
}
-(void)finishing{
    [writerinput markAsFinished];
    [videoWriter finishWritingWithCompletionHandler:^{
        NSLog(@"ww -> %@",videoWriter);
        NSLog(@"Write ended");
    }];
    
    UISaveVideoAtPathToSavedPhotosAlbum(documentsDirectory, nil, nil, nil);
}


- (UIImage *)resizeImage:(UIImage *)image{
    int dezesseis = 16;
    int width = dezesseis*47;
    int height = width*1.77393617021277;
    CGSize size = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, image.scale);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    /*UIGraphicsBeginImageContext(size);
     [image drawInRect:CGRectMake(0, 0, width, height)];
     UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return destImage;*/
}
- (CVPixelBufferRef) newPixelBufferFromCGImage: (CGImageRef) image
{
    CGSize frameSize;// = GSize M
    frameSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    // need to add (CGAffineTransform *)frameTransform
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameSize.width,
                                          frameSize.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, frameSize.width,
                                                 frameSize.height, 8, 4*frameSize.width, rgbColorSpace,
                                                 kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    //CGContextConcatCTM(context, *frameTransform);
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}
- (CMSampleBufferRef)sampleBufferFromCGImage:(CVPixelBufferRef)pixelBuffer
{
    //CVPixelBufferRef pixelBuffer = [self newPixelBufferFromCGImage:image];
    //CVPixelBufferRef pixelBuffer = image;
    CMSampleBufferRef newSampleBuffer = NULL;
    CMSampleTimingInfo timimgInfo = kCMTimingInfoInvalid;
    CMVideoFormatDescriptionRef videoInfo = NULL;
    CMVideoFormatDescriptionCreateForImageBuffer(
                                                 NULL, pixelBuffer, &videoInfo);
    CMSampleBufferCreateForImageBuffer(kCFAllocatorDefault,
                                       pixelBuffer,
                                       true,
                                       NULL,
                                       NULL,
                                       videoInfo,
                                       &timimgInfo,
                                       &newSampleBuffer);
    
    return newSampleBuffer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

// canvas

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"CAMERA GRAVANDO 0");
    if (record){
        //NSLog(@"CAMERA GRAVANDO 1");
        [self _startCapture];
        record = 0;
        //NSLog(@"CAMERA GRAVANDO 2");
    }
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}
- (IBAction)reset:(id)sender {
    self.mainImage.image = self.reset_image.image;
    
    
}

- (IBAction)pencilPressed:(id)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)   {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
    }

}

- (IBAction)eraserPressed:(id)sender {
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
}

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    
    brush = ((SettingsViewController*)sender).brush;
    opacity = ((SettingsViewController*)sender).opacity;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    [self _endCapture];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll", @"Cancel", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 0)
    {
        UIGraphicsBeginImageContextWithOptions(_mainImage.bounds.size, NO,0.0);
        [_mainImage.image drawInRect:CGRectMake(0, 0, _mainImage.frame.size.width, _mainImage.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

@end
