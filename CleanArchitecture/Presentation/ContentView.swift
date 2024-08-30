//
//  ContentView.swift
//  CleanArchitecture
//
//  Created by 유성열 on 8/28/24.
//
// MARK: - View는 Presentaion Layer에 해당

/*
 View는 UI를 구성하고 데이터를 표시하는 책임만을 갖는다. (로직이나 상태 관리를 담당하지 않음)
 View의 역할은 사용자에게 UI 요소를 표시하고 사용자와의 상호작용을 처리하는 것
 View는 데이터를 표시하거나, 사용자의 입력을 받아 이를 ViewModel 혹은 Presenter로 전달하는 역할만을 수행한다.
 ----> 어떠한 비즈니스 로직도 포함하지마라, ViewModel(Presentation Layer)이나 Domain Layer에서 처리하도록 전달해라
 */
// View는 데이터를 어디서 어떻게 가져오는지 모른다.(뷰모델이 어떤 로직을 수행하는지 전혀 모름)
// 현재 View는 직접적으로 상태값을 갖지 않고 ViewModel에게 데이터를 가져와서 결과값들을 화면에 뿌려주는 역할을 하고 화면이 나타났을 때 영화를 가져온다는 형태만 처리하도록 되어있음

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.movies, id: \.id) { movie in
                    HStack {
                        Text("\(movie.title)")
                        
                        Text(movie.dateString)
                            .font(.callout)
                    }
                    
                    AsyncImage(url: movie.imageURL) { phase in
                        phase.image?
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .padding()
        .task {
            do {
                try await viewModel.fetchMovies()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: repository에 가짜 (Mock)Repository를 넣어서 테스트를 할 수 있다.
#Preview {
    ContentView(
        viewModel: .init(
            movieUseCase: .init(
                repository: MockMovieRepository()
            )
        )
    )
}
