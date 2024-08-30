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
// View는 데이터를 어디서 어떻게 가져오는지 모른다.



import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
