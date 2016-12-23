//
//  ImageViewController.swift
//  iChan
//
//  Created by Hamza Muhammad on 12/23/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var currentImage: UIImage?

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = currentImage!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
