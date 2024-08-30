//
//  MovieRepositoryInterface.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/30/24.
//
// MARK: - Interface
// Repository Interface
// 이 인터페이스를 통해서 UseCase는 외부 계층(Presentation, Data 레이어)에 대해서 모르는 상태가 될 수 있다.

import Foundation

protocol MovieRepositoryInterface {
    func fetchMovies() async throws -> [MovieEntity]
}


