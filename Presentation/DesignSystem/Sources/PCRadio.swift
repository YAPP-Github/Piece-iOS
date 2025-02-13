//
//  PCRadio.swift
//  DesignSystem
//
//  Created by 김도형 on 2/13/25.
//

import SwiftUI

public struct PCRadio: View {
    @Binding
    private var isSelected: Bool
    
    public init(isSelected: Binding<Bool>) {
        self._isSelected = isSelected
    }
    
    public var body: some View {
        Button(action: { isSelected.toggle() }) {
            label
        }
        .frame(width: 20, height: 20)
    }
    
    @ViewBuilder
    private var label: some View {
        Circle()
            .fill(isSelected ? .primaryDefault : .clear)
            .padding(4)
            .background {
                Circle()
                    .stroke(
                        isSelected ? .primaryDefault : .grayscaleLight1,
                        lineWidth: 1
                    )
            }
    }
}

@available(iOS 18.0, *)
#Preview {
    @Previewable
    @State var isSelected = false
    
    PCRadio(isSelected: $isSelected)
}
