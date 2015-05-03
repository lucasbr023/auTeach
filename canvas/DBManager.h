//
//  DBManager.h
//  canvas
//
//  Created by Natalia Souza on 5/3/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;


-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;

@end
