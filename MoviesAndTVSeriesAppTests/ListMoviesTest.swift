//
//  ListMoviesTest.swift
//  MoviesAndTVSeriesAppTests
//
//  Created by Asael Virgilio on 19/02/24.
//

import XCTest
@testable import MoviesAndTVSeriesApp

final class ListMoviesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MoviesRepositoryStub: MoviesRepositoryType {
        
        
        func fetchMovies(pageNum: Int) async throws -> [Movie] {
            return  [
                Movie(backdropPath: "", id: 1, title: "", originalTitle: "", overview: "", posterPath: "", genreIDS: [80], releaseDate: "", voteAverage: 0.0),
                Movie(backdropPath: "", id: 2, title: "", originalTitle: "", overview: "", posterPath: "", genreIDS: [0], releaseDate: "", voteAverage: 0.0),
                Movie(backdropPath: "", id: 3, title: "", originalTitle: "", overview: "", posterPath: "", genreIDS: [0], releaseDate: "", voteAverage: 0.0),
                
            ]
            
        }
        
        
    }

    func test_when_returns_less_than_21_results() async {
        let moviesRepository = MoviesRepositoryStub()
        //Given
        var sut = LoadMoviesUseCase(moviesRepository: moviesRepository, pageNum: 0)
        
        let result = await sut.execute()
        
        switch result {
            
        case .success(let response):
            let count = response.count
            let waiting = 3
            XCTAssertEqual(count, waiting)
            
        case .failure(let error):
            XCTAssertNil(error)
        }
        
        //When
//            let result = sut.repositoryResult
        //Then
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
