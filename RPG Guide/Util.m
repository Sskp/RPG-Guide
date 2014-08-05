//
//  util.m
//  DM Compendium
//
//  Created by Mateus Andrade on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "AppDelegate.h"

@implementation Util

+(UIImage *)ImagemTipoAlquimia:(NSString *)tipo Estilo:(NSString *)estilo{
    UIImage *var;
    
//    RPG_GuideAppDelegate *delegate = (RPG_GuideAppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    estilo = delegate.estilo;
        
    if ([estilo isEqual:@"2"]){
            if ([tipo isEqualToString:@"Cura"]) {
                var = [UIImage imageNamed:@"Cura2.png"];
            }
            else if ([tipo isEqualToString:@"Veneno"]) {
                var = [UIImage imageNamed:@"Veneno2.png"];
            }
            else if ([tipo isEqualToString:@"Movimento"]) {
                var = [UIImage imageNamed:@"Movimento2.png"];
            }
            else if ([tipo isEqualToString:@"Ataque"]) {
                var = [UIImage imageNamed:@"Ataque2.png"];
            }
            else if ([tipo isEqualToString:@"Físico"]) {
                var = [UIImage imageNamed:@"Fisico2.png"];
            }
            else if ([tipo isEqualToString:@"Melhoria"]) {
                var = [UIImage imageNamed:@"Melhoria.png"];
            }
            else if ([tipo isEqualToString:@"Redução"]) {
                var = [UIImage imageNamed:@"Redução2.png"];
            }
            else if ([tipo isEqualToString:@"Óleo"]) {
                var = [UIImage imageNamed:@"Oleo2.png"];
            }
            else if ([tipo isEqualToString:@"Mental"]) {
                var = [UIImage imageNamed:@"Mente2.png"];
            }
            else if ([tipo isEqualToString:@"Proteção"]) {
                var = [UIImage imageNamed:@"Proteção2.png"];
            }
            else if ([tipo isEqualToString:@"Sentido"]) {
                var = [UIImage imageNamed:@"Sentido2.png"];
            }
            else if ([tipo isEqualToString:@"Efeito"]) {
                var = [UIImage imageNamed:@"Efeito2.png"];
            }
            else{
                var = [UIImage imageNamed:@"Template.png"];
            }
    }
    else{
            if ([tipo isEqualToString:@"Cura"]) {
                var = [UIImage imageNamed:@"Cura.png"];
            }
            else if ([tipo isEqualToString:@"Veneno"]) {
                var = [UIImage imageNamed:@"Veneno.png"];
            }
            else if ([tipo isEqualToString:@"Movimento"]) {
                var = [UIImage imageNamed:@"Movimento.png"];
            }
            else if ([tipo isEqualToString:@"Ataque"]) {
                var = [UIImage imageNamed:@"Ataque.png"];
            }
            else if ([tipo isEqualToString:@"Físico"]) {
                var = [UIImage imageNamed:@"Físico.png"];
            }
            else if ([tipo isEqualToString:@"Melhoria"]) {
                var = [UIImage imageNamed:@"Melhoria.png"];
            }
            else if ([tipo isEqualToString:@"Redução"]) {
                var = [UIImage imageNamed:@"Redução.png"];
            }
            else if ([tipo isEqualToString:@"Óleo"]) {
                var = [UIImage imageNamed:@"Oleo.png"];
            }
            else if ([tipo isEqualToString:@"Mental"]) {
                var = [UIImage imageNamed:@"Mente.png"];
            }
            else if ([tipo isEqualToString:@"Proteção"]) {
                var = [UIImage imageNamed:@"Proteção.png"];
            }
            else if ([tipo isEqualToString:@"Sentido"]) {
                var = [UIImage imageNamed:@"Sentido.png"];
            }
            else if ([tipo isEqualToString:@"Efeito"]) {
                var = [UIImage imageNamed:@"Efeito.png"];
            }
            else{
                var = [UIImage imageNamed:@"Template.png"];
            }
    }

    return var;
}

+(UIImage *)ImagemTipoItem:(NSString *)tipo Estilo:(NSString *)estilo{
    UIImage *var;
    
    if ([estilo isEqual:@"2"]){
        if ([tipo isEqualToString:@"Espada"]) {
            var = [UIImage imageNamed:@"espadaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Lança"]) {
            var = [UIImage imageNamed:@"lancaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Machado"]) {
            var = [UIImage imageNamed:@"machadoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Adaga ou Faca"]) {
            var = [UIImage imageNamed:@"adagaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Maça"]) {
            var = [UIImage imageNamed:@"macaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Arco"]) {
            var = [UIImage imageNamed:@"arcoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Flecha"]) {
            var = [UIImage imageNamed:@"flechaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Chicote"]) {
            var = [UIImage imageNamed:@"chicoteItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Haste"]) {
            var = [UIImage imageNamed:@"alabardaItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Bastão"]) {
            var = [UIImage imageNamed:@"bastaoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Cajado"]) {
            var = [UIImage imageNamed:@"cajadoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Arremesso"]) {
            var = [UIImage imageNamed:@"arremessoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Arma de Fogo"]) {
            var = [UIImage imageNamed:@"armaFogoItemTinta.png"];
        }
        else if ([tipo isEqualToString:@"Manopla e Luva"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Elmo e Capacete"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Bota e Cuturno"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Peitoral"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Calça"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Escudo"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Armadura"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Ferramentas"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Viagem"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Sobrevivência"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Artefato Menor"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Artefato Maior"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Comida"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Serviços Gerais"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Animais"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Veículos"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Arte"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Joias"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Tapeçaria"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else{
            var = [UIImage imageNamed:@"Template.png"];
        }
    }
    else{
        var = [UIImage imageNamed:@"Template.png"];
    }
    
    return var;
}

+(UIImage *)ImagemCategoriaItem:(NSString *)tipo Estilo:(NSString *)estilo{
    
    UIImage *var;
    if ([estilo isEqual:@"2"]){

        if ([tipo isEqualToString:@"Armas"]) {
            var = [UIImage imageNamed:@"armaCategoriaTinta.png"];
        }
        else if ([tipo isEqualToString:@"Proteção"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Equipamentos"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Artefatos"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Comodidades"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Veículo"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Tesouro"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else{
            var = [UIImage imageNamed:@"Template.png"];
        }
    }
    else{
        var = [UIImage imageNamed:@"Template.png"];
    }
    
    return var;
}

+(UIImage *)ImagemRaridade:(NSString *)tipo Estilo:(NSString *)estilo{
    
    UIImage *var;
    
    if ([estilo isEqual:@"2"]){
        
        if ([tipo isEqualToString:@"Comum"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Media"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Dificil"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Rara"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Rarissima"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else if ([tipo isEqualToString:@"Lendária"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else{
            var = [UIImage imageNamed:@"Template.png"];
        }
    }
    else{
        var = [UIImage imageNamed:@"Template.png"];
    }
    
    return var;
}

+(UIImage *)ImagemFundo:(NSString *)estilo{
    UIImage *var;
    
    if ([estilo isEqual:@"2"]){
        var = [UIImage imageNamed:@"fundoAlquimia3.png"];
    }
    else{
        var = Nil;
    }
    
    return var;
}

+(UIImage *)ImagemCelula:(NSString *)estilo{
    UIImage *var;
    
    if ([estilo isEqual:@"2"]){
        var = [UIImage imageNamed:@"CellBackground.png"];
    }
    else{
        var = Nil;
    }
    
    return var;
}

+(UIFont *)FonteLabel:(NSString *)estilo{
    UIFont *var;
    
    if ([estilo isEqual:@"1"]){
        var = [UIFont fontWithName:@"Helvetica" size:14];
    }
    else if ([estilo isEqual:@"2"]){
//        var = [UIFont fontWithName:@"Zapfino" size:12];
        var = [UIFont fontWithName:@"Helvetica Neue" size:14];
  
    }
    else{
        var = Nil;
    }
    
    return var;
}

+(UIFont *)FonteTitulo:(NSString *)estilo{
    UIFont *var;
    
    if ([estilo isEqual:@"1"]){
        var = [UIFont fontWithName:@"Helvetica" size:24];
    }
    else if ([estilo isEqual:@"2"]){
        var = [UIFont fontWithName:@"Zapfino" size:17];
    }
    else{
        var = Nil;
    }
    
    return var;
}


+(UIImage *)ImagemBusca:(NSString *)tipo Estilo:(NSString *)estilo{
    
    UIImage *var;
    
    
    if ([estilo isEqual:@"2"]){        
        if ([tipo isEqualToString:@"Alquimia"]) {
            var = [UIImage imageNamed:@"botaoAlquimia.png"];
        }
        else if ([tipo isEqualToString:@"ItemComum"]) {
            var = [UIImage imageNamed:@"botaoItem.png"];
        }
        else if ([tipo isEqualToString:@"ItemMagico"]) {
            var = [UIImage imageNamed:@"ItemMagico.png"];
        }
        else if ([tipo isEqualToString:@"Dienheiro"]) {
            var = [UIImage imageNamed:@"Template.png"];
        }
        else{
            var = [UIImage imageNamed:@"Template.png"];
        }
    }
    else{
        var = [UIImage imageNamed:@"Template.png"];
    }
    
    return var;
}

+(NSString *)VerificaEstilo{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"config.plist"];
    
    NSString *estilo = @"1";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        
        NSDictionary *configDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        estilo = [configDict valueForKey:@"Estilo"];
    }
    return estilo;

}

+(NSDictionary *)RetornaConfig{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    //[paths release];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"config.plist"];
    
    NSDictionary *configDict = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        
        configDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
    }
    return configDict;
}

@end
