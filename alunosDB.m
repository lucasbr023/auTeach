//
//  alunosDB.m
//  canvas
//
//  Created by Natalia Souza on 5/2/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "alunosDB.h"
#import "alunos.h"
#import "sqlite3.h"

@implementation alunosDB
// Inicializa o banco -------------------------------
- (void)initDB {
    // Obtém os diretório de arquivos da aplicação
    NSArray *dirPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory, NSUserDomainMask, YES);
    // Obtém o diretório para salvar o arquivo do banco
    NSString *docsDir = [dirPaths objectAtIndex:0];
    // Cria o caminho do arquivo do banco
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent:
                     @"alunosDB"]];
    
    const char *dbpath = [databasePath UTF8String];
    // Inicializa o atributo contactDB com o banco
    if (sqlite3_open(dbpath, &alunosDB) != SQLITE_OK){
        NSLog(@"Failed to open/create database - 1");
    }
}

// Cria a tabela no banco ---------------------------
- (void)createDatabase {
    // Chama o método acima...
    [self initDB];
    
    char *errMsg;
    const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ALUNOS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NOME TEXT, IDADE INTEGER, SERIE TEXT)";
    
    // Cria a tabela no banco se ela não existir
    if (sqlite3_exec(alunosDB, sql_stmt, NULL, NULL,
                     &errMsg) == SQLITE_OK) {
        NSLog(@"Database successfully created");
    } else {
        NSLog(@"Failed to create table");
    }
    
    sqlite3_close(alunosDB);
}

// Inserir um contato no banco ---------------------
- (void)insertAluno:(alunos *)aluno {
    [self initDB];
    
    char *sql = "INSERT INTO ALUNOS (NOME,IDADE,SERIE) VALUES (?, ?, ?);";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(alunosDB, sql, -1,&stmt, nil) == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1,
                          [aluno.nome UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2,
                          [aluno.idade UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3,
                          [aluno.serie UTF8String], -1, NULL);
    }
    if (sqlite3_step(stmt) == SQLITE_DONE){
        NSLog(@"Record added");
    } else {
        NSLog(@"Failed to add contact");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(alunosDB);
}

// Atualizar contato no banco ----------------------
- (void)updateAluno:(alunos *)aluno {
    [self initDB];
    
    char *sql = "UPDATE ALUNOS SET NOME = ?, IDADE = ?, SERIE = ? WHERE ID = ?;";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(alunosDB, sql, -1,
                           &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1,
                          [aluno.nome UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2,
                          [aluno.idade UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3,
                          [aluno.serie UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 4, aluno._id);
    }
    
    if (sqlite3_step(stmt) == SQLITE_DONE){
        NSLog(@"Record updated");
    } else {
        NSLog(@"Failed to update contact");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(alunosDB);
}

// Excluir contato ---------------------------------
- (void)deleteAluno:(alunos *)aluno {
    [self initDB];
    
    char *sql = "DELETE FROM ALUNOS WHERE ID = ?;";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(alunosDB, sql, -1,
                           &stmt, nil) == SQLITE_OK) {
        
        sqlite3_bind_int(stmt, 1, aluno._id);
    }
    if (sqlite3_step(stmt) == SQLITE_DONE){
        NSLog(@"Record removed");
    } else {
        NSLog(@"Failed to removed contact");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(alunosDB);
}

// Obter lista de objetos do banco -----------------
- (NSArray *)getAllAlunos;
{
    [self initDB];
    
    NSMutableArray *alunoArray = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM alunos"];
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(alunosDB, query_stmt, -1,
                           &statement, NULL) == SQLITE_OK){
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSInteger alunoId =
            sqlite3_column_int(statement, 0);
            
            NSString *nome = [[NSString alloc]
                              initWithUTF8String:(const char *)
                              sqlite3_column_text(statement, 1)];
            
            NSString *idadeField = [[NSString alloc]
                                    initWithUTF8String:(const char *)
                                    sqlite3_column_text(statement, 2)];
            
            NSString *serieField = [[NSString alloc]
                                    initWithUTF8String:(const char *)
                                    sqlite3_column_text(statement, 3)];
            
            alunos *aluno = [[alunos alloc]init];
            aluno._id = alunoId;
            aluno.nome = nome;
            aluno.idade = idadeField;
            aluno.serie = serieField;
            
            [alunoArray addObject:aluno];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(alunosDB);
    
    return [NSArray arrayWithArray:alunoArray];
}

@end
