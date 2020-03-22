//
//  ColorView.swift
//  PasswordTextField
//
//  Created by Shawn Gee on 3/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ColorBar: UIView {

    // MARK: - Public
    
    var enabledColor = UIColor.red { didSet { updateColor() }}
    var disabledColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1) { didSet { updateColor() }}
    
    var isEnabled = false { didSet { updateColor() }}
    
    
    func flare() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.autoreverse], animations: {
            self.transform = .init(scaleX: 1, y: 1.4)
        }) { _ in
            self.transform = .identity
        }
    }
    
    
    // MARK: - Initializers
    
    convenience init(_ enabledColor: UIColor) {
        self.init(frame: CGRect.zero)
        self.enabledColor = enabledColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Private
    
    private func setup() {
        backgroundColor = disabledColor
        layer.cornerRadius = intrinsicContentSize.height / 2
        setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func updateColor() {
        backgroundColor = isEnabled ? enabledColor : disabledColor
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 60.0, height: 5.0)
    }
}
