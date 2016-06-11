//
//  ViewController.swift
//  LeanCache
//
//  Created by asowers1 on 05/27/2016.
//  Copyright (c) 2016 asowers1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let andrew = ExampleObject(name: "Andrew", age: 24, favoriteLanguage: "Swift")
        let mariah = ExampleObject(name: "Mariah", age: 21, favoriteLanguage: "Objective-C")
        let cache = ExampleObjectCache()
        cache.set(andrew)
        print(cache.get())
        ExampleObjectCache().set(mariah)
        print(ExampleObjectCache().get())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

