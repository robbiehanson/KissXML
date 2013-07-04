#import <Foundation/Foundation.h>
#import <libxml/tree.h>


@interface NSString (DDXML)

/**
 * xmlChar - A basic replacement for char, a byte in a UTF-8 encoded string.
**/
- (const xmlChar *)dd_xmlChar;

- (NSString *)dd_stringByTrimming;

@end

#ifndef KISS_XML_EXCLUDE_DEPRECATED

@interface NSString (DDXMLDeprecated)
- (const xmlChar *)xmlChar __attribute__((deprecated("Use -dd_xmlChar")));
- (NSString *)stringByTrimming __attribute__((deprecated("Use -dd_stringByTrimming")));
@end

#endif