// Add to Tinodios/widgets/PagerView.swift (replace existing content)
import SwiftUI
import UIKit

// MARK: - SwiftUI PagerView
struct PagerView: View {
    let pages: [UIView]
    let onPageSelected: ((Int) -> Void)?

    @State private var currentPage: Int = 0

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                PagerViewCell(content: pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: currentPage) { newValue in
            onPageSelected?(newValue)
        }
        .clipShape(RoundedCornerShape(corners: [.topRight, .bottomRight], radius: 10))
    }
}

// MARK: - Custom Corner Radius Shape
struct RoundedCornerShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - UIKit Wrapper
@IBDesignable
public class PagerViewWrapper: UIView {

    // MARK: - Properties
    public weak var delegate: PagerViewDelegate?

    private var hostingController: UIHostingController<PagerView>?
    private var _pages: [UIView] = []

    public var pages: [UIView] {
        get { _pages }
        set {
            _pages = newValue
            updateSwiftUIView()
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        updateSwiftUIView()
    }

    private func updateSwiftUIView() {
        // Remove old hosting controller
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()

        // Create SwiftUI view
        let swiftUIView = PagerView(pages: _pages) { [weak self] index in
            self?.delegate?.didSelectPage(index: index)
        }

        let hosting = UIHostingController(rootView: swiftUIView)
        hosting.view.backgroundColor = .clear
        hosting.view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(hosting.view)

        NSLayoutConstraint.activate([
            hosting.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hosting.view.topAnchor.constraint(equalTo: topAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        hostingController = hosting
    }

    // MARK: - Public Methods
    public func moveToPage(at index: Int) {
        // This would require exposing state from SwiftUI
        // For now, this is a limitation of the wrapper approach
        // You could use @Published and Combine to bridge this
    }
}

// MARK: - Protocol
public protocol PagerViewDelegate: AnyObject {
    func didSelectPage(index: Int)
}
