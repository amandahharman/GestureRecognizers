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
  var rotation = CGFloat(0)
  var label: DGCurvedLabel!
  var startTransform: CGAffineTransform?
  var deltaAngle: Float = 0
  var prevPoint: CGPoint = CGPoint.zero
  var panGestureRecognizer: UIPanGestureRecognizer!
  @IBOutlet weak var straightLabel: UILabel!
  @IBOutlet var straightLabelPanRecognizer: UIPanGestureRecognizer!
  
  override func viewDidLoad() {
    let label = createOuterLabel()
    circle.addSubview(label)
    panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
    panGestureRecognizer.delegate = self
    label.addGestureRecognizer(panGestureRecognizer)
    label.isUserInteractionEnabled = true

  }
  
  func createOuterLabel() -> DGCurvedLabel {
    let font = UIFont (name: "Arial" , size: CGFloat(22))
    let stringAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: font]
      let curvedLabel: DGCurvedLabel = DGCurvedLabel(frame: self.circle.bounds)
      curvedLabel.attributedText = NSAttributedString(string: "I am testing a label", attributes: stringAttributes)
      curvedLabel.radius = circle.frame.size.width/3
      curvedLabel.rotation = self.rotation
      curvedLabel.textInside = false
      return curvedLabel
  }

  @IBAction func straightLabelPanned(_ sender: UIPanGestureRecognizer) {
    let currentPoint = sender.location(in: self.circle)
    let center = sender.view!.center
    let angle =  atan2f(Float(currentPoint.y) - Float(center.y), Float(currentPoint.x) - Float(center.x)) - atan2f(Float(prevPoint.y) - Float(center.y), Float(prevPoint.x) - Float(center.x))
    prevPoint = sender.location(in: self.circle)
    deltaAngle += angle
    self.straightLabel.transform = startTransform!.rotated(by: CGFloat(deltaAngle))

  }
  
  func panned(recognizer: UIPanGestureRecognizer) {
   
    
    let currentPoint = recognizer.location(in: self.circle)
    let center = recognizer.view!.center
    let angle =  atan2f(Float(currentPoint.y) - Float(center.y), Float(currentPoint.x) - Float(center.x)) - atan2f(Float(prevPoint.y) - Float(center.y), Float(prevPoint.x) - Float(center.x))
    prevPoint = recognizer.location(in: self.circle)
    deltaAngle += angle
    self.label.transform = startTransform!.rotated(by: CGFloat(deltaAngle))
    
    
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    
    if gestureRecognizer == self.panGestureRecognizer {
      startTransform = self.label.transform
    }
    else if gestureRecognizer == straightLabelPanRecognizer {
      startTransform = self.straightLabel.transform
    }
    return true
  }
}

