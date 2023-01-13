//
//  ContentPlayerTests.swift
//  ContentPlayerTests
//
//  Created by 이대현 on 2023/01/09.
//

import XCTest
@testable import ContentPlayer

final class ContentPlayerTests: XCTestCase {
    
    let contentJsonString = """
{
"Contents":
[
    {
        "Genre": "드라마",
        "Name": "<터치>",
        "Description": "초밀착 뷰티 로맨스, 금토드라마 (2020)",
        "Definition":   "고화질",
        "VideoPath": "touch.mp4",
        "ThumbPath": "touch_thumb.jpg",
        "ScriptPath": "touch_utf8.json",
        "CaptionPath": "touch.srt"
    },
    {
        "Genre": "뉴스",
        "Name": "<태풍경보>",
        "Description": "28일 기상청이 발표한 15호태풍 볼라벤",
        "Definition":   "표준화질",
        "VideoPath": "typhoon.mp4",
        "ThumbPath": "typhoon_thumb.jpg",
        "ScriptPath": "CNUH_QUERY.json",
        "CaptionPath": ""
    }
]
}
"""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingContentJson() throws {
        let decoder = JSONDecoder()
        let contentsJson = try decoder.decode(Contents.self, from: contentJsonString.data(using: .utf8)!)
        let contents = contentsJson.Contents
        XCTAssertEqual(contents[0].Genre, "드라마")
        XCTAssertEqual(contents[1].Description, "28일 기상청이 발표한 15호태풍 볼라벤")
    }
    
    func testJsonManager() throws {
        let contentJson = JsonManager.shared.parse(type: Contents.self, data: contentJsonString.data(using: .utf8)!)
        let contents = contentJson.Contents
        XCTAssertEqual(contents[0].Genre, "드라마")
        XCTAssertEqual(contents[1].Description, "28일 기상청이 발표한 15호태풍 볼라벤")
    }
    
    func testTimeFormat() throws {
        let a: Int = 3
        XCTAssertEqual(a.timeFormat(), "00:00:03")
        let b: Int = 60
        XCTAssertEqual(b.timeFormat(), "00:01:00")
        let c: Int = 3600
        XCTAssertEqual(c.timeFormat(), "01:00:00")
        let d: Int = 3661
        XCTAssertEqual(d.timeFormat(), "01:01:01")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
