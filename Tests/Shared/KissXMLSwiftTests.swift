//
//  KissXMLSwiftTests.swift
//  KissXMLSwiftTests
//
//  Created by Chris Ballinger on 1/26/16.
//
//

import XCTest
import KissXML

class KissXMLSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testXMLNode() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let node = DDXMLNode()
        let apple = XMLNode()
        XCTAssertNotNil(node)
        XCTAssertNotNil(apple)
    }
    
    func testXMLElement() {
        let expected = "<iq type=\"set\"><enable xmlns=\"urn:xmpp:push:0\" jid=\"push-5.client.example\" node=\"yxs32uqsflafdk3iuqo\"></enable></iq>"
        var expXml: XMLElement? = nil
        do {
        expXml = try XMLElement(xmlString: expected)
        } catch {
        }
        XCTAssertNotNil(expXml)
        XCTAssertNotNil(expXml?.xmlString)
        
        var expDDXml: DDXMLElement? = nil
        do {
            expDDXml = try DDXMLElement(xmlString: expected)
        } catch {
        }
        XCTAssertNotNil(expDDXml)
        XCTAssertNotNil(expDDXml?.xmlString)
    }
    
}
