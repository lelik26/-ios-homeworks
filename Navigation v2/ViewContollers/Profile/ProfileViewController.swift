//
//  ProfileViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    lazy var avatar: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
        imageView.backgroundColor = .black
        imageView.borderWidth = 3.0
        imageView.borderColor = .white
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()
    
    // Mark: - создание кнопки крестик
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.cornerRadius = 20
        button.alpha = 0
        button.clipsToBounds = true
        button.setImage(.init(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCrossButton), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.toAutoLayout()
        return button
    }()
    
    private var dataSource: [ViewModelProtocol] = []
    
    var isLiked: Bool = true
    
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
        tableView.toAutoLayout()
        return tableView
    }()
    
    private var leftXConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    
    private let tapGestureRecogniger = UITapGestureRecognizer()
    
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar("Профиль")
        self.setupView()
        self.setupDataSource()
        self.setupGesture()
        self.setupAlphaView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabBar()
        self.setupNavigationBar("Профиль")
    }
    private func setupDataSource() {
        
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
    
    private func setupView() {     //
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
        ])
    }
    
    private func setupAlphaView() {
        self.view.addSubviews(crossButton, alphaView, avatar)
        self.view.bringSubviews(alphaView, avatar, crossButton)
        
        self.avatar.cornerRadius = avatar.bounds.height / 2
        self.alphaView.alpha = 0
        
        self.leftXConstraint = self.avatar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        self.topConstraint = self.avatar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        self.heightConstraint = avatar.heightAnchor.constraint(equalToConstant: 0)
        self.widthConstraint =  self.avatar.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            self.alphaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.alphaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.alphaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.alphaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            // Mark:- размеры кнопки
            
            self.crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.crossButton.heightAnchor.constraint(equalToConstant: 40),
            self.crossButton.widthAnchor.constraint(equalToConstant: 40),
            
            // Mark:- размеры аватара
            
            self.leftXConstraint,
            self.topConstraint,
            self.heightConstraint,
            self.widthConstraint
        ].compactMap({ $0 }))
        
    }
    private func setupGesture() {
        tapGestureRecogniger.addTarget(self, action: #selector(self.handleTapGesture(_ :)))
        profileHeaderView.avatarImageView.addGestureRecognizer(self.tapGestureRecogniger)
    }
    
    func clickLikesLabel() {
        isLiked.toggle()
        self.tableView.reloadData()
    }
    
    @objc private func handleTapGesture (_ gestureRecognizer: UITapGestureRecognizer){
        guard  self.tapGestureRecogniger === gestureRecognizer else { return }
        self.isExpanded.toggle()
        self.leftXConstraint?.constant = self.isExpanded ?  0 : 16
        self.topConstraint?.constant = self.isExpanded ?  (alphaView.bounds.height - UIScreen.main.bounds.width ) * 0.5  : 16
        
        self.widthConstraint?.constant = self.isExpanded ?  (UIScreen.main.bounds.width) : 0
        self.heightConstraint?.constant = self.isExpanded ? (UIScreen.main.bounds.width) : 0
        
        UIView.animate(withDuration: 0.5) {
            self.avatar.cornerRadius = self.isExpanded ? 0 : self.avatar.bounds.height / 2
            self.alphaView.alpha = self.isExpanded ? 0.6 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in }
        if self.isExpanded {
            self.alphaView.isHidden = false
        }
        UIView.animate(withDuration: 0.3, delay: 0.5 ){
            self.crossButton.alpha = self.isExpanded ? 1 : 0
            self.crossButton.isHidden = false
        } completion: { _ in
            self.crossButton.isHidden = !self.isExpanded
        }
    }
    @objc private func didTapCrossButton() {
        
        self.crossButton.alpha = 0
        self.leftXConstraint?.constant = self.isExpanded ?  16 :  (UIScreen.main.bounds.width) / 2
        self.topConstraint?.constant = self.isExpanded ?   16 :  (UIScreen.main.bounds.height) / 2
        
        self.widthConstraint?.constant = self.isExpanded ?  90 : (UIScreen.main.bounds.width)
        self.heightConstraint?.constant = self.isExpanded ? 90 :  (UIScreen.main.bounds.width)
        self.avatar.cornerRadius = avatar.bounds.height / 2
        
        UIView.animate(withDuration: 0.5) {
            
            self.avatar.cornerRadius = self.avatar.bounds.height / 2
            self.alphaView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in }
        
        UIView.animate(withDuration: 0.3) { //, delay: 0.5
            self.crossButton.alpha = 0
        } completion: { _ in
            self.crossButton.isHidden = false
            self.isExpanded = false
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate, ClickLikesLabelDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return  profileHeaderView
        
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
            cellPhoto.contentMode = .scaleAspectFit
            return cellPhoto
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? PostTableViewCell else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.likesDelegate = self
            var item = self.dataSource[indexPath.row - 1]
            if isLiked {
                item.likes += 1
                isLiked.toggle()
            }
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
            self.pushViewController(PhotosViewController(), "назад")
        } else {
            let vc = DetailedPostViewController()
            var item = dataSource[indexPath.row - 1]
            vc.detailedName = item.author
            vc.detailedImage = item.image
            vc.detailedDescription = item.description
            vc.detailedLike = item.likes
            vc.detailedViews = item.views + 1
            item.views += 1
            self.tableView.reloadRows(at: [indexPath], with: .none)
            self.pushViewController(vc, "назад")
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row != 0 {
            let delete = UIContextualAction(style: .destructive, title: "Удалить") {
                (contextualAction, view, boolValue) in
                self.dataSource.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let swipe = UISwipeActionsConfiguration(actions: [delete])
            return swipe
        }
        else { return nil }
    }
}



















