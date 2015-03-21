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
    
    @IBOutlet weak var programButton: UIView!
    @IBOutlet weak var doctorButton: UIView!
    @IBOutlet weak var activityButton: UIView!
    
    var navButtons:[UIView]?
    
    var viewControllers: [UIViewController] = []
    
    let menuTxtColor = UIColor(red: CGFloat(171/255.0), green: CGFloat(165/255.0), blue: CGFloat(157/255.0), alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setActiveViewController()
        
        self.navButtons = [programButton, doctorButton, activityButton]
        
        let programTap = UITapGestureRecognizer(target: self, action: Selector("onProgramTap"))
        programButton.addGestureRecognizer(programTap)
        
        let doctorTap = UITapGestureRecognizer(target: self, action: Selector("onDoctorTap"))
        doctorButton.addGestureRecognizer(doctorTap)
        
        let activityTap = UITapGestureRecognizer(target: self, action: Selector("onActivityTap"))
        activityButton.addGestureRecognizer(activityTap)

        setCurrentButton(programButton)
    }
    
    func onProgramTap() {
        activeViewController = viewControllers[0]
        setCurrentButton(programButton)
    }
    
    func onDoctorTap() {
        activeViewController = viewControllers[1]
        setCurrentButton(doctorButton)
    }
    
    func onActivityTap() {
        activeViewController = viewControllers[2]
        setCurrentButton(activityButton)
    }
    
    var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            setActiveViewController()
        }
    }
    private func setCurrentButton(button: UIView) {
        for btn in navButtons! {
            if btn === button {
                highlightNavButton(btn)
            } else {
                resetNavButton(btn)
            }
        }
    }
    
    private func highlightNavButton(button: UIView) {
        for sv in button.subviews {
            switch sv {
            case is UILabel:
                highlightLabel(sv as UILabel)
            case is UIImageView:
                highlightImage(sv as UIImageView)
            default:
                println("not handled")
            }
        }
    }
    
    private func resetNavButton(button: UIView) {
        for sv in button.subviews {
            switch sv {
            case is UILabel:
                resetLabel(sv as UILabel)
            case is UIImageView:
                resetImage(sv as UIImageView)
            default:
                println("not handled")
            }
        }
    }
    
    private func highlightLabel(label: UILabel) {
        label.textColor = UIColor.whiteColor()
    }
    
    private func highlightImage(imageView: UIImageView) {
        imageView.image = imageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = UIColor.whiteColor()
    }
    
    private func resetLabel(label: UILabel) {
        label.textColor = menuTxtColor
    }
    
    private func resetImage(imageView: UIImageView) {
        imageView.image = imageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.tintColor = menuTxtColor
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
