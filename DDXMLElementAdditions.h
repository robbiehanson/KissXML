#import <Foundation/Foundation.h>
#import "DDXML.h"

@interface DDXMLElement (XMPPStreamAdditions)

- (DDXMLElement *)elementForName:(NSString *)name;
- (DDXMLElement *)elementForName:(NSString *)name xmlns:(NSString *)xmlns;

- (NSString *)xmlns;

- (void)addAttributeWithName:(NSString *)name stringValue:(NSString *)string;

- (NSDictionary *)attributesAsDictionary;

@end
