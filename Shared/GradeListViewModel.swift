//
//  GradeListViewModel.swift
//  UHGrades (iOS)
//
//  Created by John D. Jackson on 9/19/21.
//

import Combine
import Foundation
import SwiftUI

class GradeListViewModel: ObservableObject {
  @Published var searchTerm: String = ""
  @Published public private(set) var grades: [GradeViewModel] = []
  
  private let dataModel: DataModel = DataModel()
  private var disposables = Set<AnyCancellable>()
  
  init() {
    $searchTerm
      .sink(receiveValue: loadGrades(searchTerm:))
      .store(in: &disposables)
  }
  
  private func loadGrades(searchTerm: String) {
    grades.removeAll()
    
    dataModel.loadGrades(searchTerm: searchTerm) { grades in
      grades.forEach { self.appendGrade(grade: $0) }
    }
  }
  
  private func appendGrade(grade: Grade) {
    let gradeViewModel = GradeViewModel(grade: grade)
    DispatchQueue.main.async {
      self.grades.append(gradeViewModel)
    }
  }
}

class GradeViewModel: Identifiable, ObservableObject {
  let id: Int
  let term: String
  let courseDescription: String
  let catalogNbr: String
  let instructorLast: String
  let instructorFirst: String
  let aCount: String
  let bCount: String
  let cCount: String
  let dCount: String
  let fCount: String
  let satisfactory: String
  let dropCount: String
  let percentA: String
  
  init(grade: Grade) {
    self.id = grade.id
    self.term = grade.term
    self.courseDescription = grade.courseDecription
    self.catalogNbr = grade.catalogNbr
    self.instructorLast = grade.instructorLast
    self.aCount = grade.aCount
    self.bCount = grade.bCount
    self.cCount = grade.cCount
    self.dCount = grade.dCount
    self.fCount = grade.fCount
    self.satisfactory = grade.satisfactory
    self.dropCount = grade.dropCount
    self.percentA = grade.percentA
  }
}
