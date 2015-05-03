//
//  alunos.h
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alunos : NSObject

@property (assign) NSInteger _id;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *idade;
@property (strong, nonatomic) NSString *serie;

- (id)initWithName:(NSString *)nome
        andAge:(NSString *)idade
          andSerie:(NSString *)serie;

@end
