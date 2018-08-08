//
//  ProcessingViewController.swift
//  TU20 App
//
//  Created by Ansar Khan on 2018-07-18.
//  Copyright © 2018 Dean Louizos. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVFoundation
import AVKit

class ProcessingViewController: UIViewController {
    var lines: [Line] = []
    var g = 0
    
    
    //MARK: VARIABLES
    
    //this is all the videos that are in the photos app
    var firstAssets : PHFetchResult<PHAsset>!
    private var generator: AVAssetImageGenerator!
    //this is the most recent video in the photos app
    var recentVideo : PHAsset!
    //we convert the recentVideo into an AVAsset to perform some functions
    var video : AVAsset!
    //this is all the frames of the video
    var frames = [UIImage]()
    //this is all the colors in the video (you can delete this array)
    var color = [UIColor]()
    //this is all the frames, with the colors in the video
    var data = [(UIImage,[UIColor])]()
    let imageManager = PHImageManager()
    //this is the number of pixels we skip while processing the colors (4 x 4 for length by width)
    var pixelsToSkip : Int = 4
    
    override func viewDidLoad() {
        let background = UIView(frame: self.view.frame)
        background.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        view.addSubview(background)
      //  getData()
        
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ProcessingViewController.ani), userInfo: nil, repeats: true)
        
        let center = self.view.center
        let r1: CGFloat = 75
        
        let r2 = (self.view.frame.size.height/2)+100
        for n in 1...12 {
            let theta = CGFloat(2*n-1)*CGFloat.pi/12
            let alpha = CGFloat.pi-theta
            let b = r1/sin(theta)
            let beta = asin(CGFloat(b)*sin(alpha)/r2)
            let gamma = CGFloat.pi-alpha-beta
            
            let t = CGPoint(x: -r2*cos(gamma), y: r2*sin(gamma))
            
            lines.append(Line(angle: theta, length: 200, width: 6, focus: CGPoint(x: center.x+t.x, y: center.y+t.y), r2: self.view.frame.size.height+200))
            view.layer.addSublayer((lines[n-1].layer))
            lines[n-1].animate(duration: 3)
        }
        
        let processing = UILabel()
        processing.text = "Processing..."
        processing.frame.size = CGSize(width: 200, height: 50)
        processing.textAlignment = .center
        processing.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        processing.font = UIFont(name: "Helvetica-Bold", size: 25)
        processing.center = CGPoint(x: self.view.center.x, y: self.view.center.y+120)
        
        let back = UIView()
        back.frame.size = CGSize(width: 200, height: 50)
        back.center = processing.center
        back.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.8862745098, blue: 0.9882352941, alpha: 1)
        back.layer.cornerRadius = 10
        
        view.addSubview(back)
        view.addSubview(processing)
        
       // getData();
        firstAssets =  PHAsset.fetchAssets(with: .video, options: nil)
        recentVideo = firstAssets.lastObject!
        print(recentVideo)
        imageManager.requestAVAsset(forVideo: recentVideo, options: nil) { (recentVideo,_,_) in
            let vid = recentVideo
            self.accessFrame(video: vid!, completion: {frames in
                self.frames = frames
                
                
            })
        }
        
        
        
        
        
    }
    @objc func ani() {
        for n in 1...12 {
            lines[n-1].animate(duration: 3)
        }
        g += 1
        if g == 5 {
            
           present(Results(), animated: true)
            }
    }
    
    //this function accesses all the frames in the video and saves it to the frames global var
    func accessFrame(video: AVAsset, completion: ([UIImage]) -> ()){
        let reader = try! AVAssetReader(asset: video)
        var frames: [UIImage] = [UIImage]()
        let videoTrack = video.tracks(withMediaType: AVMediaType.video)[0]
        
        // read video frames as BGRA
        let trackReaderOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings:[String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)])
        
        reader.add(trackReaderOutput)
        reader.startReading()
        
        while let sampleBuffer = trackReaderOutput.copyNextSampleBuffer() {
            print("sample at time \(CMSampleBufferGetPresentationTimeStamp(sampleBuffer))")
            if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
                // process each CVPixelBufferRef here
                // see CVPixelBufferGetWidth, CVPixelBufferLockBaseAddress, CVPixelBufferGetBaseAddress, etc
                let ciImage = CIImage(cvPixelBuffer: imageBuffer)
                let context = CIContext()
                let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
                frames.append(UIImage(cgImage:cgImage!))
            }
        }
        completion(frames)
        
    }
    
    //Input: The frames of each video. Output: The frame with the colors in the video
    func findColors(image: UIImage) -> (UIImage,[UIColor]) {
        let pixelsWide = Int(image.size.width)
        let pixelsHigh = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return (image,[]) }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var imageColors: [UIColor] = []
        for x in stride(from: 0, to: pixelsWide, by: pixelsToSkip) {
            for y in stride(from: 0, to: pixelsHigh, by: pixelsToSkip) {
                let point = CGPoint(x: x, y: y)
                let pixelInfo: Int = ((pixelsWide * Int(point.y)) + Int(point.x)) * 4
                let color = UIColor(red: CGFloat(data[pixelInfo]) / 255.0,
                                    green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                    blue: CGFloat(data[pixelInfo + 2]) / 255.0,
                                    alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                imageColors.append(color)
            }
        }
        return (image,imageColors)
    }
    
    //this function uses all other functions to get the data
    func getData() {
        firstAssets =  PHAsset.fetchAssets(with: .video, options: nil)
        recentVideo = firstAssets.lastObject!
        print(recentVideo)
        imageManager.requestAVAsset(forVideo: recentVideo, options: nil) { (recentVideo,_,_) in
            let vid = recentVideo
        //    self.accessFrame(video: vid!, completion: <#() -> ()#>)
//            for i in 0..<self.frames.count{
//                self.data.append(self.findColors(image: self.frames[i]))
//            }
        
        }
    }
    
    func isBlack(color: UIColor) -> Bool{
        let sum = color.ciColor.red + color.ciColor.green + color.ciColor.blue
        return sum <= 40
    }
    
    /*SAMPLE INTEGRATION (This could be done in the view did load)
     
             //get all the photos
     
             firstAssets =  PHAsset.fetchAssets(with: .video, options: nil)
             //get the last object
     
             recentVideo = firstAssets.lastObject!
     
             //convert the PHAsset into an AVAsset
             imageManager.requestAVAsset(forVideo: recentVideo, options: nil) { (recentVideo,_,_) in
             let vid = recentVideo
     
             //use access frame to save the frames to the global var called "frames"
             self.accessFrame(video: vid!)
     
             //for every frame get the colors of each frame and store into a 2D array
             for i in 0..<self.frames.count{
             self.data.append(self.findColors(image: self.frames[i]))
             }

     
     }
     
     
    
    */


}
