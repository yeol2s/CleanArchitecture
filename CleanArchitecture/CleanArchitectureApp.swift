//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/28/24.
//
// MARK: - 이 정도 앱에서는 유스케이스나 뷰모델이나 이렇게 분리할 필요가 없지만 예제이므로 참고

import SwiftUI

@main
struct CleanArchitectureApp: App {
    
    // 앱 단위에서 의존성 주입
    var movieListViewModel: MovieListViewModel {
        let repository = MovieRepository()
        let useCase = MovieUseCase(repository: repository)
        return MovieListViewModel(movieUseCase: useCase)
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: movieListViewModel)
        }
    }
}
