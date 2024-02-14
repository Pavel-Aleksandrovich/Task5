//
//  File.swift
//  Task5
//
//  Created by pavel mishanin on 14/2/24.
//

import UIKit

final class PopoverViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl(items: ["280pt","150pt"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
        
        navigationItem.titleView = segmentedControl
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(exitDidTap))
        
        setSize(0)
    }
    
    @objc func exitDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func valueDidChange() {
        setSize(segmentedControl.selectedSegmentIndex)
    }
    
    func setSize(_ segmentIndex: Int) {
        guard let popover = navigationController?.popoverPresentationController else {return}
        
        switch segmentIndex {
        case 0:
            popover.presentedViewController.preferredContentSize = CGSize(width: 300, height: 280)
        case 1:
            popover.presentedViewController.preferredContentSize = CGSize(width: 300, height: 150)
        default: break
        }
    }
}
