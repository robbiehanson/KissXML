#import <Foundation/Foundation.h>

// We redefine xmlChar to avoid a non-modular include
typedef unsigned char xmlChar;

NS_ASSUME_NONNULL_BEGIN
@interface NSString (DDXML)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)dd_xmlChar;

- (NSString *)dd_stringByTrimming;

@end

@interface NSString (DDXMLDeprecated)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)xmlChar DEPRECATED_MSG_ATTRIBUTE("use dd_xmlChar instead.");

- (NSString *)stringByTrimming  DEPRECATED_MSG_ATTRIBUTE("use dd_stringByTrimming instead.");

@end
NS_ASSUME_NONNULL_END
