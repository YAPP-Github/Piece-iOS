//
//  ContactButtonModel.swift
//  MatchResult
//
//  Created by summercat on 2/20/25.
//

import DesignSystem
import Entities
import SwiftUI

struct ContactButtonModel: Equatable, Identifiable {
  let id: String
  let value: String
  var description: String
  var icon: Image
  var smallIcon: Image
  
  init(
    contact: ContactModel
  ) {
    id = contact.type.rawValue
    value = contact.value
    
    description = switch contact.type {
    case .kakao: "카카오톡 아이디"
    case .openKakao: "카카오톡 오픈 채팅방"
    case .instagram: "인스타 아이디"
    case .phone: "전화번호"
    case .unknown: ""
    }
    
    icon = switch contact.type {
    case .kakao: DesignSystemAsset.Icons.kakao32.swiftUIImage
    case .openKakao: DesignSystemAsset.Icons.kakaoOpenchat32.swiftUIImage
    case .instagram: DesignSystemAsset.Icons.instagram32.swiftUIImage
    case .phone: DesignSystemAsset.Icons.cellFill32.swiftUIImage
    case .unknown: Image("")
    }
    
    smallIcon = switch contact.type {
    case .kakao: DesignSystemAsset.Icons.kakao20.swiftUIImage
    case .openKakao: DesignSystemAsset.Icons.kakaoOpenchat20.swiftUIImage
    case .instagram: DesignSystemAsset.Icons.instagram20.swiftUIImage
    case .phone: DesignSystemAsset.Icons.cell20.swiftUIImage
    case .unknown: Image("")
    }
  }
}
