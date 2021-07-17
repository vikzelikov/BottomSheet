//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by Yegor on 18.07.2021.
//

import UIKit

import UIKit

class BottomSheetViewController: UIViewController {
    
    var timer: DispatchSourceTimer?
    var positionY1: CGFloat? = 0
    var positionY2: CGFloat? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        
        startTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // setup
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.positionY2 = self.view.frame.origin.y

        if let y1 = positionY1, let y2 = positionY2 {
            if y2 - y1 > 0 {
                animateViewDown()
            } else if y2 != y1 {
                animateViewUp()
            }
        }
    }

    func startTimer() {
        let queue = DispatchQueue(label: "com.domain.app.timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .milliseconds(500))
        timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.positionY1 = self?.view.frame.origin.y
            }
        }
        timer!.resume()
    }

    func stopTimer() {
        timer = nil
    }
    
    func animateViewUp() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 600
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    func animateViewDown() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        let posY = y + translation.y
        
        if posY > 200 && posY < view.frame.height - 200 {
            self.view.frame = CGRect(x: 0, y: posY, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
}
