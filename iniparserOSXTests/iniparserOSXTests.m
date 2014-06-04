//
//  iniparserOSXTests.m
//  iniparserOSXTests
//
//  Created by Alessandro Garcez on 5/30/14.
//  Copyright (c) 2014 Alessandro Garcez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "iniparserOSX.h"


@interface iniparserOSXTests : XCTestCase

@property iniparserOSX *iniFile;

@end

@implementation iniparserOSXTests

- (void)setUp{
	
    [super setUp];
    self.iniFile = [[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/iniparserOSX.ini"];
	
}

- (void)tearDown{
	
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithFile{
	
	XCTAssertThrows([[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/"], @"It's not throwing exception while loading a path and not a file.");
	XCTAssertThrows([[iniparserOSX alloc] initWithFile:@"/Invalid/path"], @"It's not throwing exception while loading a invalid path path.");
	XCTAssert([[iniparserOSX alloc] initWithFile:@"/Users/alessandrogarcez/work/OSX/iniparserOSX/iniparserOSXTests/iniparserOSX.ini"], @"It's not loading ini file.");
	
}

- (void)testNumberOfSections{
	
	XCTAssertEqual([self.iniFile numberOfSections], 2, @"The number of senctions is incorrect.");

}

- (void)testNumberOfKeysInSection{
	
	XCTAssertEqual([self.iniFile numberOfKeysInSection:@"CORE"], 8, @"The number of keys is incorrect.");
	XCTAssertThrows([self.iniFile numberOfKeysInSection:@"NOSECTION"], @"It's accepting non existing sections.");
	XCTAssertEqual([self.iniFile numberOfKeysInSection:@"TEST"], 0,@"It's not returning zero for empty section.");
	
}

- (void)testGetSectionsName{
	
	NSArray *sectionNames = [self.iniFile getSectionsName];
	XCTAssertTrue(sectionNames, @"It's not returning section's names.");
	XCTAssertEqual(sectionNames[0], @"CORE", "The name of section is wrong.");
	XCTAssertEqual(sectionNames[0], @"TEST", "The name of section is wrong.");
	
}

- (void)testGetKeysInSection{
	
	XCTAssertThrows([self.iniFile getKeysInSection:@"UNAVAIABLESECTION"], @"It's not returning exception while selected a non existing section.");
	NSArray *keyNames = [self.iniFile getKeysInSection:@"CORE"];
	XCTAssertTrue(keyNames, @"It's not returning key's names.");
	XCTAssertEqual(keyNames[0], @"root_dir", "It's not returning key's names correctly.");
	XCTAssertEqual(keyNames[7], @"sleeptime", "It's not returning key's names correctly.");
	
}

- (void)testGetValueForKey{
	
	XCTAssertThrows([self.iniFile getValueForKey:@"NONEXISTINGKEY" inSection:@"root_dir"], @"It's not returning exception while informing a non existing section.");
	XCTAssertThrows([self.iniFile getValueForKey:@"CORE" inSection:@"non_existing_key"], @"It's not returning exception while informing a non existing key.");
	XCTAssertEqual([self.iniFile getValueForKey:@"ROOT" inSection:@"root_dir"], @"It's returnig wrong value.");
	XCTAssertEqual([self.iniFile getValueForKey:@"ROOT" inSection:@"sleeptime"], @"It's returnig wrong value.");

}

@end