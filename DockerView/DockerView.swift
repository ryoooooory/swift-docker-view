//
//  DockerView.swift
//  DockerView
//
//  Created by Ryo Oshima on 2022/07/09.
//

import UIKit

public class DockerView: UIView {
        // View
    private let backView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30.0
        view.layer.masksToBounds = true
        return view
    }()

    let sampleImages = [UIImage(systemName: "message.fill"),
                        UIImage(systemName: "mic.circle.fill"),
                        UIImage(systemName: "envelope.fill"),
                        UIImage(systemName: "waveform.circle.fill"),
                        UIImage(systemName: "macpro.gen1.fill")
    ]

    let sampleColors = [UIColor.red,
                        UIColor.cyan,
                        UIColor.green,
                        UIColor.yellow,
                        UIColor.purple
    ]

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40.0, height: 60.0)
    }

    var contentViews = [UIView]()

    var numberOfViews = 5

    var currentIndex: Int?

    var const: NSLayoutConstraint?

    var heightConstraints = [NSLayoutConstraint]()

    var widthConstraints = [NSLayoutConstraint]()

        // Function
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        guard let touchView = sender.view else { return }
        let transition = sender.location(in: touchView.superview)
        expandViews(calcIndex(currentX: transition.x))
        if sender.state == .ended {
            resetViewSize()
        }
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: nil)
    }

    private func calcIndex(currentX: CGFloat) -> Int {
        var leftPositions = [CGFloat]()
        let currentIndex = currentIndex ?? -10
        var preWidth = 0.0
        for index in 0 ..< contentViews.count {
            var width = 40.0
            var leftMargin = 10.0
            var rightMargin = 10.0
            if index == 0 {
                leftMargin += 10.0
            }
            if index == contentViews.count - 1 {
                rightMargin += 10.0
            }
            if abs(index - currentIndex) == 2 {
                width = 40.0 * 1.2
            } else if abs(index - currentIndex) == 2 {
                width = 40.0 * 1.4
            } else if index == currentIndex {
                width = 40.0 * 1.6
            }
            let sum = preWidth + leftMargin + width + rightMargin
            leftPositions.append(sum)
            preWidth = sum
        }
        return leftPositions.filter { currentX >= $0 }.endIndex
    }

    private func expandViews(_ nextIndex: Int) {
        for index in 0 ..< contentViews.count {
            if nextIndex == index {
                heightConstraints[index].constant = 40 * 1.5
                widthConstraints[index].constant = 40 * 1.5
            } else if abs(nextIndex - index) == 1 {
                heightConstraints[index].constant = 40 * 1.3
                widthConstraints[index].constant = 40 * 1.3
            } else if abs(nextIndex - index) == 2 {
                heightConstraints[index].constant = 40 * 1.1
                widthConstraints[index].constant = 40 * 1.1
            } else {
                heightConstraints[index].constant = 40
                widthConstraints[index].constant = 40
            }
        }
        self.currentIndex = nextIndex
    }

    private func resetViewSize() {
        for index in 0 ..< contentViews.count {
            heightConstraints[index].constant = 40
            widthConstraints[index].constant = 40
        }
        self.currentIndex = nil
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        setConstraints()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                             action: #selector(handleLongPressGesture(sender:)))
        gestureRecognizer.minimumPressDuration = 0.01
        backView.addGestureRecognizer(gestureRecognizer)
    }

    func addSubViews() {
        addSubview(backView)

        for index in 0 ..< numberOfViews {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = sampleImages[index]
            view.backgroundColor = sampleColors[index]
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 8.0
            backView.contentView.addSubview(view)
            contentViews.append(view)
        }
    }

    func setConstraints() {
        backView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true

        var preView: UIView?
        for (index, view) in contentViews.enumerated() {
            if index == 0 {
                view.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0).isActive = true
            } else if index == contentViews.count - 1 {
                guard let preView = preView else {
                    continue
                }
                view.leftAnchor.constraint(equalTo: preView.rightAnchor, constant: 20.0).isActive = true
                view.rightAnchor.constraint(equalTo: rightAnchor, constant: -20.0).isActive = true
            } else {
                guard let preView = preView else {
                    continue
                }
                view.leftAnchor.constraint(equalTo: preView.rightAnchor, constant: 20.0).isActive = true
            }
            view.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
            let heightConstraint = view.heightAnchor.constraint(equalToConstant: 40.0)
            heightConstraint.isActive = true
            heightConstraints.append(heightConstraint)
            let widthConstraint = view.widthAnchor.constraint(equalToConstant: 40.0)
            widthConstraint.isActive = true
            widthConstraints.append(widthConstraint)
            preView = view
        }
    }
}
