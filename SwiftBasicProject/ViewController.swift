//
//  ViewController.swift
//  SwiftBasicProject
//
//  Created by cs on 2019/7/4.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import SnapKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var box = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tableView:UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        
//        let testObject:WDTest = WDTest.init()
//        testObject.testFun()
//        testObject.stringTest()
//        testObject.arrayTest()
//        testObject.controll()
        
//        let testObject:WDTest1 = WDTest1.init()
//        testObject.pageTest()
        
//        let enumerationTest = WDEnumerationTest.init()
//        enumerationTest.enumerationTest()
        
//        let some = WDSomeClass.init()
//        some.test()
        
//        Alamofire.request("https://httpbin.org/get").responseData { response in
//            debugPrint("All Response Info: \(response)")
//
//            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)")
//            }
//        }
//
//        let parameters: Parameters = [
//            "foo": "bar",
//            "baz": ["a", 1],
//            "qux": [
//                "x": 1,
//                "y": 2,
//                "z": 3
//            ]
//        ]
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters).responseJSON { (response) in
//            debugPrint("All Response Info: \(response)")
//        }
        
        let endpointClosure = { (target: MyService) -> Endpoint in
            return Endpoint(url: URL(target: target).path, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: ["String" : "String"])
        }
        
        // Create this instance at app launch
//        let provider = MoyaProvider(endpointClosure: endpointClosure)
//        provider.request(.createUser(firstName: "James", lastName: "Potter")) { result in
//            // do something with the result (read on for more details)
//        }
        
        // The full request will result to the following:
        // POST https://api.myservice.com/users
        // Request body:
        // {
        //   "first_name": "James",
        //   "last_name": "Potter"
        // }
        
//        provider.request(.updateUser(id: 123, firstName: "Harry", lastName: "Potter")) { result in
//            // do something with the result (read on for more details)
//        }
        
        // The full request will result to the following:
        // POST https://api.myservice.com/users/123?first_name=Harry&last_name=Potter
        
        
        let provider = MoyaProvider<MyService>()
        provider.request(.zen) { result in
            switch result {
            case let .success(moyaResponse):
//                let data = moyaResponse.data // Data, your JSON response is probably in here!
//                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
//                print(self.nsdataToJSON(data: data as NSData)!)
                do {
                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    print(data)
                }
                catch {
                    // show an error to your user
                }
            // do something in your app
            case let .failure(error):
                // TODO: handle the error == best. comment. ever.
                print(error)
            
            }
        }
    }
    
    
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch {
            print(error)
        }
        return nil
    }
    
// MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        
        cell?.textLabel?.text = "这个是标题~"
        cell?.detailTextLabel?.text = "这里是内容了油~"
        cell?.imageView?.image = UIImage(named:"Expense_success")
        return cell!
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

