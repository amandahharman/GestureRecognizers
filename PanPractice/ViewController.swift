//
//  ViewController.swift
//  PanPractice
//
//  Created by Amanda Harman on 3/17/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
  
  @IBOutlet weak var circle: UIImageView!
  
  override func viewDidLoad() {
    let label = createOuterLabel()
    createRotateGestureRecognizer(targetView: label)
    view.addSubview(label)
  }
  
  func createOuterLabel() -> DGCurvedLabel {
    let font = UIFont (name: "Arial" , size: CGFloat(22))
    let stringAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: font]
      let curvedLabel: DGCurvedLabel = DGCurvedLabel(frame: self.circle.bounds)
      curvedLabel.attributedText = NSAttributedString(string: "I am testing a label", attributes: stringAttributes)
      curvedLabel.radius = circle.frame.size.width/3
      curvedLabel.rotation = 0
      curvedLabel.textInside = false
      curvedLabel.isUserInteractionEnabled = true
      return curvedLabel
  }

  func createRotateGestureRecognizer(targetView:DGCurvedLabel) {
    let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate(_:)))
    targetView.addGestureRecognizer(rotateGesture)
    rotateGesture.delegate = self
  }
  
  func handleRotate(_ recognizer : UIRotationGestureRecognizer) {
    
    recognizer.view!.transform = recognizer.view!.transform.rotated(by: recognizer.rotation)
    recognizer.rotation = 0
  }


}

