//: Playground - noun: a place where people can play

import UIKit
import Vision
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// Create Request
let faceDetectionRequest = VNDetectFaceRectanglesRequest()


let image = UIImage(named: "pricing")

let imageView: UIImageView = UIImageView(image: image)
let containerView = UIView(frame: imageView.frame)
containerView.addSubview(imageView)

PlaygroundPage.current.liveView = containerView

// Create Request Handler
if let cgImage = image?.cgImage {
    let requesthHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
    try requesthHandler.perform([faceDetectionRequest])
    
    for observaion in faceDetectionRequest.results as! [VNFaceObservation] {
        let pixelRect = VNImageRectForNormalizedRect(observaion.boundingBox, cgImage.width, cgImage.height)
        print(pixelRect)
        
        // Change Coordinate
        let frame = CGRect(x: pixelRect.minX ,
                           y: containerView.frame.height - (pixelRect.minY + pixelRect.height),
                           width: pixelRect.width, height: pixelRect.height)
        
        DispatchQueue.main.async {
            let rectView = UIView(frame: frame)
            rectView.layer.borderColor = UIColor.red.cgColor
            rectView.layer.borderWidth = 1
            containerView.addSubview(rectView)
        }
    }
    
    PlaygroundPage.finishExecution(PlaygroundPage.current)
}






