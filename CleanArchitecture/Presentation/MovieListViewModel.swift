//
//  MovieListViewModel.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/31/24.
//
// MARK: - ViewModel
// Presentation Layer 계층에 속함(ViewModel이므로 View를 나타내주기 위한 어떤 로직들을 갖고 있고 뷰의 상태를 관리함)
// 이 정도 규모의 앱에서는 UseCase와 ViewModel을 나누는 경우는 거의 없음
/*
 ViewModel은 View에게 그려질 데이터를 만드는 Presentation 로직의 역할만 수행(View에게 데이터 전달)
 
 클린아키텍처 패턴에서의 ViewModel의 역할 :
    - UI와 관련된 상태 관리와 데이터 바인딩에 초점을 맞춤
    - PreSentation Layer의 일부로서 View와 UseCase 사이에 중간 역할을 수행한다.
    - 사용자 입력을 받아 UseCase에 전달하고, UseCase의 실행 결과를 View가 이해할 수 있는 형식으로 변환하여 제공
    - 비즈니스 로직은 포함하지 않고, 주로 데이터 포맷팅이나 UI 업데이트 로직을 수행
    - View가 표시해야 하는 데이터를 준비하고, View가 바뀌어야 할 때 적절한 알림을 보낼 수 있음
*/

import Foundation

final class MovieListViewModel: ObservableObject {
    @Published private(set) var movies: [PresentingMovie] = [] // 그냥 화면에 데이터만을 뿌려주기 위한 모델로 PresentingMovie 사용
    
    private let movieUseCase: MovieUseCase // 비즈니스 로직을 갖고 있는 UseCase
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies() async throws {
        do {
            let movieEntities = try await movieUseCase.fetchMovies() // 유스케이스로부터 데이터를 가져오고
            let presentingMovies = movieEntities.map {
                // View에 나타내기 어떤 처리(데이터를 표시하기 위한 모델에 맵핑)
                PresentingMovie(id: $0.id, title: $0.title, imageURL: URL(string: $0.imageURL), dateString: $0.uploadedDate.string())
            }
            self.movies = presentingMovies
        } catch {
            print(error)
        }
    }
}
