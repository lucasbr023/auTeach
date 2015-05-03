//
//  results.h
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerResultados.h"

@interface results : UIViewController
- (void)sendDataToAnotherView:(UIImage *)imagem videoURL:(NSURL *)videoURL;
//- (void)recordData:(UIImage *)image video:(NSURL *)video;

@property (weak, nonatomic) IBOutlet UIImageView *results;
@property (weak, nonatomic) IBOutlet UIButton *aluno;
@property (weak, nonatomic) IBOutlet UIButton *atividade;


@property (nonatomic, copy) NSURL* videoURL;
@property (nonatomic, copy) UIImage* imagem;

@end
