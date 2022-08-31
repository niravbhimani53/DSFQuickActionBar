//
//  EphemeralWindow.swift
//
//  Copyright © 2022 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import Foundation
import AppKit

/// A window class that closes when the window resigns its focus (eg clicking outside it)
class EphemeralWindow: NSPanel {
	override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
		super.init(
			contentRect: contentRect,
			styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView],
			backing: backingStoreType,
			defer: flag
		)

		isFloatingPanel = true
		level = .floating

		/// Don't show a window title, even if it's set
		titleVisibility = .hidden
		titlebarAppearsTransparent = true

		hidesOnDeactivate = true

		/// Sets animations accordingly
		animationBehavior = .utilityWindow

		Swift.print("EphemeralWindow: init")
	}

	/// Close automatically when out of focus, e.g. outside click
	override func resignMain() {
		super.resignMain()
		close()
	}

	/// Close and toggle presentation, so that it matches the current state of the panel
	override func close() {
		super.close()
		self.didDetectClose?()
	}

	var didDetectClose: (() -> Void)?

	/// `canBecomeKey` and `canBecomeMain` are both required so that text inputs inside the panel can receive focus
	override var canBecomeKey: Bool {
		return true
	}

	override var canBecomeMain: Bool {
		return true
	}

	deinit {
		Swift.print("EphemeralWindow: deinit")
	}
}
