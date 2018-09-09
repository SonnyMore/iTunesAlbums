//
//  iTunesAlbumsTests.swift
//  iTunesAlbumsTests
//
//  Created by Сеин Михаил on 07.09.2018.
//  Copyright © 2018 sein. All rights reserved.
//

import XCTest
@testable import iTunesAlbums

class iTunesAlbumsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let albumsListService = AlbumsListService()
        let detailsService = AlbumDetailsService()
        let expectation = self.expectation(description: "loading")
        albumsListService.loadAlbums(by: "Jack", success: {
            let albums = albumsListService.getAlbums()
            
            detailsService.loadSongs(by: albums[0].collectionId, success: {
                expectation.fulfill()
            }, failed: { (error) in
                
            })
        }) { (error) in
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(detailsService.getSongs().count > 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
