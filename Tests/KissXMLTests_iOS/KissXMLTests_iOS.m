//
//  KissXMLTests_iOS.m
//  KissXMLTests_iOS
//
//  Created by Chris Ballinger on 1/21/16.
//
//

#import <XCTest/XCTest.h>
@import KissXML;

@interface KissXMLTests_iOS : XCTestCase

@end

@implementation KissXMLTests_iOS

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testName { @autoreleasepool
    {
        NSLog(@"Starting %@...", NSStringFromSelector(_cmd));
        
        NSString *str = @"<body xmlns:food='http://example.com/' food:genre='italian'>"
        @"  <food:pizza>yumyum</food:pizza>"
        @"</body>";
        
        NSError *error = nil;
        
        NSXMLElement *nsBody = [[NSXMLElement alloc] initWithXMLString:str error:&error];
        DDXMLElement *ddBody = [[DDXMLElement alloc] initWithXMLString:str error:&error];
        
        // Test 1 - elements
        
        NSString *nsNodeName = [[nsBody childAtIndex:0] name];
        NSString *ddNodeName = [[ddBody childAtIndex:0] name];
        
        XCTAssert([nsNodeName isEqualToString:ddNodeName], @"Failed test 1 - ns(%@) dd(%@)", nsNodeName, ddNodeName);
        
        // Test 2 - attributes
        
        NSString *nsAttrName = [[nsBody attributeForName:@"food:genre"] name];
        NSString *ddAttrName = [[ddBody attributeForName:@"food:genre"] name];
        
        XCTAssert([nsAttrName isEqualToString:ddAttrName], @"Failed test 2 - ns(%@) dd(%@)", nsAttrName, ddAttrName);
    }}

@end
