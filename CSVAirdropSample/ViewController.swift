//
//  ViewController.swift
//  CSVAirdropSample
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.setTitle("Save to CSV", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(export), for: .primaryActionTriggered)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 150).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    struct Tasks {
        let date: String
        let name: String
        let startTime: String
        let endTime: String
        init(_ date: String, _ name: String, _ startTime: String, _ endTime: String) {
            self.date = date
            self.name = name
            self.startTime = startTime
            self.endTime = endTime
        }
    }
    
    // SOURCE: http://www.justindoan.com/tutorials/2016/9/9/creating-and-exporting-a-csv-file-in-swift
    
    @objc internal func export(sender: UIButton) {
        print("✅ Export: \(#function)")
        let fileName = "Tasks.csv"
        guard let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) else { preconditionFailure()}
        var csvText = "Date,Task,Time Started,Time Ended\n"
        let tasks: [Tasks] = [
            Tasks("date1", "name1", "startTime1", "endTime1"),
            Tasks("date2", "name2", "startTime2", "endTime2"),
            Tasks("date3", "name3", "startTime3", "endTime3")
        ]
        for task in tasks {
            let newLine = "\(task.date),\(task.name),\(task.startTime),\(task.endTime)\n"
            csvText.append(contentsOf: newLine)
        }
        do {
            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            print("📝 Wrote CSV")
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
}
