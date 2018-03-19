# LCDView

LCDView is an iOS custom component that emulates an LCD, or liquid
crystal display. It can be used as a skeuomorphic graphical readout
for text or values in your iOS app.

LCDView is written in Swift 4, and should work on iOS versions back
to at least 7.0.

`LCDView` is a subclass of `UIView`, and it also has some visual properties
settable from Interface Builder, like the color of the LCD "dots" (both
in their on and off state), and the text to display.

The view has a "font" with a repertoire of all the ASCII characters and
punctuation. It can and may be expanded in the future, to include more
Unicode characters. The font consists of 5 by 7 matrices which have their
cell set to 1 or 0 depending on the desired dot state.
