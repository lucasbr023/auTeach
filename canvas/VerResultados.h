//
//  VerResultados.h
//  canvas
//
//  Created by Phablulo Joel on 02/05/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ImagemGrande.h"

@interface VerResultados : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *desenho;
@property (weak, nonatomic) IBOutlet UIImageView *video;

@property (nonatomic, copy) NSURL* videoURL;
@property (nonatomic, copy) UIImage* imagem;

//-(void)reciveDataImage:(UIImage *)imagem video:(NSURL *)video;

@end
