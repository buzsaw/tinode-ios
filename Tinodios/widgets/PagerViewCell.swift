//
//  PagerViewCell.swift
//  Tinodios
//
//  Copyright © 2023-2025 Tinode LLC. All rights reserved.
//

import SwiftUI

struct PagerViewCell: View {
    let content: UIView

    var body: some View {
        UIViewWrapper(view: content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - UIView Wrapper
private struct UIViewWrapper: UIViewRepresentable {
    let view: UIView

    func makeUIView(context: Context) -> UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed
    }
}
