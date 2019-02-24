
// https://qiita.com/yutat93/items/1b6dfe34fa8537cf3329

import UIKit
import Alamofire //import Alamofire
import SwiftyJSON // import swiftJSON JSON型をData型に変換


class ArticleListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [[String: String?]] = []
    
    let table = UITableView() //add table in propaty
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let article = articles[indexPath.row]
        cell.label.text = article["title"]!
        cell.detailLabel.text = article["userId"]!
        
        return cell
    }
    
    func getArticles() { // Qiitaの情報を持ってくる
        Alamofire.request("https://qiita.com/api/v2/items", method: .get) // method->通信の種類(GET(一方的) or POST(こちらから送る情報によって情報が変わる))
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json.forEach { (_, json) in
                    print(json)
                    let articles: [String: String?] = [ //記事を入れるプロパティ
                        "title": json["title"].string,
                        "userId": json["user"]["id"].string
                    ]
                    self.articles.append(articles)
                }
                self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 90
//        self.tableView.rowHeight = UITableView.automaticDimension // cellの大きさの自動調整
        
//        tableView.delegate = self as! UITableViewDelegate
        tableView.dataSource = self
        
        title = "新着記事"
        
//        table.frame = view.frame // tableの大きさをViewの大きさに合わせる
//        view.addSubview(table) // viewにtableをのせる
//        table.dataSource = self

        getArticles()
    }

}
