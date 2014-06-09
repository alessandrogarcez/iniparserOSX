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

/**
 *@description	Init method of the object
 *@param		NSString	The path of file to be read.
 *@return		id			The initialized object.
 */
- (id)initWithFile:(NSString *)file;

/**
 *@description	Get the number of sections of loaded ini file.
 *@return		int			Number of sections.
 */
- (int)numberOfSections;

/**
 *@description	Get the number of keys in a sections of loaded ini file.
 *@param		NSString		section		Name of sectionin file.
 *@return		int			Number of keys in informed section.
 */
- (int)numberOfKeysInSection:(NSString *)section;

/**
 *@description	Get the name of all sections in file.
 *@return		NSArray			Array with nameof sections.
 */
- (NSArray *)getSectionsName;

/**
 *@description	Get the name of keys in a section.
 *@param		NSString		section		Name of section in file.
 *@return		NSArray			Return an array with all keys in a informed section.
 */
- (NSArray *)getKeysInSection:(NSString *)section;

/**
 *@description	Get a value for a key in a section
 *@param		NSString		key			Name of key in file.
 *@param		NSString		section		Name of section tin file.
 *@return		NSString		the value for informed key and section.
 */
- (NSString *)getValueForKey:(NSString *)key inSection:(NSString *)section;

- (NSDictionary *)getSectionWithName:(NSString *)sectionName;

@end
