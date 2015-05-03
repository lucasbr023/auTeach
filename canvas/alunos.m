//
//  alunos.m
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "alunos.h"

@implementation alunos

@synthesize _id = __id, nome = _nome,
idade = _idade, serie = _serie;

- (id)initWithName:(NSString *)nome
            andAge:(NSString *)idade
          andSerie:(NSString *)serie {
    
    self = [super init];
    if (self){
        self.nome = nome;
        self.idade = idade;
        self.serie = serie;
    }
    return self;
}

@end