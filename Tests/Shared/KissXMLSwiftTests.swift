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
        let node = DDXMLNode.attribute(withName: "xml:duck", stringValue: "quack")
        let apple = XMLNode.attribute(withName: "xml:duck", stringValue: "quack")
        XCTAssertNotNil(node)
        XCTAssertNotNil(apple)
    }

    func testXMLElement() {
        let expected = "<iq type=\"set\"><enable xmlns=\"urn:xmpp:push:0\" jid=\"push-5.client.example\" node=\"yxs32uqsflafdk3iuqo\"></enable></iq>"
        let expXml = try? XMLElement(xmlString: expected)
        XCTAssertNotNil(expXml)
        XCTAssertNotNil(expXml?.xmlString)

        let expDDXml: DDXMLElement? = try? DDXMLElement(xmlString: expected)
        XCTAssertNotNil(expDDXml)
        XCTAssertNotNil(expDDXml?.xmlString)
    }

}
