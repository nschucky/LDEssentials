//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Antonio Alves on 12/29/20.
//

import XCTest
import LDEssentials

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        XCTAssertEqual(makeSUT().store.receivedMessages, [])
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        store.completeDeletion(with: deletionError)
        
        try? sut.save(uniqueImageFeed().models)
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
        
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        store.completeInsertionSuccessfully()
        let feed = uniqueImageFeed()
        try? sut.save(feed.models)
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed, .insert(feed.local, timestamp)])
    }
    
//    func test_save_requestCacheDeletion() {
//        let (sut, store) = makeSUT()
//        
//        sut.save(uniqueImageFeed())
//        
//        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
//    }
//    
//
//    
//    func test_save_requestNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
//        let timestamp = Date()
//        let (sut, store) = makeSUT(currentDate: {timestamp})
//        let feed = uniqueImageFeed()
//        sut.save(feed.model)
//        store.completeDeletionSuccessfully()
//        
//        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed, .insert(feed.local, timestamp)])
//    }
//    
//    func test_save_failsOnDeletionError() {
//        let (sut, store) = makeSUT()
//        let deletionError = anyNSError()
//        
//        expect(sut, toCompleteWithError: deletionError) {
//            store.completeDeletion(with: deletionError)
//        }
//    }
//    
//    func test_save_failsOnInsertionError() {
//        let (sut, store) = makeSUT()
//        let insertionError = anyNSError()
//        
//        expect(sut, toCompleteWithError: insertionError) {
//            store.completeDeletionSuccessfully()
//            store.completeInsertion(with: insertionError)
//        }
//    }
//    
//    func test_save_succeedsOnSuccessfulCacheInsertion() {
//        let (sut, store) = makeSUT()
//        
//        expect(sut, toCompleteWithError: nil) {
//            store.completeDeletionSuccessfully()
//            store.completeInsertionSuccessfully()
//        }
//    }
//    
//    func test_save_doesNotDeliverDeletionErrorAfterSUTInstanceHasBeenDeallocated() {
//        let store = FeedStoreSpy()
//        var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)
//        var receivedResults: [LocalFeedLoader.SaveResult] = []
//        
//        sut?.save(uniqueImageFeed().model) { (error) in
//            receivedResults.append(error)
//        }
//        
//        sut = nil
//        store.completeDeletion(with: anyNSError())
//        XCTAssertTrue(receivedResults.isEmpty)
//    }
//    
//    func test_save_doesNotDeliverInsertionErrorAfterSUTInstanceHasBeenDeallocated() {
//        let store = FeedStoreSpy()
//        var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)
//        var receivedResults: [LocalFeedLoader.SaveResult] = []
//        
//        sut?.save(uniqueImageFeed().model) { (error) in
//            receivedResults.append(error)
//        }
//        
//        store.completeDeletionSuccessfully()
//        sut = nil
//        store.completeInsertion(with: anyNSError())
//        XCTAssertTrue(receivedResults.isEmpty)
//    }
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(store, file: file, line: line)
        
        return (sut, store)
    }
    
    private func expect(_ sut: LocalFeedLoader, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        action()
        
        do {

            try sut.save(uniqueImageFeed().models)
        } catch {
            XCTAssertEqual(error as NSError?, expectedError, file: file, line: line)
        }
    }
    
}
