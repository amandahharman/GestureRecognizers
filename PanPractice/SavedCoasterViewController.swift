//
//  SavedCoasterViewController.swift
//  PanPractice
//
//  Created by Amanda Harman on 3/27/17.
//  Copyright © 2017 Amanda Harman. All rights reserved.
//

import UIKit

class SavedCoasterViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var coasters: [Coaster]!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      for coaster in coasters {
        print("\(coaster.image)")
        print("\(coaster.rotation)")
        print("\(coaster.fontSize)\n")
      }
    }


  func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    if let documentsDirectory = paths.first {
      return documentsDirectory
    }
    return nil
  }

}

extension SavedCoasterViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = coasters?.count {
      return count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SavedCoasterTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! SavedCoasterTableViewCell
    if let coasters = coasters {
      let imageName: String = coasters[indexPath.item].image!
      if let url = getDocumentsDirectory()?.appendingPathComponent(imageName) {
        cell.imageView!.image = UIImage(contentsOfFile: url.path)!
      }
      cell.label.text = "\(coasters[indexPath.item].image!)"

    }
    return cell
  }

}
