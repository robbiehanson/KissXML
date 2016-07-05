#import <Foundation/Foundation.h>

// We redefine xmlChar to avoid a non-modular include
typedef unsigned char xmlChar;

@interface NSString (DDXML)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)xmlChar;

- (NSString *)stringByTrimming;

@end
