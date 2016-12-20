//
//  PageViewController.swift
//  iChan
//
//  Created by Hamza Muhammad on 12/17/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPopoverPresentationControllerDelegate, BoardTableViewControllerDelegate {
    
    var pages: [Page] = []
    
    private var boardDict: [String : String] = ["tv" : "Television", "fit" : "Fitness", "pol" : "Politics"]
    
    var orderedViewControllers: [PageTableViewController] = []
    
    private func newPageTableViewController() -> PageTableViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "PageTableViewController") as! PageTableViewController
    }
    
    @IBOutlet var boardButton: UIBarButtonItem!
    
    @IBAction func changeBoard(_ sender: Any) {
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "BoardTableViewController") as! BoardTableViewController
        popoverContent.boardTableViewControllerDelegate = self
        popoverContent.modalPresentationStyle = .popover
        
        if let popover = popoverContent.popoverPresentationController {
            
            popoverContent.preferredContentSize = CGSize(width: 200,height: 300)
            
            popover.barButtonItem = boardButton
            popover.delegate = self
        }
        
        self.present(popoverContent, animated: true, completion: nil)
    }
    
    func didFinishTask(sender: BoardTableViewController, newBoard: String) {
        // do stuff like updating the UI
        boardButton.title = newBoard
    }
    
   func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        
        // get required # of pages
        for i in 0..<pages.count {
            orderedViewControllers.append(newPageTableViewController())
            orderedViewControllers[i].page = pages[i]
        }
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        let defaults = UserDefaults.standard
        if let userBoard = defaults.string(forKey: "board") {
            boardButton.title = "/\(userBoard)/ - \(boardDict[userBoard]!)"
        }
        
        print("got here with: \(pages.count)")
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

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! PageTableViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! PageTableViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
