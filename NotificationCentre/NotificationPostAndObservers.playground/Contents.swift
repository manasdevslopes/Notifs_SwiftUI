import UIKit


// Define custom notification names
extension Notification.Name {
  static let customNotification = Notification.Name("com.example.customNotification")
  static let randomNotification = Notification.Name("com.example.randomNotification")
}

// Define a class that will observe the notifications
final class Snack {
  let name: String
  let qty: Int
  
  init(_ name: String, _ qty: Int) {
    self.name = name
    self.qty = qty
    // One way
    // addObserver()
    // Other way
    addObserver1()
  }
  deinit { NotificationCenter.default.removeObserver(self) }
  
  func printDescription() {
    print("We have \(qty) \(name)\(qty > 1 ? "s" : "")")
  }
}

// MARK: - Notification Observer
extension Snack {
//  func addObserver() {
//    NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { [weak self] notification in
//      guard let self = self else { return }
//      self.printDescription()
//    }
//  }
  
  private func addObserver1() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .customNotification, object: nil)
  }
  @objc private func handleNotification() {
    printDescription()
  }
}

// Create instances of the Class
let paniPuri = Snack("Pani Puri", 20)
let coffee = Snack("Coffee", 10)
// Post the custom Notification
NotificationCenter.default.post(name: .customNotification, object: nil)

print("I ate all items!")
NotificationCenter.default.post(name: .randomNotification, object: nil)
