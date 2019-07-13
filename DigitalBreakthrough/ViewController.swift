//
//  ViewController.swift
//  DigitalBreakthrough
//
//  Created by Vlad Eliseev on 13/07/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit
import FirebaseMLVision

struct ImageDisplay {
    let file: String
    let name: String
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func makePhotoTapped(_ sender: UIBarButtonItem) {
        print("Making a photo...")
    }
    
    var textRecognizer: VisionTextRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
    }

    @IBAction func findTextTapped(_ sender: UIButton) {
        runTextRecognition(with: imageView.image!)
    }
    
    private func runTextRecognition(with image: UIImage) {
        print("Image recognition...")
        let visionImage = VisionImage(image: image)
        textRecognizer.process(visionImage) { (features, error) in
            self.processResults(from: features, error: error)
        }
    }
    
    func processResults(from text: VisionText?, error: Error?) {
        removeFrames()
        guard let features = text, let image = imageView.image else {return}
        for block in features.blocks {
            for line in block.lines {
                for element in line.elements {
                    self.addFrameView(featureName: element.frame, imageSize: image.size, viewFrame: self.imageView.frame, text: element.text)
                }
            }
        }
    }
    
    func addFrameView(featureName: CGRect, imageSize: CGSize, viewFrame: CGRect, text: String? = nil) {
        print(text ?? "Nil text in addFrameView func")
    }

    
    func removeFrames() {
        print("Removing frames")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // WTF???
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // WTF???
        return 1
    }

}

