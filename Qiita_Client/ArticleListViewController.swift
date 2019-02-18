
// https://qiita.com/yutat93/items/1b6dfe34fa8537cf3329

import UIKit
import Alamofire //import Alamofire
import SwiftyJSON

class ArticleListViewController: UIViewController, UITableViewDataSource {
    var articles: [[String: String?]] = []
    
    let table = UITableView() //add table in propaty
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userId"]!
        
        return cell
    }
    
    func getArticles() {
        Alamofire.request("https://qiita.com/api/v2/items", method: .get) // method->通信の種類(GET(一方的) or POST(こちらから送る情報によって情報が変わる))
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json.forEach { (_, json) in
                    let articles: [String: String?] = [ //記事を入れるプロパティ
                        "title": json["title"].string,
                        "userId": json["user"]["id"].string
                    ]
                    self.articles.append(articles)
                }
                self.table.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新着記事"
        
        table.frame = view.frame // tableの大きさをViewの大きさに合わせる
        view.addSubview(table) // viewにtableをのせる
        table.dataSource = self

        getArticles()
    }

}
