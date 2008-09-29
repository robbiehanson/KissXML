#import "AppDelegate.h"
#import "DDXML.h"
#import "DDXMLTesting.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[DDXMLTesting performTests];
}

@end
