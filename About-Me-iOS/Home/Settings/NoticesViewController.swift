//
//  NoticesViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//

import UIKit

class NoticesViewController: UIViewController {

    @IBOutlet weak var noticesTableView: UITableView!
    var titleItem: [String] = ["개인정보 처리 방침 안내","서비스 이용 약관 안내","운영 정책 변경 안내","업데이트 소식"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayoutInit()
        // Do any additional setup after loading the view.
    }
    
    
    public func setLayoutInit(){
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(noticeBackButtonDidTap))
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationItem.title = "공지 사항"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.gray333]
        noticesTableView.delegate = self
        noticesTableView.dataSource = self
        noticesTableView.separatorColor = .lineEee
        noticesTableView.tableFooterView = UIView()
        noticesTableView.isScrollEnabled = false
    }
    
    
    @objc
    func noticeBackButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NoticesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.image = UIImage(named: "rightblackArrow")
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticesCell", for: indexPath)
        cell.textLabel?.text = titleItem[indexPath.row]
        cell.textLabel?.textColor = .gray333
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        cell.accessoryView = view
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
