//
//  ViewController.swift
//  Delete1x
//
//  Created by Zz on 2019/4/11.
//  Copyright © 2019 Zz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func delete1x(_ sender: Any) {
        let path = "/Users/mac/Desktop/Work/hellotalkfork/HelloTalk_Binary/Resources/Media3.0.xcassets"
        if let subpaths = FileManager.default.subpaths(atPath: path) {
            for subpath in subpaths {
                let tmp = subpath as NSString
                if tmp.pathExtension == "imageset" {
                    let fullpath = "\(path)/\(tmp)"
                    delete1xpng(path: fullpath)
                }
            }
        }
    }
    
    func delete1xpng(path: String) {
        if let subpaths = FileManager.default.subpaths(atPath: path) {
            for subpath in subpaths {
                let tmp = subpath as NSString
                if tmp.pathExtension == "json"  {
                    let jsonPath = "\(path)/\(subpath)"
                    
                    if let data = NSData(contentsOfFile: jsonPath) {
                        if var jsonDic = (try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] {
                            if var images = jsonDic["images"] as? [Any],
                                let first = images.first,
                            let firstDic = first as? [String: String],
                            let scale = firstDic["scale"] {
                                if scale == "1x" {
                                    if let filename = firstDic["filename"] {
                                        
                                        let toRemovePath = "\(path)/\(filename)"
                                      
                                        try? FileManager.default.removeItem(atPath: toRemovePath)
                                            
                                        print("start: \(filename)")
                                        print("delete image succeed")
                                        
                                        images.remove(at: 0)
                                        
                                        jsonDic["images"] = images
                                        
                                        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic) {
                                            let result = (jsonData as NSData).write(toFile: jsonPath, atomically: true)
                                            if result {
                                                print("rewrite json succeed")
                                            }
                                        }
                                        
                                        print("------------\n")

                                        
                                        
                                        

                                        
                                        
                                    }
                                }
                                
                            }
                        }

                    }
                        
                        
                    
                }
            }
        }
    }
    
}

