//
//  FlareAnimation+UIViewExtension.swift
//  PasswordTextField
//
//  Created by Marlon Raskin on 8/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

extension UIView {
	// "Flare view" animation sequence
	func performFlare() {
		func flare()   { transform = CGAffineTransform(scaleX: 1.2, y: 1.2) }
		func unflare() { transform = .identity }

		UIView.animate(withDuration: 0.3,
					   animations: { flare() },
					   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
	}
}
