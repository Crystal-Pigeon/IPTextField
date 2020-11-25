# IPTextField

IPTextField is a custom UIView subclass that enables users to easily enter ip addresses. The ip address is validated during typing.

# Using the IPTextField
```swift
import IPTextField
let ipTextField = IPTextField()
```

# Customizing the IPTextField
```swift
ipTextField.lineColor = UIColor.red
ipTextField.textColor = UIColor.purple
ipTextField.borderColor = UIColor.blue
ipTextField.borderWidth = 10
ipTextField.cornerRadius = 10
ipTextField.font = .systemFont(ofSize: 30)
ipTextField.textAlignment = .left
```
Properties that can be changed through interface builder and/or code are:
* line color
* text color
* border color
* border width
* corner radius

Properties that can be changed through code are:
* font
* text alignment

# Functions
## Functions for inserting text
Use the function `insertText(at position: Int, text: String)` to insert text at a certain position in the IPTextField
```swift
try! ipTextField.insertText(at: 0, text: "11")
```
Use the function `insertText(part1: String, part2: String, part3: String, part4: String)` to insert text in the entire IPTextField
```swift
try! ipTextField.insertText(part1: "32", part2: "121", part3: "11", part4: "0")
```
## Functions for getting text
Use the function `text(at position: Int)` to get text from a certain position in the IPTextField
```swift
let text = try! ipTextField.text(at: 0)
```
Use the function `text()` to get text from the IPTextField in an ip address format
```swift
let text2 = ipTextField.text()
```
## Functions for checking the state of the ip text field
To check if the IPTextField is empty use the `isEmpty()` function
```swift
let isEmpty = ipTextField.isEmpty()
```
To check if the IPTextField is completed use the `isCompleted()` function
```swift
let isCompleted = ipTextField.isCompleted()
```
## Functions for clearing the text in the ip text field
```swift
try! ipTextField.clear(at: 0)
ipTextField.clear()
```
# Error handling
```swift
do {
  try ipTextField.insertText(at: 0, text: "aa")
} catch {
  let description = error.localizedDescription //Only digits are allowed
}
```
```swift
do {
  try ipTextField.insertText(at: 9, text: "111")
} catch {
  let description = error.localizedDescription //Position must be between 0 and 3
}
```
```swift
do {
  try ipTextField.insertText(at: 0, text: "256")
} catch {
  let description = error.localizedDescription //Value can not be greater than 255
}
```

# IPTextFieldDelegate
```swift
ipTextField.delegate = self
```
Make the desired object conform to the `IPTextFieldDelegate` protocol and implement the `insertDone()` method
```swift
extension CodeViewController: IPTextFieldDelegate {
    func insertDone() {
        print("insert is finished")
    }
}
```
