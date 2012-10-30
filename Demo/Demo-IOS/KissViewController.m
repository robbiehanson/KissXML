//
//  KissViewController.m
//  Demo-IOS
//
//  Created by Dominik Pich on 19.06.12.
//  Copyright (c) 2012 Kiss. All rights reserved.
//

#import "KissViewController.h"
#import "DDXML.h"

@interface KissViewController ()

@end

@implementation KissViewController

@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)openAndConvert {
    id file = [[NSBundle mainBundle] URLForResource:@"books" withExtension:@"xml"];
    id data = [NSData dataWithContentsOfURL:file];
    NSXMLDocument *doc = [[NSXMLDocument alloc] initWithData: data options:0 error:nil];

    NSArray *tags = [doc nodesForXPath:@"//author" error:nil];
    NSMutableString *html = [NSMutableString stringWithString:@"<ul>"];
    for (NSXMLNode *node in tags) {
        [html appendFormat:@"<li>author:: %@</li>", node.description];
    }
    [html appendString:@"</ul>"];
    
   [self.webView loadHTMLString:html baseURL:nil];
}
@end
