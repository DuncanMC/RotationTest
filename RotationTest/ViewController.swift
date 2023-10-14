//
//  ViewController.swift
//  RotationTest
//
//  Created by Duncan Champney on 10/14/23.
//

import UIKit

class ViewController: UIViewController {

    var rotation: UIViewPropertyAnimator?
    
    var isRotating: Bool = false
    @IBOutlet weak var rotationButton: UIButton!
    @IBOutlet weak var rotationDirectionControl: UISegmentedControl!
    
    @IBOutlet weak var football: UILabel!

    
    enum RotationDirection: Int {
        case clockwise
        case counterclockwise
    }
    
    @IBAction func doRotate(_ sender: UIButton) {
        defer {
            let buttonTitle = isRotating ? "Stop rotating" : "Rotate"
            sender.setTitle(buttonTitle, for: .normal)
        }
        if isRotating  {
            isRotating = false
        } else {
            isRotating = true
            rotate()
        }
    }
    
    func rotate() {
        
        guard isRotating else { return }
        
        let rotationAngle = rotationDirectionControl.selectedSegmentIndex == RotationDirection.clockwise.rawValue ? CGFloat.pi/2 : -CGFloat.pi/2
        self.rotation = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.football.transform = self.football.transform.rotated(by: rotationAngle)
        })
        
        self.rotation?.addCompletion { [weak self] (_) in
            self?.rotate()
        }
        self.rotation?.startAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

