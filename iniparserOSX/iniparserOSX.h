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

/**
 *@description	Get the number of sections of loaded ini file.
 *@return		int			Number of sections.
 */
- (int)numberOfSections;

/**
 *@description	Get the number of keys in a sections of loaded ini file.
 *@param		NSString	Name of section to count the number of keys.
 *@return		int			Number of keys.
 */
- (int)numberOfKeysInSection:(NSString *)section;
- (NSArray *)getSectionsName;
- (NSArray *)getKeysInSection:(NSString *)section;
- (NSString *)getValueForKey:(NSString *)key inSection:(NSString *)section;

@end
