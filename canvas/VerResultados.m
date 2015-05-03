//
//  VerResultados.m
//  canvas
//
//  Created by Phablulo Joel on 02/05/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "VerResultados.h"

@interface VerResultados ()

@end

@implementation VerResultados

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"cheguei.");
    NSLog(@"w -> %f", self.imagem.size.width);
    _desenho.image = self.imagem;
    //_desenho.backgroundColor = [UIColor greenColor];
    
    //MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    NSURL* url = [NSURL fileURLWithPath:[self.videoURL absoluteString]];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    NSLog(@"VIDEO:: %@",[self.videoURL absoluteString ]);
    [player prepareToPlay];
    [player.view setFrame:_video.bounds];
    player.controlStyle = MPMovieControlStyleDefault;
    //player.shouldAutoplay = YES;*/
    [player setMovieSourceType:MPMovieSourceTypeFile];
    [player setScalingMode:MPMovieScalingModeAspectFill];
    player.shouldAutoplay = NO;
    //[player.view ]
    [self.video addSubview:player.view];
    [player play];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ImagemGrande *passImage = [segue destinationViewController];
    passImage.asdf = self.imagem;
    /*
    VerResultados *passData = [segue destinationViewController];
    passData.imagem = self.imagem;
    passData.videoURL = self.videoURL;
    NSLog(@"testando again, w -> %f, %f",self.imagem.size.width,passData.imagem.size.width);*/
}
/*-(void) reciveDataImage:(UIImage *)imagem video:(NSURL *)video{
    NSLog(@"cheguei.");
    NSLog(@"w -> %f", self.imagem.size.width);
    _desenho.image = self.imagem;
    _desenho.backgroundColor = [UIColor greenColor];
    
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    myImage.image = imagem;
    [self.view addSubview:myImage];
    
    //[_desenho setImage:self.imagem];
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
