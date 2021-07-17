//
//  ViewController.swift
//  BottomSheet
//
//  Created by Yegor on 18.07.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    func addBottomSheetView() {
        let bottomSheetVC = BottomSheetViewController()

        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: view.frame.width, height: view.frame.height)
    }

}

