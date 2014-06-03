//
//  iniparserOSX.h
//  iniparserOSX
//
//  Created by Alessandro Garcez on 5/30/14.
//  Copyright (c) 2014 Alessandro Garcez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iniparser.h"

@interface iniparserOSX : NSObject

@property (strong, nonatomic) NSDictionary *data;

- (id)initWithFile:(NSString *)file;
- (int)numberOfSections;
- (int)numberOfKeysInSection:(NSString *)section;
- (NSArray *)getSections;
- (NSArray *)getKeyInSection:(NSString *)section;
- (NSString *)getValueForKey:(NSString *)key inSection:(NSString *)section;

@end
