//
//  ViewController.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //swiftlint:disable force_try
        try! ServiceConfigurator.configure(injector: Environment.injector)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //swiftlint:disable force_try
        try! ServiceConfigurator.configure(injector: Environment.injector)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fooVM = FooViewModel<Environment>()
        let barVM = BarViewModel()
        fooVM.foo.foo()
        barVM.foo.foo()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}
