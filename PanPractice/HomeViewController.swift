//
//  HomeViewController.swift
//  PanPractice
//
//  Created by Amanda Harman on 3/17/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
  
  @IBOutlet weak var circle: UIImageView!
  var label: DGCurvedLabel!

  
  override func viewDidLoad() {
    label = createOuterLabel()
    circle.addSubview(label)
    createRotateGestureRecognizer(targetView: label)
    createPinchGestureRecognizer(targetView: label)
  }
  
  func createOuterLabel() -> DGCurvedLabel {
    let font = UIFont (name: "Arial" , size: CGFloat(22))
    let stringAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: font]
    let curvedLabel: DGCurvedLabel = DGCurvedLabel(frame: self.circle.bounds)
    curvedLabel.attributedText = NSAttributedString(string: "I am an interesting label", attributes: stringAttributes)
    curvedLabel.radius = circle.frame.size.width/3
    curvedLabel.rotation = 0
    curvedLabel.textInside = false
    curvedLabel.isUserInteractionEnabled = true
    return curvedLabel
  }
  
  
  //MARK: Gesture Recognizers
  func createRotateGestureRecognizer(targetView:UILabel) {
    let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate(_:)))
    targetView.addGestureRecognizer(rotateGesture)
    rotateGesture.delegate = self
  }
  
  func createPinchGestureRecognizer(targetView: UILabel) {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch(_:)))
    targetView.addGestureRecognizer(pinchGesture)
    pinchGesture.delegate = self
  }
  
  func handleRotate(_ recognizer : UIRotationGestureRecognizer) {
    recognizer.view!.transform = recognizer.view!.transform.rotated(by: recognizer.rotation)
    recognizer.rotation = 0
  }
  
  func handlePinch(_ recognizer : UIPinchGestureRecognizer) {
    let label = recognizer.view as! UILabel
    var pinchScale = recognizer.scale
    pinchScale = round(pinchScale * 1000) / 1000.0
    
    
    if (pinchScale < 1) && label.font.pointSize > CGFloat(10) {
      label.font = UIFont( name: "arial", size: label.font.pointSize - pinchScale)
    }
    else if (pinchScale >= 1) && label.font.pointSize < CGFloat(64) {
      label.font = UIFont( name: "arial", size: label.font.pointSize + pinchScale)
    }
  }
  
  //MARK: IBActions
  @IBAction func saveButtonPressed(_ sender: UIButton) {
    print("Saved!")
    let coasterDictionary: [String: Any] = ["image": saveImageAsPNG(image: circle.image)!,
                                            "rotation": label.rotation,
                                            "fontSize": label.font.pointSize]
    Coaster.save(withJSONDictionary: coasterDictionary)
  }
  
  @IBAction func seeSavedButtonPressed(_ sender: UIButton) {

    performSegue(withIdentifier: "toSavedTable", sender: sender)
  }
  

  //MARK: Saving as PNGS
  func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    if let documentsDirectory = paths.first {
      return documentsDirectory
    }
    return nil
  }
  
  /// Saves image as png to document directory. Returns name of image.
  func saveImageAsPNG(image: UIImage?) -> String? {
    if let image = image {
      let imageName = "\(UUID().uuidString).png"
      let imageURL = getDocumentsDirectory()?.appendingPathComponent(imageName)
      if let data = UIImagePNGRepresentation(image) {
        do {
          try data.write(to: imageURL!)
        } catch {
          print("Error saving to URL")
          return nil
        }
      }
      
      return imageName
    }
    return nil
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSavedTable" {
      let destVC: SavedCoasterViewController = segue.destination as! SavedCoasterViewController
      destVC.coasters = Coaster.fetchAllCoasters() as! [Coaster]?
    }
  }
}

