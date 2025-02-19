//
//  EUExBase+Bundle.m
//  AppCanEngine
//
//  Created by Cerino on 15/9/11.
//
//

#import "EUExBase+Bundle.h"

@implementation EUExBase (Bundle)

- (NSBundle *)pluginBundle {
    
    NSString * EUExName = NSStringFromClass([self class]);
    
    NSString * bundleName = [NSString stringWithFormat:@"uex%@.bundle",[EUExName substringFromIndex:4]];
    
    NSString * bundlePath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:bundleName];
    
    if ([self isUseSystemLanguage]) {
        
        return [NSBundle bundleWithPath:bundlePath];
        
    } else {
        
        NSString * userLanguage = [self getAppCanUserLanguage];
        
        return [NSBundle bundleWithPath:[[NSBundle bundleWithPath:bundlePath] pathForResource:userLanguage ofType:@"lproj"]];
        
    }
    
}

- (BOOL)isUseSystemLanguage {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    NSString * userLanguag = [ud valueForKey:@"AppCanUserLanguage"];
    
    if (!userLanguag || userLanguag == nil || userLanguag.length == 0) {
        
        return YES;
        
    }
    
    return NO;
    
}

- (NSString *)getAppCanUserLanguage {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    NSString * userLanguag = [ud valueForKey:@"AppCanUserLanguage"];
    
    return userLanguag;
    
}

-(NSString*)localizedString:(NSString *)key, ...{
    
    NSString *value = @"";
    if(!key){
        return value;
    }
    va_list argList;
    va_start(argList,key);
    id arg=va_arg(argList,id);
    if(arg && [arg isKindOfClass:[NSString class]]){
        value=arg;
    }
    va_end(argList);
    return [self localizedStringForKey:key defaultValue:value];
}

-(NSString *)localizedStringForKey:(NSString *)key defaultValue:(NSString *)value{
    if(!meBundle){
        return value;
    }
    return [meBundle localizedStringForKey:key value:value table:nil];
    
    
}
@end
