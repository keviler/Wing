//
//  PYSlider.swift
//  Demo
//
//  Created by 周朋毅 on 2022/3/23.
//

import SwiftUI

public struct PYSlider: UIViewRepresentable {
    @State private var thumbTintColor: Color = Color.systemYellow
    @State private var trackBackgroundColor: Color = Color.systemGray5
    @State private var trackColor: Color = Color.systemYellow
    var value: Double
    @State private var thumbSize: CGSize = CGSize(width: 15, height: 15)
    @State private var thumbHidden: Bool = false
    var dragBegan: ((Double)->Void)?
    var onDragging: ((Double)->Void)?
    var dragEnded: ((Double)->Void)?

    public class Coordinator {
        var dragBegan: ((Double)->Void)?
        var onDragging: ((Double)->Void)?
        var dragEnded: ((Double)->Void)?

        init(_ dragBegan: ((Double)->Void)?, onDragging: ((Double)->Void)?, dragEnded: ((Double)->Void)?) {
            self.dragBegan = dragBegan
            self.onDragging = onDragging
            self.dragEnded = dragEnded
        }
        @objc func onValueChanged(_ slider: UISlider, event: UIEvent) {
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .began:
                    self.dragBegan?(Double(slider.value))
                case .moved:
                    self.onDragging?(Double(slider.value))
                case .ended:
                    self.dragEnded?(Double(slider.value))
                default:
                    break
                }
            }
        }
    }

    public func makeUIView(context: Context) -> UISlider {
        let sider = UISlider()
        sider.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged(_:event:)), for: .valueChanged)
        return sider
    }
    
    public func updateUIView(_ uiView: UISlider, context: Context) {
        if thumbHidden {
            uiView.setThumbImage(UIImage(), for: .normal)
            uiView.setThumbImage(UIImage(), for: .disabled)
            uiView.isEnabled = false
        } else {
            uiView.setThumbImage(UIImage(named: "slider.thumb"), for: .normal)
        }
        uiView.minimumTrackTintColor = trackColor.toUIColor()
        uiView.maximumTrackTintColor = trackBackgroundColor.toUIColor()
        if !uiView.isTracking {
            uiView.value = Float(value)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(dragBegan, onDragging: onDragging, dragEnded: dragEnded)
    }
    public typealias UIViewType = UISlider
}

public extension PYSlider {
    func thumbHidden(_ hidden: Bool) -> PYSlider {
        thumbHidden = hidden
        return self
    }
    func thumbSize(_ size: CGSize) -> PYSlider {
        thumbSize = size
        return self
    }
    
    func thumbColor(_ color: Color = Color.systemYellow) -> PYSlider {
        thumbTintColor = color
        return self
    }

    func trackColor(_ color: Color) -> PYSlider {
        trackColor = color
        return self
    }
    func trackBackgroundColor(_ color: Color) -> PYSlider {
        trackBackgroundColor = color
        return self
    }
}
