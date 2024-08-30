//
//  MockMovieRepository.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/30/24.
//
// MARK: - 테스트용 Repository(Mock 객체)
// 현업에서는 프로젝트 진행시 백엔드와 프론트 개발이 동시에 병렬적으로 진행되다보면 API를 매번 프리뷰에 띄우기 보다는 가짜 정보를 사용해서 미리 뷰를 구현해봐야 하는 경우가 있다. 그래서 이렇게 테스트 코드를 구현할 수 있다.
// API를 호출하지 않고도 가짜 데이터를 뿌려서 테스팅이 가능하다.

import Foundation

// "https://picsum.photos/200/300" -> 랜덤이미지 생성 URL
final class MockMovieRepository: MovieRepositoryInterface {
    func fetchMovies() async throws -> [MovieEntity] {
        (0...4).map {
            MovieEntity(id: $0, title: "moive_\($0)", imageURL: "https://picsum.photos/200/300", uploadedDate: Date())
        }
    }
}
