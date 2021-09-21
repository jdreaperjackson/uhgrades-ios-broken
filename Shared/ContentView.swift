//
//  ContentView.swift
//  Shared
//
//  Created by John D. Jackson on 9/19/21.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel: GradeListViewModel

  var body: some View {
    NavigationView {
      VStack {
        SearchBar(searchTerm: $viewModel.searchTerm)
        if viewModel.grades.isEmpty {
          EmptyStateView()
        } else {
          List(viewModel.grades) { grade in
            GradeView(grade: grade)
          }
          .listStyle(PlainListStyle())
        }
      }
      .navigationBarTitle("Grade Search")
    }
  }
}

struct GradeView: View {
  @ObservedObject var grade: GradeViewModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(grade.term)
        Text(grade.courseDescription)
        Text(grade.catalogNbr)
        Text(grade.instructorLast)
        Text(grade.instructorFirst)
        Text(grade.aCount)
        Text(grade.bCount)
        Text(grade.cCount)
        Text(grade.dCount)
        Text(grade.fCount)
        Text(grade.satisfactory)
        Text(grade.dropCount)
        Text(grade.perecentA)
          .font(.footnote)
          .foregroundColor(.gray)
      }
    }
    .padding()
  }
}


struct ArtworkView: View {
  let image: Image?
  
  var body: some View {
    ZStack {
      if image != nil {
        image
      } else {
        Color(.systemIndigo)
        Image(systemName: "books.vertical")
          .font(.largeTitle)
          .foregroundColor(.white)
      }
    }
    .frame(width: 50, height: 50)
    .shadow(radius: 5)
    .padding(.trailing, 5)
  }
}

struct EmptyStateView: View {
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: "books.vertical")
        .font(.system(size: 85))
        .padding(.bottom)
      Text("Start searching for grades...")
        .font(.title)
      Spacer()
    }
    .padding()
    .foregroundColor(Color(.systemIndigo))
  }
}

struct SearchBar: UIViewRepresentable {
  typealias UIViewType = UISearchBar
  
  @Binding var searchTerm: String

  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Type a class or instructor name..."
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
  }
  
  func makeCoordinator() -> SearchBarCoordinator {
    return SearchBarCoordinator(searchTerm: $searchTerm)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    @Binding var searchTerm: String
    
    init(searchTerm: Binding<String>) {
      self._searchTerm = searchTerm
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchTerm = searchBar.text ?? ""
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewModel: GradeListViewModel())
    }
}
