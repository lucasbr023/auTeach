//
//  results.m
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "results.h"

@implementation results

-(void)viewDidLoad{
   /* NSLog(@"results.m -> %f",self.imagem.size.width);
    [self performSelector:@selector(again) withObject:nil afterDelay:4.0 ];*/
    NSLog(@"results.m -> %f",self.imagem.size.width);
    [super viewDidLoad];
}
-(void)again{
    NSLog(@"results.m -> %f",self.imagem.size.width);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    VerResultados *passData = [segue destinationViewController];
    passData.imagem = self.imagem;
    passData.videoURL = self.videoURL;
    NSLog(@"testando again, w -> %f, %f",self.imagem.size.width,passData.imagem.size.width);
}

- (void)sendDataToAnotherView:(UIImage *)imagem videoURL:(NSURL *)videoURL{
    VerResultados *passdata = [[VerResultados alloc] init];
    passdata.imagem = imagem;
    passdata.videoURL = videoURL;
    //[passdata reciveDataImage:imagem video:videoURL];

    NSLog(@"passando dados. w -> %f",self.imagem.size.width);
    [self.navigationController pushViewController:passdata animated:YES];
}

@end
