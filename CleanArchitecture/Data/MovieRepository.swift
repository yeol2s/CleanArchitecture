//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/30/24.
//
// MARK: - Repository
// Interface Adaptor에 속함
/*
 데이터 소스의 구체적인 구현을 추상화하고 비즈니스 로직에게 제공하는 역할(DataLayer - DomainLayer 간의 추상화된 인터페이스 역할을 함)
 여기서는 (API를 통해)네트워크 통신을 진행하여 로우한 데이터를 받아온다. 데이터를 받아 DTO로 변환하여 전달
 
 * Repository의 역할은 데이터 소스(데이터베이스, 네트워크, 파일시스템 등)와 관련된 구체적인 세부 사항은 숨기고 도메인 계층에서 사용할 수 있는 일관된 인터페이스를 제공한다.
    - 데이터 소스와의 상호작용을 추상화하여 클라이언트(UseCase, Domain Layer)는 데이터가 어디에서 오는지, 어떻게 저장되는지에 대해 알 필요가 없다.
    - Repository는 도메인 계층에 속하는 '인터페이스'로 DataLayer는 인터페이스를 구현. 도메인 계층의 비즈니스 로직(UseCase)는 구체적인 DataLayer의 구현체가 아닌, Repository '인터페이스'에 의존
      (UseCase가 Repository 인터페이스를 통해 데이터를 사용한다. - 구체적인 데이터 소스의 구현에 의존하지 않고 추상화된 인터페이스에만 의존하게 됨)
 
 * 상황에 따라 UseCase에서 DTO -> Entity로 변환도 가능할 듯 하다.
 */

import Foundation

final class MovieRepository: MovieRepositoryInterface { // 프로토콜 인터페이스 채택
    func fetchMovies() async throws -> [MovieEntity] {
        let url = URL(string: "https://yts.mx/api/v2/list_movies.json")!
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let movieResponse = try JSONDecoder().decode(BaseResponse<MovieDataDTO>.self, from: data)
        return movieResponse.data.movies.map { $0.toEntity() } // DTO를 Entity로 맵핑하여 MovieEntity 배열로 반환(DTO -> Entity)
    }
}
