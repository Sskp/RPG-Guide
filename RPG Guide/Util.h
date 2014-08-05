//
//  Util.h
//  DM Compendium
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//


@interface Util: NSObject {    
}

+(UIImage *)ImagemTipoAlquimia:(NSString *)tipo Estilo:(NSString *) estilo;
+(UIImage *)ImagemTipoItem:(NSString *)tipo Estilo:(NSString *) estilo;
+(UIImage *)ImagemCategoriaItem:(NSString *)tipo Estilo:(NSString *) estilo;
+(UIImage *)ImagemRaridade:(NSString *)tipo Estilo:(NSString *) estilo;
+(UIImage *)ImagemFundo:(NSString *) estilo;
+(UIImage *)ImagemCelula:(NSString *) estilo;
+(UIImage *)ImagemBusca:(NSString *)tipo Estilo:(NSString *) estilo;
+(UIFont *)FonteLabel:(NSString *) estilo;
+(UIFont *)FonteTitulo:(NSString *) estilo;
+(NSString *)VerificaEstilo;
+(NSDictionary *)RetornaConfig;

@end
