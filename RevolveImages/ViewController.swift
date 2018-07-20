//
//  ViewController.swift
//  RevolveImages
//
//  Created by Siya10 on 29/06/18.
//  Copyright © 2018 Siya10. All rights reserved.
//

import UIKit

class NatureCustomCell: UICollectionViewCell {
    @IBOutlet var natureImage: UIImageView?
}

extension Images: InfiniteScollingData {}

class ViewController: UIViewController,UIScrollViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
   @IBOutlet var imageCollection:UICollectionView?
   @IBOutlet var labexIndex:UILabel?
   @IBOutlet var pickerView:UIPickerView?
    
    var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!

    var arrImages:NSArray = ["N1","N2","N3"];
//
//    var arrImages:NSArray = ["N1","N2","N3","N4","N5","N1"];
    var timer:Timer?
    var counter = Int()
    var x = Int()
    var noofLoops:NSInteger?
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 500
        x = 1
        self.labexIndex?.text = String(describing: x)
        noofLoops = (arrImages.count-3) * 100;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let _ = infiniteScrollingBehaviour {}
        else {
            let configuration = CollectionViewConfiguration(layoutType: .fixedSize(sizeValue: 100, lineSpacing: 0), scrollingDirection: .vertical)
            infiniteScrollingBehaviour = InfiniteScrollingBehaviour(withCollectionView: imageCollection!, andData: Images.dummyImages, delegate: self, configuration: configuration)
        }
    }

    @objc func timerAction() {
        
        UIView.animate(withDuration: 0.20) {
            
            let csize = self.infiniteScrollingBehaviour?.collectionView.contentSize;
            
//            //get cell size
//            let cellSize = CGSize(width:self.view.frame.width, height:self.view.frame.height);
//
//            //get current content Offset of the Collection view
//            let contentOffset = self.infiniteScrollingBehaviour.contentOffsetForCollectionView;
//
//            //scroll to next cell
//            self.infiniteScrollingBehaviour.collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
          //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               // self.infiniteScrollingBehaviour.scroll(toElementAtIndex: self.counter)
            
           // }
            if self.counter > (Images.dummyImages.count * 2 * 100) {
                self.counter = 300
                self.x = 1;
                self.labexIndex?.text = String(describing: self.x)
            }
            else {
                let cgrect  = CGRect.init(x: 0, y: self.counter, width:100, height: 300)
                self.imageCollection?.scrollRectToVisible(cgrect, animated: true)            
                self.labexIndex?.text = String(describing: self.x)
                self.x = self.x + 1
            }
            
            self.counter = self.counter+100
        }
        

    /*
       // UIView.animate(withDuration: 0.1) {
//            var visible: [AnyObject] = self.imageCollection!.indexPathsForVisibleItems as [AnyObject]
//            let indexpath: NSIndexPath = (visible[visible.count-1] as! NSIndexPath)
//            let newIndexPath = NSIndexPath.init(row: indexpath.row+1, section: indexpath.section)
        let newIndexPath = NSIndexPath.init(row: counter, section: 0)
        
        if(x! < CGFloat(noofLoops!)){
            
            self.labexIndex?.text = String(describing: counter)
//                self.imageCollection?.selectItem(at: newIndexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
                let cgrect  = CGRect.init(x: (self.imageCollection?.frame.origin.x)!, y: self.x!, width: (self.imageCollection?.frame.size.width)!, height: (self.imageCollection?.frame.size.height)!)
                self.imageCollection?.scrollRectToVisible(cgrect, animated: true)
            }
            else{
//                let newIndexPath = NSIndexPath.init(row: 0, section: 0)
//                self.imageCollection?.selectItem(at: newIndexPath as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.top)
            let cgrect  = CGRect.init(x: 0, y: 0, width: (self.imageCollection?.frame.size.width)!, height: (self.imageCollection?.frame.size.height)!)
            self.imageCollection?.scrollRectToVisible(cgrect, animated: false)
            
                self.stop(_sender: AnyObject.self as AnyObject)
                counter = 0
                self.labexIndex?.text = String(describing: counter)
                x = 0

            }
        counter = counter+1
            x = x!+100
            //}
 */
    }

    @IBAction func start(_sender:AnyObject){
        if(!(timer != nil)){
           timer = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        }
        
    }
    @IBAction func stop(_sender:AnyObject){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
            counter = 300
        }
    }
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return arrImages.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let reuseIdentifier = "NatureCustomCell";
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NatureCustomCell
//
//        let img = arrImages[indexPath.row];
//
//        cell.natureImage?.image = UIImage.init(named: img as! String)
//        return cell
//    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrImages.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = UIColor.clear
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: arrImages[row] as! String)
        view.addSubview(imageView)
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: InfiniteScrollingBehaviourDelegate {
    
    func configuredCell(forItemAtIndexPath indexPath: IndexPath, originalIndex: Int, andData data: InfiniteScollingData, forInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) -> UICollectionViewCell {
        let reuseIdentifier = "NatureCustomCell";
        let cell = imageCollection?.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NatureCustomCell
        let images: Images = data as! Images
        cell.natureImage?.image = UIImage(named: images.name)

//        let imageNames: Images = data as! Images {
//            cell.natureImage?.image = UIImage.init(named: imageNames.name as! String)
//        }
        return cell
    }
}
