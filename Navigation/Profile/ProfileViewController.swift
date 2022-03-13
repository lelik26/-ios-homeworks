//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alex Alex on 23.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {   // установка свойств View
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self   // установка делегата
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint? //
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 0 // желаемая высота ячейки  -не 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
   // private var dataSource: [News.Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.setupNavigationBar()
       self.setupView()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     
       
        
    }
    
    private func setupNavigationBar() {   // установка Navigation controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
        
    }
    
    private func setupView() {     // установка view
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
        
        /// **Создания constrait  for View**
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220) 
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, self.heightConstraint].compactMap({ $0 }))// объявление всех constrait и активирует расчет
    }
    
    
}

private func fetchArticles(completion: @escaping ([News.Article]) -> Void) {
    if let path = Bundle.main.path(forResource: "news", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let news = try self.jsonDecoder.decode(News.self, from: data)
            print("json data: \(news)")
            completion(news.articles)
        } catch let error {
            print("parse error: \(error.localizedDescription)")
        }
    } else {
        fatalError("Invalid filename/path.")
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func buttonPressed (textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 270 : 220
        
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let article = self.dataSource[indexPath.row]
        let postViewModel = PostTableViewCell.PostViewModel(author: article.author,  description: article.description, image: article.image, likes: 2, views: 4)
        
        cell.setup(with: postViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176 // 308  // высота ячейкии heightForRowAt // не должно быть кучу свободного пространства
    }
}



