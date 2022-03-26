//
//  ProfileViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dataSource: [ViewModelProtocol] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPublications()
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
    
    private func setupView() {     //
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
            
            
        ].compactMap({ $0 }))
    }
    
    private func loadPublications() {
        dataSource.append(PostTableViewCell.PostModel(
            author: "Ведьмак",
            description: "Компьютерная игра, которая иммет больше всех наград,Главный герой сериала – ведьмак Геральт, охотник за опасными монстрами, угрожающими человеческому роду. Природа его силы исходит из мутаций, которым он подвергся в детстве: Геральт обрёл ускоренный метаболизм, быструю реакцию и нечеловеческую выносливость. Согласно официальному синопсису, сюжет сериала сфокусируется на истории Геральта, пытающегося отыскать своё место в мире, в котором люди часто оказываются более злыми, чем звери.",
            image: "Ведьмак",
            likes: 120, views: 240))
        dataSource.append(
            PostTableViewCell.PostModel(
                author: "Нетология. Меняем карьеру через образование.",
                description: "от Hello Word до первого сложного IOS - приложения, В каждом есть сила и талант, чтобы добиваться больших целей. Мы помогаем найти путь развития и реализовать себя через профессию — так, как вам этого хочется,Мы поддерживаем в течение всего обучения. Наши кураторы, эксперты и аспиранты не дают студентам сойти с дистанции. Кроме того, мы помогаем с трудоустройством: собрать портфолио, оформить резюме и пройти собеседование. Лучшие студенты стажируются у наших партнёров. ",
                image: "Нетология",
                likes: 20, views: 40))
        dataSource.append(
            PostTableViewCell.PostModel(
                author: "Университет Синергия",
                description: "Наша миссия — синергия многолетних академических традиций и современных образовательных технологий.Уже более 30 лет мы готовим профессионалов, обладающих набором практических знаний и навыков как для запуска и развития собственного бизнеса, так и для работы на управленческих должностях в крупных компаниях.Наша цель — сделать качественное образование доступным каждому.",
                image: "Synergia",
                likes: 120, views: 240))
        dataSource.append(
            PostTableViewCell.PostModel(
                author: "Смурф",
                description: "Смурфы живут в лесу, в средневековой Европе, приблизительно на побережье западной Ирландии (ландштафт в сериале и комиксах наиболее похожий на тен на полуострове Айверах). Поскольку из 6 Смурфов можно сделать золото, Смурфов постоянно пытаются поймать их неприятели, особенно Гаргамель. Смурфы также должны решить и много других проблем в своей деревне и рады всем помогать, даже своим неприятелям.",
                image: "smurf",
                likes: 500, views: 501))
        
    }
    
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func buttonPressed (textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()
            header.delegate = self
            return header
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 232
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellPhoto = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
            return cellPhoto
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? PostTableViewCell else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let item = self.dataSource[indexPath.row - 1]
            let viewModel = PostTableViewCell.PostModel(author: item.author,
                                                        description: item.description,
                                                        image: item.image,
                                                        likes: item.likes,
                                                        views: item.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else { return }
    }
    
}






    
        
       
       
      








 
 
