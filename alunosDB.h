//
//  alunosDB.h
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//  alunosDB.h
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class alunos;

@interface alunosDB : NSObject {
    
    sqlite3 *alunosDB;
    NSString *databasePath;
}

-(void)createDatabase;
-(void)insertAluno:(alunos *)aluno;
-(void)updateAluno:(alunos *)aluno;
-(void)deleteAluno:(alunos *)aluno;
-(NSArray *) getAllAlunos;

@end
