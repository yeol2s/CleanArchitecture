//
//  MovieUseCase.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/30/24.
//
// MARK: - UseCase
// MARK: 이 정도 규모의 앱에서는 BadCase가 될 수 있다. 억지로 UseCase가 구현된 느낌이 된다. 굳이 UseCase를 분리하지 않는 경우도 있음
// 필요에 따라 일부는 Repository, 일부는 Presentation 부분에 로직을 심어줘도 된다.(실무하는 곳에 따라 다름)

/*
 UseCase는 애플리케이션 계층이라고 할 수 있고, 비즈니스 규칙과 로직을 구현
 UseCase는 Repository를 소유한다.(구체 타입을 소유하는게 아닌 약한 결합으로)
 
 UseCase의 역할과 책임
    1. 비즈니스 규칙 구현 :
        - UseCase는 비즈니스 규칙과 정책을 구현, 시스템이 특정 작업을 수행할 때 해당 작업과 관련된 모든 규칙과 절차를 관리
        (예를 들어, '사용자 로그인' UseCase는 사용자가 제공한 자격 증명이 유효한지 확인하는 모든 로직을 포함함)
    2. 애플리케이션 로직 처리 :
        - 애플리케이션 로직을 다룸(데이터를 가져오고, 처리하며, 저장하는 과정에서 일어나는 로직을 포함)
        - 데이터베이스에서 데이터를 조회하거나, 외부 API를 호출하여 데이터를 가져와서 그 데이터를 기반으로 비즈니스 규칙을 적용하는 등의 작업이 포함
    3. UI 및 데이터 계층으로부터 독립적 :
        - UseCase는 UI(Presentation Layer)와 데이터 계층(Data Layer)에 대한 구체적인 구현을 몰라야 함(UseCase가 특정 UI프레임워크나 데이터 저장소에 의존하지 않음)
        (대신 UseCase는 인터페이스(Repository Interface)를 통해 필요한 데이터에 접근하고, 이를 통해 데이터 계층의 구현과 분리
    4. 단일 책임 원리 :
        - 각 UseCase는 '하나의 책임'만을 가지도록 설계
        (예를 들어, '상품 구매' UseCase는 상품을 구매하는 과정과 관련된 모든 로직을 처리하지만, 다른 기능(사용자 프로필 업데이트등)은 포함하지 않음
 
 * UseCase가 비즈니스 로직을 처리하므로써 ViewModel과의 역할이 명확하게 구분되고 ViewModel은 PreSentation Layer의 일부로서 View와 UseCase 사이에 중간 역할을 수행한다.
 (UseCase는 '비즈니스 로직' 처리에 집중, ViewModel은 'UI와 관련된 상태 관리'와 '데이터 바인딩'에 초점을 맞춤)
*/

import Foundation

final class MovieUseCase {
    let repository: MovieRepositoryInterface
    
    init(repository: MovieRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchMovies() async throws -> [MovieEntity] {
        let movies = try await repository.fetchMovies() // UseCase는 DTO의 존재와 데이터 계층의 구체적인 구현을 모르는 상태
        return sortMoviesByTitle(movies)
    }
    
    private func sortMoviesByTitle(_ movies: [MovieEntity]) -> [MovieEntity] {
        movies.sorted { $0.title < $1.title }
    }
}
