//
//  Lotties.swift
//  DesignSystem
//
//  Created by summercat on 2/16/25.
//

public enum Lotties {
  case aiSummaryLarge
  
  public var name: String {
    switch self {
    case .aiSummaryLarge: DesignSystemAsset.Lotties.aiSummaryLarge.name
    }
  }
}
