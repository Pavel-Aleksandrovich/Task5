//
//  ViewController.swift
//  Task5
//
//  Created by pavel mishanin on 14/2/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var presentButton = BaseButton(text: "Present") { self.showPopover() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(presentButton)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    func showPopover() {
        let popoverContentController = UINavigationController(rootViewController: PopoverViewController())
        popoverContentController.modalPresentationStyle = .popover
        
        if let popoverPresentationController = popoverContentController.popoverPresentationController {
            popoverPresentationController.sourceView = presentButton
            popoverPresentationController.sourceRect = presentButton.bounds
            popoverPresentationController.permittedArrowDirections = [.up, .down]
            
            popoverPresentationController.delegate = self
            
            present(popoverContentController , animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

final class BaseButton: UIButton {
    
    private let tapHandler: (()->())?
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: {
                let scale = self.isHighlighted ? 0.9 : 1
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
            
            if self.isHighlighted {
                tapHandler?()
            }
        }
    }
    
    init(text: String, tapHandler: (()->())? = nil) {
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        
        
        setTitle(text, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        if tintAdjustmentMode == .dimmed {
            tintColor = .systemGray3
            setTitleColor(.systemGray3, for: .normal)
            backgroundColor = .systemGray2
        } else {
            setTitleColor(.white, for: .normal)
            tintColor = .white
            backgroundColor = .systemBlue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
    }
}
