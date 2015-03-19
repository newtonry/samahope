//
//  MenuViewController.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var activeViewContainer: UIView!
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setActiveViewController()
    }

    @IBAction func onProgramPress(sender: UIButton) {
        activeViewController = viewControllers[0]
    }
    
    @IBAction func onDoctorPress(sender: UIButton) {
        activeViewController = viewControllers[1]
    }
    
    @IBAction func onTreatmentPress(sender: UIButton) {
        activeViewController = viewControllers[2]
    }
    
    var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            setActiveViewController()
        }
    }
    
    private func setActiveViewController() {
        if isViewLoaded() {
            if let activeVC = activeViewController {
                self.addChildViewController(activeVC)
                activeVC.view.frame = self.activeViewContainer.bounds
                self.activeViewContainer.addSubview(activeVC.view)
//                self.navTitleItem.title = activeVC.title
                activeVC.didMoveToParentViewController(self)
            }
        }
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            inactiveVC.willMoveToParentViewController(nil)
            inactiveVC.view.removeFromSuperview()
            inactiveVC.removeFromParentViewController()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
