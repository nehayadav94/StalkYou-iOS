//
//  ViewController.swift
//  StalkYou
//
//  Created by Neha Yadav on 28/05/16.
//  Copyright © 2016 Neha Yadav. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import Realm
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    
    var renderedMediaModelList = List<MediaModel>()
    var allMediaModelList = List<MediaModel>()
    var paginationObject = PaginationModel()
    
    
    var user_id = "460563723"
    var access_token = "249613285.1677ed0.fe510231e3b640ea8fb361821d663845"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerNib(UINib(nibName: "PostCard", bundle: nil), forCellReuseIdentifier: "PostCard")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.3", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        
        readMediaFromDB()
        fetchData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return renderedMediaModelList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCard", forIndexPath: indexPath) as! PostCard
        let post = renderedMediaModelList[indexPath.row]
        cell.imageViewHeightConstraint.constant = self.getHeightForImageView(post)
        cell.postImage.kf_setImageWithURL(NSURL(string: (post.images?.standard_resolution?.url)!)!)
        cell.captionLabel.text = post.caption?.text
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.renderedMediaModelList[indexPath.row]
        if let caption = model.caption {
            return self.getHeightForImageView(model) + self.calculateHeightForString(caption.text!) + 24
        }
        return self.getHeightForImageView(model) + 16

    }
    
    func fetchData() {
        Alamofire.request(BaseRouter.InstagramRouteManager(InstagramRouter.GetUserMedia(user_id, access_token))).responseString {
            response in
            switch response.result {
            case .Success(let value):
                let responseModel = Mapper<ResponseModel>().map(value)
                self.insertMediaToDB(responseModel!.mediaData.filter({$0.images != nil}))
                self.paginationObject = (responseModel?.pagination)!
                break
                
            case .Failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchNextPage() {
        
        if self.paginationObject.next_url == nil {
            return
        }
        
        Alamofire.request(BaseRouter.InstagramRouteManager(InstagramRouter.GetUserMediaWithURL(self.paginationObject.next_url!))).responseString {
            response in
            switch response.result {
            case .Success(let value):
                let responseModel = Mapper<ResponseModel>().map(value)
                self.insertMediaToDB(responseModel!.mediaData.filter({$0.images != nil}))
                self.paginationObject = (responseModel?.pagination)!
                break
                
            case .Failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func getHeightForImageView(mediaModel: MediaModel) -> CGFloat {
        
        if let height = mediaModel.images?.standard_resolution?.height, width = mediaModel.images?.standard_resolution?.width where width > 0 {
            return CGFloat(height) / CGFloat(width) * UIScreen.mainScreen().bounds.width - 16
        }
        return 0
    }
    
    func calculateHeightForString(text: String) -> CGFloat {
        
        let annotationPadding = CGFloat(24)
        let font = UIFont(name: "Montserrat-Light", size: 12)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        paragraphStyle.lineSpacing = 4.0
        
        
        let rect = NSString(string: text).boundingRectWithSize(CGSize(width: self.tableView.frame.width - 24, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font, NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        
        let descriptionHeight = ceil(rect.height)
        let height = annotationPadding + descriptionHeight
        
        return height
        
    }

    

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterByText(searchText)
    }
    
    func filterByText(keyword: String) {
        
        renderedMediaModelList.removeAll()
        
        for post in allMediaModelList {
            if let _ = post.caption?.text!.rangeOfString(keyword) {
                renderedMediaModelList.append(post)
            }
        }
        
        if keyword == "" {
            renderedMediaModelList = allMediaModelList
        }
        
        tableView.reloadData()
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0 {
            fetchNextPage()
        }
    }
    
    
    func insertMediaToDB(mediaArray: [MediaModel]) {
        let realm = try! Realm()
        
        for media in mediaArray {
            try! realm.write({ () -> Void in
                realm.add(media, update: true)
                readMediaFromDB()
            })
        }
    }
    
    func readMediaFromDB() {
        let realm = try! Realm()
        let mediaData = realm.objects(MediaModel).filter(NSPredicate(format: "user_id == %@", self.user_id))
        self.allMediaModelList.removeAll()
        self.renderedMediaModelList.removeAll()
        for media in mediaData {
            self.allMediaModelList.append(media)
            self.renderedMediaModelList.append(media)
        }
        self.title = renderedMediaModelList.first?.user?.username
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

